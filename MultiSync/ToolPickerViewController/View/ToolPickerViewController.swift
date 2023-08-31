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
        let toolPickerView = ToolPickerView()
        toolPickerView.translatesAutoresizingMaskIntoConstraints = false
        return toolPickerView
    }()
    private var inkingTool: PKInkingTool = {
        let inkingTool = PKInkingTool(.pen)
        return inkingTool
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(toolPickerView)
        toolPickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        toolPickerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        toolPickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        toolPickerView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        setActions()
    }
    
    private func setActions() {
        let penAction = UIAction { action in
            self.inkingTool.inkType = .pen
        }
        
        let markerAction = UIAction { action in
            self.inkingTool.inkType = .marker
        }
        
        toolPickerView.set(penAction: penAction, markerAction: markerAction, for: .touchUpInside)
    }
    
}
