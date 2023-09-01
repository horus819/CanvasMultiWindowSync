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
    private var widthButtons: [DrawerButton]
    
    init(drawerButtons: [DrawerButton] = [PenButton(), MarkerButton(), EraserButton(), LassoButton()], widthButtons: [DrawerButton] = [LightWidthButton(), MediumWidthButton(), HeavyWidthButton()]) {
        self.drawerButtons = drawerButtons
        self.widthButtons = widthButtons
        super.init(frame: .zero)
        addSubviews()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        self.drawerButtons = [PenButton(), MarkerButton(), EraserButton(), LassoButton()]
        self.widthButtons = [LightWidthButton(), MediumWidthButton(), HeavyWidthButton()]
        super.init(coder: coder)
    }
    
    func didSelectDrawerButton(at index: Int) {
        if drawerButtons.count >= index {
            drawerButtons.forEach { $0.setSelected(to: false) }
            drawerButtons[index].setSelected(to: true)
        } else {
            
        }
    }
    
    func didSelectWidthButton(at index: Int) {
        if widthButtons.count >= index {
            widthButtons.forEach { $0.setSelected(to: false) }
            widthButtons[index].setSelected(to: true)
        } else {
            
        }
    }
    
    func set(penAction: UIAction, markerAction: UIAction, eraserAction: UIAction, lassoAction: UIAction, for event: UIControl.Event) {
        drawerButtons.forEach { set(drawerButton: $0, penAction: penAction, markerAction: markerAction, eraserAction: eraserAction, lassoAction: lassoAction, event: event) }
    }
    
    func set(lightWeightAction: UIAction, mediumWeightAction: UIAction, heavyWeightAction: UIAction, for event: UIControl.Event) {
        widthButtons.forEach { set(widthButton: $0, lightWeightAction: lightWeightAction, mediumWeightAction: mediumWeightAction, heavyWeightAction: heavyWeightAction, for: event) }
    }
    
    private func set(drawerButton: DrawerButton, penAction: UIAction, markerAction: UIAction, eraserAction: UIAction, lassoAction: UIAction, event: UIControl.Event) {
        if drawerButton is PenButton {
            drawerButton.set(action: penAction, for: event)
        } else if drawerButton is MarkerButton {
            drawerButton.set(action: markerAction, for: event)
        } else if drawerButton is EraserButton {
            drawerButton.set(action: eraserAction, for: event)
        } else if drawerButton is LassoButton {
            drawerButton.set(action: lassoAction, for: event)
        }
    }
    
    private func set(widthButton: DrawerButton, lightWeightAction: UIAction, mediumWeightAction: UIAction, heavyWeightAction: UIAction, for event: UIControl.Event) {
        if widthButton is LightWidthButton {
            widthButton.set(action: lightWeightAction, for: event)
        } else if widthButton is MediumWidthButton {
            widthButton.set(action: mediumWeightAction, for: event)
        } else if widthButton is HeavyWidthButton {
            widthButton.set(action: heavyWeightAction, for: event)
        }
    }
    
    private func addSubviews() {
        addSubview(drawerButtonStackView)
        drawerButtons.forEach { drawerButtonStackView.addArrangedSubview($0 as? UIButton ?? .init()) }
        widthButtons.forEach { drawerButtonStackView.addArrangedSubview($0 as? UIButton ?? .init()) }
    }
    
    private func setLayout() {
        drawerButtonStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        drawerButtonStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        drawerButtonStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        drawerButtonStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
}
