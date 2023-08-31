//
//  ToolPickerViewController.swift
//  MultiSync
//
//  Created by Jun Ho JANG on 2023/08/31.
//

import UIKit
import PencilKit

final class ToolPickerControlViewController: UIViewController {
    
    private let canvasView: PKCanvasView = {
        let canvasView = PKCanvasView()
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        return canvasView
    }()
    
    private let toolPicker: PKToolPicker = {
        let toolPicker = PKToolPicker()
        return toolPicker
    }()
    
    private let toolPickerHideButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Hide", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(canvasView)
        view.addSubview(toolPickerHideButton)
        
        setCanvasViewLayout()
        setToolPickerHideButtonLayout()
        
        addToolPickerHideButtonAction()
        setToolPicker()
        
        canvasView.becomeFirstResponder()
    }
    
    private func setCanvasViewLayout() {
        canvasView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        canvasView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        canvasView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        canvasView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setToolPickerHideButtonLayout() {
        toolPickerHideButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        toolPickerHideButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
    }
    
    private func setToolPicker() {
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
    }
    
    private func addToolPickerHideButtonAction() {
        toolPickerHideButton.addTarget(self, action: #selector(toolPickerHideButtonAction), for: .touchUpInside)
    }
    
    @objc func toolPickerHideButtonAction(_ sender: UIButton) {
        if toolPicker.isVisible {
            toolPicker.setVisible(false, forFirstResponder: canvasView)
        } else {
            toolPicker.setVisible(true, forFirstResponder: canvasView)
        }
    }
    
}


