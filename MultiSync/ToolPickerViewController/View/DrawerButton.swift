//
//  DrawerButton.swift
//  MultiSync
//
//  Created by Jun Ho JANG on 2023/08/31.
//

import UIKit

protocol DrawerButton {
    var isSelected: Bool { get set }
    
    func setSelected(to bool: Bool)
    func set(action: UIAction, for event: UIControl.Event)
    func set(backgroundcolor: UIColor)
}

final class PenButton: UIButton, DrawerButton {
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                
            } else {
                
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setTitle("Pen", for: .normal)
        self.setTitleColor(.black, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.isSelected = false
    }
    
    func setSelected(to bool: Bool) {
        isSelected = bool
    }
    
    func set(action: UIAction, for event: UIControl.Event) {
        addAction(action, for: event)
    }
    
    func set(backgroundcolor: UIColor) {
        backgroundColor = backgroundcolor
    }
    
}

final class MarkerButton: UIButton, DrawerButton {
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                
            } else {
                
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setTitle("Marker", for: .normal)
        self.setTitleColor(.black, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.isSelected = false
    }
    
    func setSelected(to bool: Bool) {
        isSelected = bool
    }
    
    func set(action: UIAction, for event: UIControl.Event) {
        addAction(action, for: event)
    }
    
    func set(backgroundcolor: UIColor) {
        backgroundColor = backgroundcolor
    }
    
}
