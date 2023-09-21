//
//  SliderViewController.swift
//  MultiSync
//
//  Created by Jun Ho JANG on 2023/09/13.
//

import UIKit
import PencilKit

final class SliderViewController: UIViewController {
    
    private let canvasView: PKCanvasView = {
        let canvasView = PKCanvasView()
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        canvasView.drawingPolicy = .anyInput
        return canvasView
    }()
    private let slider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 0
        slider.maximumValue = 100
        return slider
    }()
    private let hideButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Button", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    private var isSliderHidden: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        canvasView.delegate = self
        view.backgroundColor = .white
        view.addSubview(canvasView)
        view.addSubview(slider)
        view.addSubview(hideButton)
        
        canvasView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        canvasView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        canvasView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        canvasView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        slider.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        slider.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        slider.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        hideButton.topAnchor.constraint(equalTo: slider.bottomAnchor).isActive = true
        hideButton.centerXAnchor.constraint(equalTo: slider.centerXAnchor).isActive = true
        
        hideButton.addTarget(self, action: #selector(hideButtonAction), for: .touchUpInside)
        
        addSliderAction()
        let drawing = PKDrawing()
        let data = drawing.dataRepresentation()
        print(data.count)
    }
    
    @objc func hideButtonAction(_ sender: UIButton) {
        if self.isSliderHidden {
            slider.isHidden = false
            self.isSliderHidden.toggle()
        } else {
            slider.isHidden = true
            self.isSliderHidden.toggle()
        }
    }
    
}

extension SliderViewController: PKCanvasViewDelegate {
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        print("Changed")
    }
}

extension SliderViewController {
    private func addSliderAction() {
        slider.addTarget(self, action: #selector(sliderTouchDragInside), for: .touchDragInside)
        slider.addTarget(self, action: #selector(sliderTouchUpInside), for: .touchUpInside)
    }
    
    @objc func sliderTouchDragInside(_ sender: UISlider) {
        
    }
    
    @objc func sliderTouchUpInside(_ sender: UISlider) {
        
    }
}
