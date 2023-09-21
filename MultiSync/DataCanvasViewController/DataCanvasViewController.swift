//
//  DataCanvasViewController.swift
//  MultiSync
//
//  Created by Jun Ho JANG on 2023/09/15.
//

import UIKit
import PencilKit

final class DataCanvasViewController: UIViewController {
    
    private let canvasView: PKCanvasView = {
        let canvasView = PKCanvasView()
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        canvasView.drawingPolicy = .anyInput
        return canvasView
    }()
    private let dataSetButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Data", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(canvasView)
        view.addSubview(dataSetButton)
        
        canvasView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        canvasView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        canvasView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        canvasView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200).isActive = true
        
        dataSetButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        dataSetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        addDataSetButtonAction()
    }
    
    private func addDataSetButtonAction() {
        dataSetButton.addTarget(self, action: #selector(dataSetButtonAction), for: .touchUpInside)
    }
    
    @objc func dataSetButtonAction(_ sender: UIButton) {
        do {
            let drawing = try PKDrawing(data: Data())
            canvasView.drawing = drawing
            print("Data set")
        } catch {
            print("Data set failed")
        }
    }
    
}
