//
//  SelectionButtonsViewController.swift
//  MultiSync
//
//  Created by Jun Ho JANG on 2023/08/08.
//

import UIKit

final class SelectionButtonsViewController: UIViewController {
    
    private var viewModel: SelectionButtonsViewModel! = DefaultSelectionButtonsViewModel(selections: .init())
    
    private let countButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Count", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    private let selectButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let selectButtons: [UIButton] = {
        var buttons: [UIButton] = []
        for _ in 0...6 {
            buttons.append(UIButton())
        }
        buttons.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        return buttons
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(selectButtonStackView)
        view.addSubview(countButton)
        
        selectButtonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        selectButtonStackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        selectButtonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        selectButtonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        selectButtonStackView.addArrangedSubview(countButton)
        
        selectButtons.forEach { selectButtonStackView.addArrangedSubview($0) }
        
        selectButtonStackView.addArrangedSubview(countLabel)
        
        addActions(to: selectButtons)
        addAction(to: countButton)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handle(notification:)), name: SelectionButtonsViewModelUpdateEvent.selectionButtonsNotificaitonName, object: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setDefaultValue(of: selectButtons, from: viewModel)
        guard let viewModel = viewModel as? DefaultSelectionButtonsViewModel else { return }
        SelectionButtonsViewModelController.shared.receive(viewModel: viewModel)
    }
    
    private func setDefaultValue(of buttons: [UIButton], from viewModel: SelectionButtonsViewModel) {
        for i in 0..<viewModel.isSelectedArray.count {
            setChangedValue(from: viewModel.isSelectedArray[i], to: buttons[i])
        }
    }
    
    private func setChangedValue(from isSelected: Bool, to button: UIButton) {
        if isSelected {
            button.setTitle("Selected", for: .normal)
            button.setTitleColor(.blue, for: .normal)
        } else {
            button.setTitle("Unselected", for: .normal)
            button.setTitleColor(.red, for: .normal)
        }
    }
    
    private func addActions(to buttons: [UIButton]) {
        buttons[0].addTarget(self, action: #selector(setIsSelected0), for: .touchUpInside)
        buttons[1].addTarget(self, action: #selector(setIsSelected1), for: .touchUpInside)
        buttons[2].addTarget(self, action: #selector(setIsSelected2), for: .touchUpInside)
        buttons[3].addTarget(self, action: #selector(setIsSelected3), for: .touchUpInside)
        buttons[4].addTarget(self, action: #selector(setIsSelected4), for: .touchUpInside)
        buttons[5].addTarget(self, action: #selector(setIsSelected5), for: .touchUpInside)
        buttons[6].addTarget(self, action: #selector(setIsSelected6), for: .touchUpInside)
    }
    
    @objc func setIsSelected0(_ sender: UIButton) {
        viewModel.toggleSelection(at: 0)
        if viewModel.isSelectedArray[0] {
            selectButtons[0].setTitle("Selected", for: .normal)
            selectButtons[0].setTitleColor(.blue, for: .normal)
        } else {
            selectButtons[0].setTitle("Unselected", for: .normal)
            selectButtons[0].setTitleColor(.red, for: .normal)
        }
        guard let viewModel = viewModel as? DefaultSelectionButtonsViewModel else { return }
        SelectionButtonsViewModelController.shared.receive(viewModel: viewModel)
    }
    
    @objc func setIsSelected1(_ sender: UIButton) {
        viewModel.toggleSelection(at: 1)
        if viewModel.isSelectedArray[1] {
            selectButtons[1].setTitle("Selected", for: .normal)
            selectButtons[1].setTitleColor(.blue, for: .normal)
        } else {
            selectButtons[1].setTitle("Unselected", for: .normal)
            selectButtons[1].setTitleColor(.red, for: .normal)
        }
        guard let viewModel = viewModel as? DefaultSelectionButtonsViewModel else { return }
        SelectionButtonsViewModelController.shared.receive(viewModel: viewModel)
    }
    @objc func setIsSelected2(_ sender: UIButton) {
        viewModel.toggleSelection(at: 2)
        if viewModel.isSelectedArray[2] {
            selectButtons[2].setTitle("Selected", for: .normal)
            selectButtons[2].setTitleColor(.blue, for: .normal)
        } else {
            selectButtons[2].setTitle("Unselected", for: .normal)
            selectButtons[2].setTitleColor(.red, for: .normal)
        }
        guard let viewModel = viewModel as? DefaultSelectionButtonsViewModel else { return }
        SelectionButtonsViewModelController.shared.receive(viewModel: viewModel)
    }
    @objc func setIsSelected3(_ sender: UIButton) {
        viewModel.toggleSelection(at: 3)
        if viewModel.isSelectedArray[3] {
            selectButtons[3].setTitle("Selected", for: .normal)
            selectButtons[3].setTitleColor(.blue, for: .normal)
        } else {
            selectButtons[3].setTitle("Unselected", for: .normal)
            selectButtons[3].setTitleColor(.red, for: .normal)
        }
        guard let viewModel = viewModel as? DefaultSelectionButtonsViewModel else { return }
        SelectionButtonsViewModelController.shared.receive(viewModel: viewModel)
    }
    @objc func setIsSelected4(_ sender: UIButton) {
        viewModel.toggleSelection(at: 4)
        if viewModel.isSelectedArray[4] {
            selectButtons[4].setTitle("Selected", for: .normal)
            selectButtons[4].setTitleColor(.blue, for: .normal)
        } else {
            selectButtons[4].setTitle("Unselected", for: .normal)
            selectButtons[4].setTitleColor(.red, for: .normal)
        }
        guard let viewModel = viewModel as? DefaultSelectionButtonsViewModel else { return }
        SelectionButtonsViewModelController.shared.receive(viewModel: viewModel)
    }
    @objc func setIsSelected5(_ sender: UIButton) {
        viewModel.toggleSelection(at: 5)
        if viewModel.isSelectedArray[5] {
            selectButtons[5].setTitle("Selected", for: .normal)
            selectButtons[5].setTitleColor(.blue, for: .normal)
        } else {
            selectButtons[5].setTitle("Unselected", for: .normal)
            selectButtons[5].setTitleColor(.red, for: .normal)
        }
        guard let viewModel = viewModel as? DefaultSelectionButtonsViewModel else { return }
        SelectionButtonsViewModelController.shared.receive(viewModel: viewModel)
    }
    @objc func setIsSelected6(_ sender: UIButton) {
        viewModel.toggleSelection(at: 6)
        if viewModel.isSelectedArray[6] {
            selectButtons[6].setTitle("Selected", for: .normal)
            selectButtons[6].setTitleColor(.blue, for: .normal)
        } else {
            selectButtons[6].setTitle("Unselected", for: .normal)
            selectButtons[6].setTitleColor(.red, for: .normal)
        }
        guard let viewModel = viewModel as? DefaultSelectionButtonsViewModel else { return }
        SelectionButtonsViewModelController.shared.receive(viewModel: viewModel)
    }
    
    private func addAction(to countButton: UIButton) {
        countButton.addTarget(self, action: #selector(showCount), for: .touchUpInside)
    }
    
    @objc func showCount(_ sender: UIButton) {
        countLabel.text = "Count: \(viewModel.isSelectedArray.filter { $0 == true }.count)"
        countLabel.textColor = .black
        guard let viewModel = viewModel as? DefaultSelectionButtonsViewModel else { return }
        SelectionButtonsViewModelController.shared.receive(viewModel: viewModel)
    }
    
    @objc func handle(notification: Notification) {
        guard let event = notification.object as? SelectionButtonsViewModelUpdateEvent else { return }
        switch event {
        case .viewModel(let viewModel):
            self.setDefaultValue(of: selectButtons, from: viewModel)
            self.updateCountLabel(from: viewModel)

        }
    }
    
    private func updateCountLabel(from viewModel: DefaultSelectionButtonsViewModel) {
        countLabel.text = "Count: \(viewModel.isSelectedArray.filter { $0 == true }.count)"
    }
    
}

final class SelectionButtonsViewModelController {
    static let shared = SelectionButtonsViewModelController()
    
    func receive(viewModel: DefaultSelectionButtonsViewModel) {
        let event = SelectionButtonsViewModelUpdateEvent.viewModel(selectionButtonsViewModel: viewModel)
        event.post()
    }
}

enum SelectionButtonsViewModelUpdateEvent {
    case viewModel(selectionButtonsViewModel: DefaultSelectionButtonsViewModel)
    
    static let selectionButtonsNotificaitonName = Notification.Name(rawValue: "SelectionButtonsViewModel")
    
    func post() {
        switch self {
        case .viewModel(selectionButtonsViewModel: _):
            NotificationCenter.default.post(name: SelectionButtonsViewModelUpdateEvent.selectionButtonsNotificaitonName, object: self)
            
        }
    }
}
