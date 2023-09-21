//
//  DynamicCellViewController.swift
//  MultiSync
//
//  Created by Jun Ho JANG on 2023/09/12.
//

import UIKit

final class DynamicCellViewController: UIViewController {
    
    private let scheduleTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    private let viewModel: ScheduleViewModel = DefaultScheduleViewModel(schedule: [.init(title: "XCode", detail: "Break", date: Date()), .init(title: "Compiler", detail: nil, date: nil), .init(title: "Runtime", detail: nil, date: nil), .init(title: "Error", detail: "Resolve", date: Date())])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        scheduleTableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: "ScheduleCellID")
        scheduleTableView.delegate = self
        scheduleTableView.dataSource = self
        addSubviews()
        setScheduleTableViewLayout()
    }
    
}

extension DynamicCellViewController {
    private func addSubviews() {
        view.addSubview(scheduleTableView)
    }
    
    private func setScheduleTableViewLayout() {
        scheduleTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scheduleTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scheduleTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scheduleTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension DynamicCellViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCellID", for: indexPath) as? ScheduleTableViewCell else { return .init() }
        cell.configure(with: viewModel.items[indexPath.row])
        return cell
    }
}

extension DynamicCellViewController: UITableViewDelegate {

}

final class ScheduleTableViewCell: UITableViewCell {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .blue
        return label
    }()
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .blue
        return label
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .blue
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "ScheduleCellID")
        addSubviews()
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure(with viewModel: ScheduleItemViewModel) {
        titleLabel.text = viewModel.title
        if let detail = viewModel.detail {
            detailLabel.text = detail
        } else {
            stackView.removeArrangedSubview(detailLabel)
            detailLabel.removeFromSuperview()
        }
        if let date = viewModel.date {
            dateLabel.text = date.description
        } else {
            stackView.removeArrangedSubview(dateLabel)
            dateLabel.removeFromSuperview()
        }
    }
    
    private func addSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(detailLabel)
        stackView.addArrangedSubview(dateLabel)
    }
    
    private func setLayout() {
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
}

struct Schedule {
    let title: String
    let detail: String?
    let date: Date?
}

protocol ScheduleViewModel {
    var items: [ScheduleItemViewModel] { get }
}

final class DefaultScheduleViewModel: ScheduleViewModel {
    
    private(set) var items: [ScheduleItemViewModel]
    
    init(schedule: [Schedule]) {
        self.items = schedule.map { .init(title: $0.title, detail: $0.detail, date: $0.date) }
    }
    
}

struct ScheduleItemViewModel {
    let title: String
    let detail: String?
    let date: Date?
}
