//
//  ToolPickerViewController.swift
//  MultiSync
//
//  Created by Jun Ho JANG on 2023/08/31.
//

import UIKit
import PencilKit

final class ToolPickerViewController: UIViewController {
    
    private let toolPickerView: ToolPickerView = {
        // MARK: - Default tool picker view, init buttons customization possible
        let toolPickerView = ToolPickerView()
        toolPickerView.translatesAutoresizingMaskIntoConstraints = false
        return toolPickerView
    }()
    private let canvasView: PKCanvasView = {
        let canvasView = PKCanvasView()
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        // MARK: - Remove needed
        canvasView.drawingPolicy = .anyInput
        return canvasView
    }()
    private var inkingTool: PKInkingTool? = {
        let inkingTool = PKInkingTool(.pen)
        return inkingTool
    }()
    private var eraserTool: PKEraserTool? = {
        let eraserTool = PKEraserTool(.vector)
        return eraserTool
    }()
    private var lassoTool: PKLassoTool = {
        let lassoTool = PKLassoTool()
        return lassoTool
    }()
    private let colorPickerViewController: UIColorPickerViewController = {
        let colorPicker = UIColorPickerViewController()
        return colorPicker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(toolPickerView)
        view.addSubview(canvasView)
        
        colorPickerViewController.delegate = self
        
        toolPickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        toolPickerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        toolPickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        toolPickerView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        canvasView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        canvasView.topAnchor.constraint(equalTo: toolPickerView.bottomAnchor).isActive = true
        canvasView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        canvasView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        setDrawerActions()
        setRulerAction()
        setWidthActions()
        setColorActions()
        setUndoAction()
        setRedoAction()
    }
    
}

// MARK: - Drawer
extension ToolPickerViewController {
    private func setDrawerActions() {
        let penAction = UIAction { action in
            self.toolPickerView.didSelectDrawerButton(at: 0)
            self.inkingTool?.inkType = .pen
            self.canvasView.tool = self.inkingTool ?? .init(.pen)
        }
        
        let markerAction = UIAction { action in
            self.toolPickerView.didSelectDrawerButton(at: 1)
            self.inkingTool?.inkType = .marker
            self.canvasView.tool = self.inkingTool ?? .init(.marker)
        }
        
        let eraserAction = UIAction { action in
            self.toolPickerView.didSelectDrawerButton(at: 2)
            self.eraserTool = PKEraserTool(.bitmap)
            self.canvasView.tool = self.eraserTool ?? .init(.bitmap)
        }
        
        let lassoAction = UIAction { action in
            self.toolPickerView.didSelectDrawerButton(at: 3)
            self.canvasView.tool = self.lassoTool
        }
        
        toolPickerView.set(penAction: penAction, markerAction: markerAction, eraserAction: eraserAction, lassoAction: lassoAction, for: .touchUpInside)
    }
}

// MARK: - Ruler
extension ToolPickerViewController {
    private func setRulerAction() {
        let rulerAction = UIAction { action in
            self.toolPickerView.didSelectRulerButton(for: self.canvasView)
        }
        toolPickerView.set(rulerAction: rulerAction, for: .touchUpInside)
    }
}

// MARK: - Width
extension ToolPickerViewController {
    private func setWidthActions() {
        let lightWidthAction = UIAction { action in
            self.toolPickerView.didSelectWidthButton(at: 0)
            self.inkingTool?.width = 4
            self.canvasView.tool = self.inkingTool ?? .init(.pen)
        }
        
        let mediumWeightAction = UIAction { action in
            self.toolPickerView.didSelectWidthButton(at: 1)
            self.inkingTool?.width = 12
            self.canvasView.tool = self.inkingTool ?? .init(.pen)
        }
        
        let heavyWeightAction = UIAction { action in
            self.toolPickerView.didSelectWidthButton(at: 2)
            self.inkingTool?.width = 20
            self.canvasView.tool = self.inkingTool ?? .init(.pen)
        }
        
        toolPickerView.set(lightWeightAction: lightWidthAction, mediumWeightAction: mediumWeightAction, heavyWeightAction: heavyWeightAction, for: .touchUpInside)
    }
}

// MARK: - Color
extension ToolPickerViewController {
    private func setColorActions() {
        let blackColorAction = UIAction { action in
            self.toolPickerView.didSelectColorButton(at: 0, with: .black)
            self.inkingTool?.color = .black
            self.canvasView.tool = self.inkingTool ?? .init(.pen)
        }
        
        let redColorAction = UIAction { action in
            self.toolPickerView.didSelectColorButton(at: 1, with: .red)
            self.inkingTool?.color = .red
            self.canvasView.tool = self.inkingTool ?? .init(.pen)
        }
        
        let blueColorAction = UIAction { action in
            self.toolPickerView.didSelectColorButton(at: 2, with: .blue)
            self.inkingTool?.color = .blue
            self.canvasView.tool = self.inkingTool ?? .init(.pen)
        }
        
        let yellowColorAction = UIAction { action in
            self.toolPickerView.didSelectColorButton(at: 3, with: .yellow)
            self.inkingTool?.color = .yellow
            self.canvasView.tool = self.inkingTool ?? .init(.pen)
        }
        
        let greenColorAction = UIAction { action in
            self.toolPickerView.didSelectColorButton(at: 4, with: .green)
            self.inkingTool?.color = .green
            self.canvasView.tool = self.inkingTool ?? .init(.pen)
        }
        
        let colorPickerAction = UIAction { action in
            self.toolPickerView.didSelectColorButton(at: 5, with: nil)
            self.presentColorPicker()
        }

        toolPickerView.set(blackColorAction: blackColorAction, redColorAction: redColorAction, blueColorAction: blueColorAction, yellowColorAction: yellowColorAction, greenColorAction: greenColorAction, colorPickerAction: colorPickerAction, for: .touchUpInside)
    }
    
    private func presentColorPicker() {
        colorPickerViewController.title = "Pen Color"
        colorPickerViewController.supportsAlpha = false
        colorPickerViewController.modalPresentationStyle = .popover
        toolPickerView.didSet(to: colorPickerViewController.popoverPresentationController)
        self.present(colorPickerViewController, animated: true)
    }
}

extension ToolPickerViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let selectedColor = viewController.selectedColor
        self.inkingTool?.color = selectedColor
        self.canvasView.tool = self.inkingTool ?? .init(.pen)
        dismiss(animated: true, completion: nil)
    }
    
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        self.inkingTool?.color = color
        self.canvasView.tool = self.inkingTool ?? .init(.pen)
    }
}

// MARK: Undo / Redo
extension ToolPickerViewController {
    private func setUndoAction() {
        let undoAction = UIAction { action in
            self.canvasView.undoManager?.undo()
        }
        toolPickerView.setUndo(action: undoAction, for: .touchUpInside)
    }
    
    private func setRedoAction() {
        let redoAction = UIAction { action in
            self.canvasView.undoManager?.redo()
        }
        toolPickerView.setRedo(action: redoAction, for: .touchUpInside)
    }
}
