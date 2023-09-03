//
//  ToolPickerViewController.swift
//  MultiSync
//
//  Created by Jun Ho JANG on 2023/08/31.
//

import UIKit
import PencilKit

// MARK: - Pen -> Heavy weight(not saved) -> Eraser -> Light weight(cause heavy weight not saved)
// MARK: - Blue(not saved) -> Pen -> Black(cause blue color not saved)

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
    private var inkType: PKInkingTool.InkType = .pencil
    private var inkColor: UIColor = .black
    private var pencilWidth: CGFloat = 12
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(toolPickerView)
        view.addSubview(canvasView)
        
        toolPickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        toolPickerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        toolPickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        toolPickerView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        canvasView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        canvasView.topAnchor.constraint(equalTo: toolPickerView.bottomAnchor).isActive = true
        canvasView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        canvasView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        setDrawerActions()
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
            self.inkType = .pen
            self.inkingTool = PKInkingTool(self.inkType, color: self.inkColor, width: self.pencilWidth)
            self.canvasView.tool = self.inkingTool ?? .init(.pen)
        }
        
        let markerAction = UIAction { action in
            self.toolPickerView.didSelectDrawerButton(at: 1)
            self.inkType = .marker
            self.inkingTool = PKInkingTool(self.inkType, color: self.inkColor, width: self.pencilWidth)
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

// MARK: - Width
extension ToolPickerViewController {
    private func setWidthActions() {
        let lightWidthAction = UIAction { action in
            self.toolPickerView.didSelectWidthButton(at: 0)
            self.pencilWidth = 4
            self.inkingTool = PKInkingTool(self.inkType, color: self.inkColor, width: self.pencilWidth)
            self.canvasView.tool = self.inkingTool ?? .init(.pen)
        }
        
        let mediumWeightAction = UIAction { action in
            self.toolPickerView.didSelectWidthButton(at: 1)
            self.pencilWidth = 12
            self.inkingTool = PKInkingTool(self.inkType, color: self.inkColor, width: self.pencilWidth)
            self.canvasView.tool = self.inkingTool ?? .init(.pen)
        }
        
        let heavyWeightAction = UIAction { action in
            self.toolPickerView.didSelectWidthButton(at: 2)
            self.pencilWidth = 20
            self.inkingTool = PKInkingTool(self.inkType, color: self.inkColor, width: self.pencilWidth)
            self.canvasView.tool = self.inkingTool ?? .init(.pen)
        }
        
        toolPickerView.set(lightWeightAction: lightWidthAction, mediumWeightAction: mediumWeightAction, heavyWeightAction: heavyWeightAction, for: .touchUpInside)
    }
}

// MARK: - Color
extension ToolPickerViewController {
    private func setColorActions() {
        let blackColorAction = UIAction { action in
            self.toolPickerView.didSelectColorButton(at: 0)
            self.inkColor = .black
            self.inkingTool = PKInkingTool(self.inkType, color: self.inkColor, width: self.pencilWidth)
            self.canvasView.tool = self.inkingTool ?? .init(.pen)
        }
        
        let redColorAction = UIAction { action in
            self.toolPickerView.didSelectColorButton(at: 1)
            self.inkColor = .red
            self.inkingTool = PKInkingTool(self.inkType, color: self.inkColor, width: self.pencilWidth)
            self.canvasView.tool = self.inkingTool ?? .init(.pen)
        }
        
        let blueColorAction = UIAction { action in
            self.toolPickerView.didSelectColorButton(at: 2)
            self.inkColor = .blue
            self.inkingTool = PKInkingTool(self.inkType, color: self.inkColor, width: self.pencilWidth)
            self.canvasView.tool = self.inkingTool ?? .init(.pen)
        }
        
        let yellowColorAction = UIAction { action in
            self.toolPickerView.didSelectColorButton(at: 3)
            self.inkColor = .yellow
            self.inkingTool = PKInkingTool(self.inkType, color: self.inkColor, width: self.pencilWidth)
            self.canvasView.tool = self.inkingTool ?? .init(.pen)
        }
        
        let greenColorAction = UIAction { action in
            self.toolPickerView.didSelectColorButton(at: 4)
            self.inkColor = .green
            self.inkingTool = PKInkingTool(self.inkType, color: self.inkColor, width: self.pencilWidth)
            self.canvasView.tool = self.inkingTool ?? .init(.pen)
        }

        toolPickerView.set(blackColorAction: blackColorAction, redColorAction: redColorAction, blueColorAction: blueColorAction, yellowColorAction: yellowColorAction, greenColorAction: greenColorAction, for: .touchUpInside)
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
