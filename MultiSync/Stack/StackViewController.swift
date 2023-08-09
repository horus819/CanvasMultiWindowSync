//
//  StackViewController.swift
//  MultiSync
//
//  Created by Jun Ho JANG on 2023/08/08.
//

import UIKit

final class StackViewController: UIViewController {
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .gray
        stackView.distribution = .fillProportionally
        return stackView
    }()
    private let leftView: UIView = {
        let view = UIView(frame: .init(x: 0, y: 0, width: 623, height: 1024))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemRed
        return view
    }()
    private let rightView: UIView = {
        let view = UIView(frame: .init(x: 0, y: 0, width: 623, height: 1024))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(containerStackView)
        setLayout(containerStackView: containerStackView)
        containerStackView.addArrangedSubview(leftView)
        containerStackView.addArrangedSubview(rightView)
        print(leftView.frame.size)
    }
    
    private func setLayout(containerStackView: UIStackView) {
        containerStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        containerStackView.widthAnchor.constraint(equalToConstant: 623 * 2).isActive = true
        containerStackView.heightAnchor.constraint(equalToConstant: 1024).isActive = true
    }
    
}
