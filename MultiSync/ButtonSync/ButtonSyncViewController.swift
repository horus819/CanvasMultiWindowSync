//
//  ButtonSyncViewController.swift
//  MultiSync
//
//  Created by Jun Ho JANG on 2023/08/07.
//

import UIKit
import Combine

final class ButtonSyncViewController: UIViewController {
    
    private var viewModel: ButtonSyncViewModel! = DefaultButtonSyncViewModel(selection: .init(isSelected: false))
    
    private let selectButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(selectButton)
        view.backgroundColor = .white
        setLayoutOf(selectButton: selectButton)
        addActionTo(selectButton: selectButton)
        setDefault(selectButton: selectButton)
        NotificationCenter.default.addObserver(self, selector: #selector(handle(notification:)), name: ButtonSyncViewModelUpdateEvent.buttonSyncNotificaitonName, object: nil)
    }
    
    private func setLayoutOf(selectButton: UIButton) {
        selectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        selectButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func addActionTo(selectButton: UIButton) {
        selectButton.addTarget(self, action: #selector(toggleSelectButton), for: .touchUpInside)
    }
    
    private func setDefault(selectButton: UIButton) {
        if viewModel.isSelected {
            selectButton.setTitle("Selected", for: .normal)
            selectButton.setTitleColor(.blue, for: .normal)
        } else {
            selectButton.setTitle("Unselected", for: .normal)
            selectButton.setTitleColor(.red, for: .normal)
        }
    }
    
    private func setChangedValue(from viewModel: DefaultButtonSyncViewModel) {
        if viewModel.isSelected {
            selectButton.setTitle("Selected", for: .normal)
            selectButton.setTitleColor(.blue, for: .normal)
        } else {
            selectButton.setTitle("Unselected", for: .normal)
            selectButton.setTitleColor(.red, for: .normal)
        }
    }
    
    @objc func toggleSelectButton(_ sender: UIButton) {
        viewModel.toggleSelectButton()
        if viewModel.isSelected {
            selectButton.setTitle("Selected", for: .normal)
            selectButton.setTitleColor(.blue, for: .normal)
        } else {
            selectButton.setTitle("Unselected", for: .normal)
            selectButton.setTitleColor(.red, for: .normal)
        }
        guard let viewModel = viewModel as? DefaultButtonSyncViewModel else { return }
        ButtonSyncViewModelController.shared.receive(buttonSyncViewModel: viewModel)
    }
    
    @objc func handle(notification: Notification) {
        guard let event = notification.object as? ButtonSyncViewModelUpdateEvent else { return }
        switch event {
        case .viewModel(let viewModel):
            self.setChangedValue(from: viewModel)

        }
    }
    
}


final class ButtonSyncViewModelController {
    static let shared = ButtonSyncViewModelController()
    
    func receive(buttonSyncViewModel: DefaultButtonSyncViewModel) {
        let event = ButtonSyncViewModelUpdateEvent.viewModel(buttonSyncViewModel: buttonSyncViewModel)
        event.post()
    }
}

enum ButtonSyncViewModelUpdateEvent {
    case viewModel(buttonSyncViewModel: DefaultButtonSyncViewModel)
    
    static let buttonSyncNotificaitonName = Notification.Name(rawValue: "ButtonSyncViewModel")
    
    func post() {
        switch self {
        case .viewModel(buttonSyncViewModel: _):
            NotificationCenter.default.post(name: ButtonSyncViewModelUpdateEvent.buttonSyncNotificaitonName, object: self)
            
        }
    }
}
