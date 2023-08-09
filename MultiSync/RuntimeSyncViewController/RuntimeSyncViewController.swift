//
//  RuntimeSyncViewController.swift
//  MultiSync
//
//  Created by Jun Ho JANG on 2023/07/10.
//

import UIKit
import PencilKit
import Combine

final class RuntimeSyncViewController: UIViewController {
    
    private let canvasView: PKCanvasView = {
        let canvasView = PKCanvasView()
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        return canvasView
    }()
    private let toolPicker: PKToolPicker = {
        let toolPicker = PKToolPicker()
        return toolPicker
    }()
    private var viewModel: RuntimeSyncViewModel!
    private var cancellable: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeDrawingData()
        
        view.addSubview(canvasView)
        canvasView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        canvasView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        canvasView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        canvasView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        set(toolPicker: toolPicker)
        canvasView.delegate = self
        viewModel.didLoadStrokes()
    }
    
    static func create(with viewModel: RuntimeSyncViewModel) -> RuntimeSyncViewController {
        let viewController = RuntimeSyncViewController()
        viewController.viewModel = viewModel
        return viewController
    }
    
    private func set(toolPicker: PKToolPicker) {
        canvasView.becomeFirstResponder()
        toolPicker.setVisible(true, forFirstResponder: self.canvasView)
        toolPicker.addObserver(canvasView)
    }
    
}

extension RuntimeSyncViewController {
    private func subscribeDrawingData() {
        viewModel.strokesPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] strokes in
                do {
                    self?.canvasView.drawing.strokes = strokes
                } catch {
                    
                }
            }
            .store(in: &cancellable)
    }
}

extension RuntimeSyncViewController: PKCanvasViewDelegate {
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
//        viewModel.didDraw(stroke: canvasView.drawing.strokes)
    }
}

