//
//  AssignViewController.swift
//  MultiSync
//
//  Created by Jun Ho JANG on 2023/09/25.
//

import UIKit
import Combine

protocol AssignViewModel {
    var namePublisher: AnyPublisher<String, Never> { get }
    
    func didPressedNameButton()
}

final class DefaultAssignViewModel: AssignViewModel {
    
    private let name: String = "OEA"
    private let nameSubject: CurrentValueSubject<String, Never> = .init("")
    var namePublisher: AnyPublisher<String, Never> {
        return nameSubject.eraseToAnyPublisher()
    }
    
    init() {
        
    }
    
    func didPressedNameButton() {
        nameSubject.send(name)
    }
    
}

final class AssignViewController: UIViewController {
    
    private let viewModel: AssignViewModel = DefaultAssignViewModel()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let nameButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Set name", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(nameLabel)
        view.addSubview(nameButton)
        
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        nameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        
        nameButton.addTarget(self, action: #selector(didPressButton), for: .touchUpInside)
        
        subscribe(name: viewModel.namePublisher)
    }
    
    private func subscribe(name: AnyPublisher<String, Never>) {
        viewModel.namePublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] name in
                self?.nameLabel.text = name
            })
            .store(in: &cancellables)
    }
    
    @objc func didPressButton(_ sender: UIButton) {
        viewModel.didPressedNameButton()
    }
    
}
