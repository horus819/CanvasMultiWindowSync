//
//  MultiSyncViewController.swift
//  MultiSync
//
//  Created by Jun Ho JANG on 2023/07/06.
//

import UIKit

final class MultiSyncViewController: UIViewController {
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(textField)
        view.addSubview(label)
        
        textField.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        textField.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        textField.addTarget(self, action: #selector(didEnterMessage(sender:)), for: .editingChanged)
        
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(handle(notification:)), name: UpdateEvent.messageNotificaitonName, object: nil)
    }
    
    // MARK: - Only view update
    @objc func handle(notification: Notification) {
        guard let event = notification.object as? UpdateEvent else { return }
        switch event {
        case .message(let message):
            self.label.text = message.text

        }
    }
    
    // MARK: - Runtime
    // 모델에 이미 값이 있는 경우 입력해도 양쪽 모두 바뀌지 않고 해당 값으로 고정된다.
    @objc func didEnterMessage(sender: UITextField) {
        let message = sender.text
        MessageModelController.shared.add(message: .init(text: message ?? ""))
    }
    
}

final class MessageModelController {
    static let shared = MessageModelController()
    
    func add(message: MessageViewModel) {
        let event = UpdateEvent.message(message: message)
        event.post()
    }
}

struct MessageViewModel {
    let text: String
}

enum UpdateEvent {
    case message(message: MessageViewModel)
    
    static let messageNotificaitonName = Notification.Name(rawValue: "Message")
    
    func post() {
        switch self {
        case .message(message: _):
            NotificationCenter.default.post(name: UpdateEvent.messageNotificaitonName, object: self)
            
        }
    }
}
