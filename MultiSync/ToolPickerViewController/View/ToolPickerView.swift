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
    private var colorPickerButtons: [DrawerButton]
    private var rulerButton: DrawerButton?
    private let undoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Undo", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    private let redoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Redo", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    init(drawerButtons: [DrawerButton] = [PenButton(), MarkerButton(), EraserButton(), LassoButton()], rulerButton: DrawerButton? = nil, widthButtons: [DrawerButton] = [LightWidthButton(), MediumWidthButton(), HeavyWidthButton()], colorPickerButtons: [DrawerButton] = [BlackColorPickerButton(), RedColorPickerButton(), BlueColorPickerButton(), YellowColorPickerButton(), GreenColorPickerButton(), ColorPickerButton()]) {
        self.drawerButtons = drawerButtons
        self.rulerButton = rulerButton
        self.widthButtons = widthButtons
        self.colorPickerButtons = colorPickerButtons
        super.init(frame: .zero)
        addSubviews()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        self.drawerButtons = [PenButton(), MarkerButton(), EraserButton(), LassoButton()]
        self.rulerButton = nil
        self.widthButtons = [LightWidthButton(), MediumWidthButton(), HeavyWidthButton()]
        self.colorPickerButtons = [BlackColorPickerButton(), RedColorPickerButton(), BlueColorPickerButton(), YellowColorPickerButton(), GreenColorPickerButton(), ColorPickerButton()]
        super.init(coder: coder)
    }

}

// MARK: - Pen
extension ToolPickerView {
    func didSelectDrawerButton(at index: Int) {
        if drawerButtons.count >= index {
            drawerButtons.forEach { $0.setSelected(to: false) }
            drawerButtons[index].setSelected(to: true)
        } else {
            
        }
    }
    
    func set(penAction: UIAction, markerAction: UIAction, eraserAction: UIAction, lassoAction: UIAction, for event: UIControl.Event) {
        drawerButtons.forEach { set(drawerButton: $0, penAction: penAction, markerAction: markerAction, eraserAction: eraserAction, lassoAction: lassoAction, event: event) }
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
}

// MARK: - Ruler
extension ToolPickerView {
    func didSelectRulerButton(for canvasView: PKCanvasView) {
        guard var rulerButton = rulerButton else { return }
        if rulerButton.isSelected {
            rulerButton.isSelected = false
            canvasView.isRulerActive = rulerButton.isSelected
        } else {
            rulerButton.isSelected = true
            canvasView.isRulerActive = rulerButton.isSelected
        }
    }
    
    func set(rulerAction: UIAction, for event: UIControl.Event) {
        guard let rulerButton = rulerButton else { return }
        set(rulerButton: rulerButton, rulerAction: rulerAction, for: event)
    }
    
    private func set(rulerButton: DrawerButton, rulerAction: UIAction, for event: UIControl.Event) {
        if rulerButton is RulerButton {
            rulerButton.set(action: rulerAction, for: event)
        }
    }
}

// MARK: - Width
extension ToolPickerView {
    func didSelectWidthButton(at index: Int) {
        if widthButtons.count >= index {
            widthButtons.forEach { $0.setSelected(to: false) }
            widthButtons[index].setSelected(to: true)
        } else {
            
        }
    }
    
    func set(lightWeightAction: UIAction, mediumWeightAction: UIAction, heavyWeightAction: UIAction, for event: UIControl.Event) {
        widthButtons.forEach { set(widthButton: $0, lightWeightAction: lightWeightAction, mediumWeightAction: mediumWeightAction, heavyWeightAction: heavyWeightAction, for: event) }
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
}

// MARK: - Color
extension ToolPickerView {
    func didSelectColorButton(at index: Int, with color: UIColor?) {
        if colorPickerButtons.count >= index {
            colorPickerButtons.forEach { $0.setSelected(to: false) }
            colorPickerButtons[index].setSelected(to: true)
        } else {
            
        }
    }
    
    func didSet(to controller: UIPopoverPresentationController?) {
        guard let colorPickerButton = colorPickerButtons.last as? UIButton else { return }
        if colorPickerButton is ColorPickerButton {
            controller?.sourceView = colorPickerButton
        }
    }
    
    func set(blackColorAction: UIAction, redColorAction: UIAction, blueColorAction: UIAction, yellowColorAction: UIAction, greenColorAction: UIAction, colorPickerAction: UIAction, for event: UIControl.Event) {
        colorPickerButtons.forEach { set(colorButton: $0, blackColorAction: blackColorAction, redColorAction: redColorAction, blueColorAction: blueColorAction, yellowColorAction: yellowColorAction, greenColorAction: greenColorAction, colorPickerAction: colorPickerAction, for: event) }
    }
    
    private func set(colorButton: DrawerButton, blackColorAction: UIAction, redColorAction: UIAction, blueColorAction: UIAction, yellowColorAction: UIAction, greenColorAction: UIAction, colorPickerAction: UIAction, for event: UIControl.Event) {
        if colorButton is BlackColorPickerButton {
            colorButton.set(action: blackColorAction, for: event)
        } else if colorButton is RedColorPickerButton {
            colorButton.set(action: redColorAction, for: event)
        } else if colorButton is BlueColorPickerButton {
            colorButton.set(action: blueColorAction, for: event)
        } else if colorButton is YellowColorPickerButton {
            colorButton.set(action: yellowColorAction, for: event)
        } else if colorButton is GreenColorPickerButton {
            colorButton.set(action: greenColorAction, for: event)
        } else if colorButton is ColorPickerButton {
            colorButton.set(action: colorPickerAction, for: event)
        }
    }
}

// MARK: - Undo / Redo
extension ToolPickerView {
    func setUndo(action: UIAction, for control: UIControl.Event) {
        undoButton.addAction(action, for: control)
    }
    
    func setRedo(action: UIAction, for control: UIControl.Event) {
        redoButton.addAction(action, for: control)
    }
}

// MARK: - Subview and layout
extension ToolPickerView {
    private func addSubviews() {
        addSubview(drawerButtonStackView)
        drawerButtons.forEach { drawerButtonStackView.addArrangedSubview($0 as? UIButton ?? .init()) }
        drawerButtonStackView.addArrangedSubview(rulerButton as? UIButton ?? .init())
        widthButtons.forEach { drawerButtonStackView.addArrangedSubview($0 as? UIButton ?? .init()) }
        colorPickerButtons.forEach { drawerButtonStackView.addArrangedSubview($0 as? UIButton ?? .init()) }
        drawerButtonStackView.addArrangedSubview(undoButton)
        drawerButtonStackView.addArrangedSubview(redoButton)
    }
    
    private func setLayout() {
        drawerButtonStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        drawerButtonStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        drawerButtonStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        drawerButtonStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
