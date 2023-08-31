//
//  ToolPickerView.swift
//  MultiSync
//
//  Created by Jun Ho JANG on 2023/08/31.
//

import UIKit
import PencilKit

enum ToolPickerViewError: String, Error {
    case countMismatch = "Count mismatch"
}

final class ToolPickerView: UIView {
    
    private let drawerButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    private var drawerButtons: [DrawerButton]
    
    override init(frame: CGRect) {
        self.drawerButtons = [PenButton(), MarkerButton()]
        super.init(frame: .zero)
        addSubviews()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        self.drawerButtons = [PenButton(), MarkerButton()]
        super.init(coder: coder)
    }
    
    func setDrawerButton(at index: Int) {
        if drawerButtons.count >= index {
            drawerButtons.forEach { $0.setSelected(to: false) }
            drawerButtons[index].setSelected(to: true)
        } else {
            
        }
    }
    
    func set(penAction: UIAction, markerAction: UIAction, for event: UIControl.Event) {
        drawerButtons.forEach { set(drawerButton: $0, penAction: penAction, markerAction: markerAction, event: event) }
    }
    
    private func set(drawerButton: DrawerButton, penAction: UIAction, markerAction: UIAction, event: UIControl.Event) {
        if drawerButton is PenButton {
            drawerButton.set(action: penAction, for: event)
        } else if drawerButton is MarkerButton {
            drawerButton.set(action: markerAction, for: event)
        }
    }
    
    private func addSubviews() {
        addSubview(drawerButtonStackView)
        drawerButtons.forEach { drawerButtonStackView.addArrangedSubview($0 as? UIButton ?? .init()) }
    }
    
    private func setLayout() {
        drawerButtonStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        drawerButtonStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        drawerButtonStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        drawerButtonStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
}
