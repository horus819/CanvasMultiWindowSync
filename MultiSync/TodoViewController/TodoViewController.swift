//
//  TodoViewController.swift
//  MultiSync
//
//  Created by Jun Ho JANG on 2023/09/11.
//

import UIKit

final class TodoViewController: UIViewController {
    
    private let tableStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    private let todoTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .blue
        return tableView
    }()
    private let doingTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .yellow
        return tableView
    }()
    private let doneTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemPink
        return tableView
    }()
    private let pendingTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .green
        return tableView
    }()
    private let viewModel: TodoViewModel! = DefaultTodoViewModel(todos: [.init(todoState: .todo, todoTitle: "OEA S IY", todoDate: Date())], doings: [.init(todoState: .todo, todoTitle: "OEA O S P L", todoDate: Date())], dones: [.init(todoState: .todo, todoTitle: "OEA YN S", todoDate: Date())], pendings: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setLayout()
        todoTableView.register(TodoCell.self, forCellReuseIdentifier: "CellID")
        doingTableView.register(TodoCell.self, forCellReuseIdentifier: "CellID")
        doneTableView.register(TodoCell.self, forCellReuseIdentifier: "CellID")
        pendingTableView.register(TodoCell.self, forCellReuseIdentifier: "CellID")
        
        todoTableView.dataSource = self
        doingTableView.dataSource = self
        doneTableView.dataSource = self
        pendingTableView.dataSource = self
        
        todoTableView.delegate = self
        doingTableView.delegate = self
        doneTableView.delegate = self
        pendingTableView.delegate = self
    }
    
}

extension TodoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == todoTableView {
            return viewModel.todoItems.count
        } else if tableView == doingTableView {
            return viewModel.doingItems.count
        } else if tableView == doneTableView {
            return viewModel.doneItems.count
        } else if tableView == pendingTableView {
            return viewModel.pendingItems.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath) as? TodoCell else { return .init() }
        if tableView == todoTableView {
            cell.configure(with: viewModel.todoItems[indexPath.row])
            return cell
        } else if tableView == doingTableView {
            cell.configure(with: viewModel.doingItems[indexPath.row])
            return cell
        } else if tableView == doneTableView {
            cell.configure(with: viewModel.doneItems[indexPath.row])
            return cell
        } else if tableView == pendingTableView {
            cell.configure(with: viewModel.pendingItems[indexPath.row])
            return cell
        } else {
            return cell
        }
    }
}

extension TodoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

extension TodoViewController {
    private func addSubviews() {
        view.addSubview(tableStackView)
        tableStackView.addArrangedSubview(todoTableView)
        tableStackView.addArrangedSubview(doingTableView)
        tableStackView.addArrangedSubview(doneTableView)
        tableStackView.addArrangedSubview(pendingTableView)
    }
    
    private func setLayout() {
        tableStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableStackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

final class TodoCell: UITableViewCell {
    
    private let todoTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "CellID")
        addSubview(todoTitle)
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure(with viewModel: TodoItemViewModel) {
        todoTitle.text = viewModel.todoTitle
    }
    
    private func setLayout() {
        todoTitle.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        todoTitle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
}

struct TodoItemViewModel {
    let todoTitle: String
}

struct TodoItem {
    enum TodoState {
        case todo
        case doing
        case done
        case pending
    }
    
    let todoState: TodoState
    let todoTitle: String
    let todoDate: Date
}

protocol TodoViewModel {
    var todoItems: [TodoItemViewModel] { get }
    var doingItems: [TodoItemViewModel] { get }
    var doneItems: [TodoItemViewModel] { get }
    var pendingItems: [TodoItemViewModel] { get }
}

final class DefaultTodoViewModel: TodoViewModel {
    
    private(set) var todoItems: [TodoItemViewModel]
    private(set) var doingItems: [TodoItemViewModel]
    private(set) var doneItems: [TodoItemViewModel]
    private(set) var pendingItems: [TodoItemViewModel]
    
    init(todos: [TodoItem], doings: [TodoItem], dones: [TodoItem], pendings: [TodoItem]) {
        self.todoItems = todos.map { .init(todoTitle: $0.todoTitle) }
        self.doingItems = doings.map { .init(todoTitle: $0.todoTitle) }
        self.doneItems = dones.map { .init(todoTitle: $0.todoTitle) }
        self.pendingItems = pendings.map { .init(todoTitle: $0.todoTitle) }
    }
    
    //
    
    func todoToDoing() {
        
    }
    
    func todoToDone() {
        
    }
    
    func todoToPending() {
        
    }
    
    //
    
    func doingToTodo() {
        
    }
    
    func doingToDone() {
        
    }
    
    func doingToPending() {
        
    }
    
    //
    
    func doneToTodo() {
        
    }
    
    func doneToDoing() {
        
    }
    
    func doneToPending() {
        
    }
    
    //
    
    func pendingToTodo() {
        
    }
    
    func pendingToDoing() {
        
    }
    
    func pendingToDone() {
        
    }
    
}
