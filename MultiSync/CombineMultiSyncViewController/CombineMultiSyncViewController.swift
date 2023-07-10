//
//  CombineMultiSyncViewController.swift
//  MultiSync
//
//  Created by Jun Ho JANG on 2023/07/10.
//

import UIKit
import PencilKit
import Combine

final class CombineMultiSyncViewController: UIViewController {
    
    private let canvasView: PKCanvasView = {
        let canvasView = PKCanvasView()
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        return canvasView
    }()
    private let toolPicker: PKToolPicker = {
        let toolPicker = PKToolPicker()
        return toolPicker
    }()
    
    private var viewModel: CombineMultiSyncViewModel!
    private var cancellable: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeDrawing()
        view.addSubview(canvasView)
        canvasView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        canvasView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        canvasView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        canvasView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        canvasView.delegate = self
        
        set(toolPicker: toolPicker)
        
        viewModel.didLoadDrawing()
    }
    
    static func create(with viewModel: CombineMultiSyncViewModel) -> CombineMultiSyncViewController {
        let viewController = CombineMultiSyncViewController()
        viewController.viewModel = viewModel
        return viewController
    }
    
    private func set(toolPicker: PKToolPicker) {
        canvasView.becomeFirstResponder()
        toolPicker.setVisible(true, forFirstResponder: self.canvasView)
        toolPicker.addObserver(self.canvasView)
    }
    
    private func subscribeDrawing() {
        viewModel.drawingPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] drawingData in
                self?.canvasView.drawing = PKDrawing()
                self?.canvasView.drawing = drawingData.last ?? PKDrawing()
            }
            .store(in: &cancellable)
    }
    
}

extension CombineMultiSyncViewController: PKCanvasViewDelegate {
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        viewModel.didFetchDrawing(canvasView.drawing)
    }
}
