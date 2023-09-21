//
//  UndoRedoViewController.swift
//  MultiSync
//
//  Created by Jun Ho JANG on 2023/09/07.
//

import UIKit
import PencilKit

final class UndoRedoViewController: UIViewController {
    
    private var originalWidth: CGFloat = 0
    private var originalHeight: CGFloat = 0
    
    private let canvasViewStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let leftCanvasView: PKCanvasView = {
        let canvasView = PKCanvasView()
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        canvasView.drawingPolicy = .anyInput
        canvasView.backgroundColor = .clear
        return canvasView
    }()
    
    private let rightCanvasView: PKCanvasView = {
        let canvasView = PKCanvasView()
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        canvasView.drawingPolicy = .anyInput
        canvasView.backgroundColor = .clear
        return canvasView
    }()
    
    private let undoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Undo", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    private let redoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Redo", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    private let checkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Check", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    private let toolPicker: PKToolPicker = {
        let toolPicker = PKToolPicker()
        return toolPicker
    }()
    
    private var strokeStack: [PKStroke] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addSubviews()
        setLeftCanvasViewLayout()
        setUndoButtonLayout()
        setRedoButtonLayout()
        setCheckButtonLayout()
        setToolPicker()
        
        addUndoButtoAction()
        addRedoButtoAction()
        addCheckButtonAction()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        originalWidth = leftCanvasView.frame.width
        originalHeight = leftCanvasView.frame.height
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        changeLayoutFor()
        coordinator.animate(alongsideTransition: { _ in
            UIView.performWithoutAnimation {
                self.originalWidth = self.leftCanvasView.frame.width
                self.originalHeight = self.leftCanvasView.frame.height
                print(self.originalWidth)
                print(self.originalHeight)
            }
        })
    }
    
}

extension UndoRedoViewController {
    private func addUndoButtoAction() {
        let action = UIAction { action in
            self.undo()
        }
        undoButton.addAction(action, for: .touchUpInside)
    }
    
    private func addRedoButtoAction() {
        let action = UIAction { action in
            self.redo()
        }
        redoButton.addAction(action, for: .touchUpInside)
    }
    
    private func addCheckButtonAction() {
        let action = UIAction { action in
            self.check()
        }
        checkButton.addAction(action, for: .touchUpInside)
    }
    
    private func undo() {
        if let last = leftCanvasView.drawing.strokes.popLast() {
            strokeStack.append(last)
        }
    }
    
    private func redo() {
        if var last = strokeStack.popLast() {
            let transform = optimizeScale()
            last.transform = transform
            leftCanvasView.drawing.strokes.append(last)
        }
    }
    
    private func check() {
        print(leftCanvasView.drawing.strokes[0].path.creationDate == leftCanvasView.drawing.strokes[1].path.creationDate)
        print(leftCanvasView.drawing.strokes[1].path.creationDate == leftCanvasView.drawing.strokes[2].path.creationDate)
        print(leftCanvasView.drawing.strokes[2].path.creationDate == leftCanvasView.drawing.strokes[3].path.creationDate)
        print(leftCanvasView.drawing.strokes[3].path.creationDate == leftCanvasView.drawing.strokes[4].path.creationDate)
        print(leftCanvasView.drawing.strokes[4].path.creationDate == leftCanvasView.drawing.strokes[5].path.creationDate)
        print(leftCanvasView.drawing.strokes[5].path.creationDate == leftCanvasView.drawing.strokes[6].path.creationDate)
    }
}

extension UndoRedoViewController {
    private func addSubviews() {
        view.addSubview(canvasViewStackView)
        view.addSubview(undoButton)
        view.addSubview(redoButton)
        view.addSubview(checkButton)
        canvasViewStackView.addArrangedSubview(leftCanvasView)
    }
}

extension UndoRedoViewController {
    private func setToolPicker() {
        leftCanvasView.becomeFirstResponder()
        toolPicker.setVisible(true, forFirstResponder: leftCanvasView)
        toolPicker.addObserver(leftCanvasView)
        toolPicker.addObserver(rightCanvasView)
    }
    
    private func changeLayoutFor() {
        let orientation = UIDevice.current.orientation
        if orientation == .portrait {
            rightCanvasView.removeFromSuperview()
            canvasViewStackView.removeArrangedSubview(rightCanvasView)
            leftCanvasView.frame.size = canvasViewStackView.frame.size
            toolPicker.removeObserver(rightCanvasView)
        } else {
            canvasViewStackView.addArrangedSubview(rightCanvasView)
            toolPicker.addObserver(rightCanvasView)
        }
    }
    
    private func optimizeScale() -> CGAffineTransform {
        // port
        // 1024.0
        // 1166.0
        
        // land
        // 683.0
        // 824.0
        let widthRatio = 683.0 / 1024.0
        let heightRatio = 824.0 / 1166.0
        let transform = CGAffineTransform(scaleX: widthRatio, y: heightRatio)
        return transform
    }
}

extension UndoRedoViewController {
    private func setLeftCanvasViewLayout() {
        canvasViewStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        canvasViewStackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        canvasViewStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        canvasViewStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200).isActive = true
    }
    
    private func setUndoButtonLayout() {
        undoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 200).isActive = true
        undoButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setRedoButtonLayout() {
        redoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -200).isActive = true
        redoButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setCheckButtonLayout() {
        checkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        checkButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
    }
}
