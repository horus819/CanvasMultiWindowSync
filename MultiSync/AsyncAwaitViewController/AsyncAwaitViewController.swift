//
//  AsyncAwaitViewController.swift
//  MultiSync
//
//  Created by Jun Ho JANG on 2023/08/10.
//

import UIKit
import Combine

// MARK: - Data
struct OMGResponseDTO: Decodable {
    let member: [OMGMemberResponseDTO]
}

extension OMGResponseDTO {
    func toDomain() -> OMG {
        return .init(member: member.compactMap { $0.toDomain() })
    }
}

struct OMGMemberResponseDTO: Decodable {
    let activityName: String
    let name: String
    let mbti: String
    
    enum CodingKeys: String, CodingKey {
        case activityName = "activityname"
        case name
        case mbti
    }
}

extension OMGMemberResponseDTO {
    func toDomain() -> OMGMember {
        .init(activityName: activityName, name: name, mbti: mbti)
    }
}

protocol Network {
    func request(with url: URL) async throws -> Data
    func request(with url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
    func request(with url: URL) -> URLSession.DataTaskPublisher
}

final class DefaultNetwork: Network {
    
    init() {
        
    }
    
    func request(with url: URL) async throws -> Data {
        do {
            let requestResult = try await URLSession.shared.data(from: url)
            return requestResult.0
        } catch {
            throw error
        }
    }
    
    func request(with url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: completion)
        task.resume()
    }
    
    func request(with url: URL) -> URLSession.DataTaskPublisher {
        return URLSession.shared.dataTaskPublisher(for: url)
    }
    
}

protocol DataTransferService {
    func request(with url: URL) async throws -> OMGResponseDTO
    func request(with url: URL, completion: @escaping (Result<OMGResponseDTO, Error>) -> Void)
    func request(with url: URL) -> AnyPublisher<OMGResponseDTO, Error>
}

enum NetworkError: Error {
    case responseError
    case data
    case statusCode
    case unknownStatus
    case decoding
}

final class DefaultDataTransferService: DataTransferService {
    
    private let network: Network
    private let decoder: JSONDecoder
    
    init() {
        self.network = DefaultNetwork()
        self.decoder = JSONDecoder()
    }
    
    func request(with url: URL) async throws -> OMGResponseDTO {
        do {
            let data = try await network.request(with: url)
            let responseDTO = try decoder.decode(OMGResponseDTO.self, from: data)
            return responseDTO
        } catch {
            throw error
        }
    }
    
    func request(with url: URL, completion: @escaping (Result<OMGResponseDTO, Error>) -> Void) {
        network.request(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            } else {
                guard let httpURLResponse = response as? HTTPURLResponse else {
                    DispatchQueue.main.async {
                        completion(.failure(NetworkError.responseError))
                    }
                    return
                }
                switch httpURLResponse.statusCode {
                case 200:
                    guard let data = data else {
                        DispatchQueue.main.async {
                            completion(.failure(NetworkError.data))
                        }
                        return
                    }
                    do {
                        let decoded = try self.decoder.decode(OMGResponseDTO.self, from: data)
                        DispatchQueue.main.async {
                            completion(.success(decoded))
                        }
                    } catch {
                        DispatchQueue.main.async {
                            completion(.failure(NetworkError.decoding))
                        }
                        
                    }
                    
                case 300...500:
                    DispatchQueue.main.async {
                        completion(.failure(NetworkError.statusCode))
                    }
                    
                default:
                    DispatchQueue.main.async {
                        completion(.failure(NetworkError.unknownStatus))
                    }
                    
                }
            }
        }
    }
    
    func request(with url: URL) -> AnyPublisher<OMGResponseDTO, Error> {
        return network.request(with: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: OMGResponseDTO.self, decoder: decoder)
            .mapError { error in
                return error
            }
            .eraseToAnyPublisher()
    }
    
}

// MARK: - Repository
struct OMG {
    let member: [OMGMember]
}

struct OMGMember {
    let activityName: String
    let name: String
    let mbti: String
}

protocol AsyncAwaitRepository {
    func request() async throws -> OMG
    func request(completion: @escaping (Result<OMG, Error>) -> Void)
    func request() -> AnyPublisher<OMG, Error>
}

final class DefaultAsyncAwaitRepository: AsyncAwaitRepository {
    
    private let dataTransferService: DataTransferService
    private let url: URL
    
    init() {
        self.dataTransferService = DefaultDataTransferService()
        self.url = URL(string: "https://544a9ef9-2c3c-441a-824b-97788c0761e8.mock.pstmn.io/omgtest/main/group") ?? .init(filePath: "")
    }
    
    func request() async throws -> OMG {
        do {
            let responseDTO = try await dataTransferService.request(with: url)
            let domainEntity = responseDTO.toDomain()
            return domainEntity
        } catch let error {
            throw error
        }
    }
    
    func request(completion: @escaping (Result<OMG, Error>) -> Void) {
        dataTransferService.request(with: url) { result in
            switch result {
            case .success(let data):
                let domainEntity = data.toDomain()
                completion(.success(domainEntity))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func request() -> AnyPublisher<OMG, Error> {
        dataTransferService.request(with: url)
            .tryMap { data in
                return data.toDomain()
            }
            .mapError({ error in
                return error
            })
            .eraseToAnyPublisher()
    }
    
}

// MARK: - Domain
protocol AsyncAwaitUseCase {
    func executeRequest() async throws -> OMG
    func executeRequest(completion: @escaping (Result<OMG, Error>) -> Void)
    func executeRequest() -> AnyPublisher<OMG, Error>
}

final class DefaultAsyncAwaitUseCase: AsyncAwaitUseCase {
    
    private let repository: AsyncAwaitRepository
    
    init() {
        self.repository = DefaultAsyncAwaitRepository()
    }
    
    func executeRequest() async throws -> OMG {
        do {
            let domainEntity = try await repository.request()
            return domainEntity
        } catch {
            throw error
        }
    }
    
    func executeRequest(completion: @escaping (Result<OMG, Error>) -> Void) {
        repository.request(completion: completion)
    }
    
    func executeRequest() -> AnyPublisher<OMG, Error> {
        repository.request()
    }
    
}

// MARK: - ViewModel
enum AsyncAwaitViewModelError: Error {
    case emptyInstance
}

protocol AsyncAwaitViewModel: OMGMemberDataSource {
    var omgPublisher: AnyPublisher<OMG, Never> { get }
    var requestErrorPublisher: AnyPublisher<Error, Never> { get }
    var omgMemberListViewModel: [OMGMemberListViewModel] { get }
    
    func didPressedRequestButton() async
    func didPressedRequestButton()
    func didPressedRequestButtonWithCombine() -> AnyCancellable
}

final class DefaultAsyncAwaitViewModel: AsyncAwaitViewModel {
    
    private let useCase: AsyncAwaitUseCase
    
    private var omg: OMG
    private var omgMember: [OMGMember]
    private(set) var omgMemberListViewModel: [OMGMemberListViewModel]
    private let omgSubject: CurrentValueSubject<OMG, Never>
    private let requestError: PassthroughSubject<Error, Never>
    
    var omgPublisher: AnyPublisher<OMG, Never> {
        omgSubject.eraseToAnyPublisher()
    }
    
    var requestErrorPublisher: AnyPublisher<Error, Never> {
        requestError.eraseToAnyPublisher()
    }
    
    init() {
        self.useCase = DefaultAsyncAwaitUseCase()
        self.omg = .init(member: [])
        self.omgMember = []
        self.omgMemberListViewModel = .init([])
        self.omgSubject = .init(.init(member: []))
        self.requestError = .init()
    }
    
    func didPressedRequestButton() async {
        do {
            let omg = try await useCase.executeRequest()
            self.omg = omg
            self.omgSubject.send(self.omg)
            self.omgMember = omg.member
            self.omgMemberListViewModel = self.omgMember.map { .init(omgMember: $0)}
        } catch let error {
            requestError.send(error)
        }
    }
    
    func didPressedRequestButton() {
        useCase.executeRequest { result in
            switch result {
            case .success(let omg):
                self.omg = omg
                self.omgSubject.send(self.omg)
                self.omgMember = omg.member
                self.omgMemberListViewModel = self.omgMember.map { .init(omgMember: $0)}
                
            case .failure(let error):
                self.requestError.send(error)
                
            }
        }
    }
    
    func didPressedRequestButtonWithCombine() -> AnyCancellable {
        let cancellable = useCase.executeRequest()
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    return
                    
                case .failure(let error):
                    self?.requestError.send(error)
                    
                }
            } receiveValue: { [weak self] omg in
                guard let self = self else {
                    self?.requestError.send(AsyncAwaitViewModelError.emptyInstance)
                    return
                }
                self.omg = omg
                self.omgSubject.send(self.omg)
                self.omgMember = omg.member
                self.omgMemberListViewModel = self.omgMember.map { .init(omgMember: $0)}
            }
        return cancellable
    }
    
}

extension DefaultAsyncAwaitViewModel: OMGMemberDataSource {
    func numberOfMember() -> Int {
        return omgMember.count
    }
    
    func loadMember(at index: IndexPath) -> OMGMember {
        return omgMember[index.row]
    }
}

struct OMGMemberListViewModel {
    let name: String
}

extension OMGMemberListViewModel {
    init(omgMember: OMGMember) {
        self.name = omgMember.name
    }
}

// MARK: - View
final class AsyncAwaitViewController: UIViewController {
    
    private let requestButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Request", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private let omgMemberListTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let viewModel: AsyncAwaitViewModel = DefaultAsyncAwaitViewModel()
    private var omgMemberListAdapter: OMGMemberListAdapter?
    
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(requestButton)
        view.addSubview(omgMemberListTableView)
        
        requestButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        requestButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        omgMemberListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        omgMemberListTableView.topAnchor.constraint(equalTo: requestButton.bottomAnchor).isActive = true
        omgMemberListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        omgMemberListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        omgMemberListAdapter = OMGMemberListAdapter(tableView: omgMemberListTableView, dataSource: viewModel, delegate: self)
        
        addActionForRequestButton()
        
        subscribeOMG(from: viewModel)
        subscribeRequestError(from: viewModel)
    }
    
    private func addActionForRequestButton() {
        requestButton.addTarget(self, action: #selector(requestButtonAction), for: .touchUpInside)
    }
    
    @objc func requestButtonAction(_ sender: UIButton) {
        // MARK: - Async, Await
//        Task {
//            await viewModel.didPressedRequestButton()
//        }
        // MARK: - Completion
        viewModel.didPressedRequestButton()
        // MARK: - Combine
//        viewModel.didPressedRequestButtonWithCombine()
//            .store(in: &cancellables)
    }
    
    private func presentAlert(of error: Error) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: UIAlertController.Style.alert)
            let addAlertAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(addAlertAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func subscribeOMG(from viewModel: AsyncAwaitViewModel) {
        viewModel.omgPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] omg in
                self?.omgMemberListTableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    private func subscribeRequestError(from viewModel: AsyncAwaitViewModel) {
        viewModel.requestErrorPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] requestError in
                self?.presentAlert(of: requestError)
            }
            .store(in: &cancellables)
    }
}

final class OMGListTableViewCell: UITableViewCell {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(nameLabel)
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func apply(vieWModel: OMGMemberListViewModel) {
        nameLabel.text = vieWModel.name
    }
    
}

extension AsyncAwaitViewController: OMGMemberDelegate {
    func heightForRow(at indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

protocol OMGMemberDataSource: AnyObject {
    func numberOfMember() -> Int
    func loadMember(at index: IndexPath) -> OMGMember
    
}

protocol OMGMemberDelegate: AnyObject {
    func heightForRow(at indexPath: IndexPath) -> CGFloat
}

final class OMGMemberListAdapter: NSObject {
    
    private let tableView: UITableView
    private weak var dataSource: OMGMemberDataSource?
    private weak var delegate: OMGMemberDelegate?

    init(tableView: UITableView, dataSource: OMGMemberDataSource?, delegate: OMGMemberDelegate) {
        tableView.register(OMGListTableViewCell.self, forCellReuseIdentifier: "OMGListTableViewCell")
        
        self.tableView = tableView
        self.dataSource = dataSource
        self.delegate = delegate
        super.init()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

extension OMGMemberListAdapter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dataSource = dataSource else { return .init() }
        return dataSource.numberOfMember()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OMGListTableViewCell", for: indexPath) as? OMGListTableViewCell else { return .init() }
        guard let dataSource = dataSource else { return .init() }
        let member = dataSource.loadMember(at: indexPath)
        cell.apply(vieWModel: .init(omgMember: member))
        return cell
    }
}

extension OMGMemberListAdapter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return delegate?.heightForRow(at: indexPath) ?? 0
    }
}
