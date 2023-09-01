//
//  ToolPickerViewController.swift
//  MultiSync
//
//  Created by Jun Ho JANG on 2023/08/31.
//

import UIKit
import PencilKit

// MARK: - Pen -> Heavy weight(not save) -> Eraser -> Light weight(cause heavy weight not saved)

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
    }
    
    private func setDrawerActions() {
        let penAction = UIAction { action in
            self.toolPickerView.didSelectDrawerButton(at: 0)
            self.inkingTool = PKInkingTool(.pen)
            self.canvasView.tool = self.inkingTool ?? .init(.pen)
        }
        
        let markerAction = UIAction { action in
            self.toolPickerView.didSelectDrawerButton(at: 1)
            self.inkingTool = PKInkingTool(.marker)
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
