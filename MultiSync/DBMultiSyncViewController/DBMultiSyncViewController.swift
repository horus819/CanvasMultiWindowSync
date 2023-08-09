//
//  DBMultiSyncViewController.swift
//  MultiSync
//
//  Created by Jun Ho JANG on 2023/07/10.
//

import UIKit
import PencilKit
import Combine

final class DBMultiSyncViewController: UIViewController {
    
    private let canvasView: PKCanvasView = {
        let canvasView = PKCanvasView()
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        return canvasView
    }()
    private let toolPicker: PKToolPicker = {
        let toolPicker = PKToolPicker()
        return toolPicker
    }()
    private var viewModel: DBMultiSyncViewModel!
    private var cancellable: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(canvasView)
        canvasView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        canvasView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        canvasView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        canvasView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        set(toolPicker: toolPicker)
        canvasView.delegate = self
        viewModel.didLoadInitialDrawingData()
    }
    
    static func create(with viewModel: DBMultiSyncViewModel) -> DBMultiSyncViewController {
        let viewController = DBMultiSyncViewController()
        viewController.viewModel = viewModel
        return viewController
    }
    
    private func set(toolPicker: PKToolPicker) {
        canvasView.becomeFirstResponder()
        toolPicker.setVisible(true, forFirstResponder: self.canvasView)
        toolPicker.addObserver(canvasView)
    }
    
}

extension DBMultiSyncViewController {
    private func subscribeDrawingData() {
        viewModel.drawingDataPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                do {
                    self?.canvasView.drawing = try PKDrawing(data: data.last?.data ?? Data())
                } catch {
                    
                }
            }
            .store(in: &cancellable)
    }
}

extension DBMultiSyncViewController: PKCanvasViewDelegate {
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        viewModel.didDraw(line: .init(data: canvasView.drawing.dataRepresentation()))
        viewModel.didLoadInitialDrawingData()
    }
}
