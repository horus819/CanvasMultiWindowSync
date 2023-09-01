//
//  WidthButton.swift
//  MultiSync
//
//  Created by Jun Ho JANG on 2023/09/01.
//

import UIKit

final class LightWidthButton: UIButton, DrawerButton {
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.setTitle("Selected", for: .normal)
            } else {
                self.setTitle("Light", for: .normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setTitle("Light", for: .normal)
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
final class MediumWidthButton: UIButton, DrawerButton {
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.setTitle("Selected", for: .normal)
            } else {
                self.setTitle("Medium", for: .normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setTitle("Medium", for: .normal)
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
final class HeavyWidthButton: UIButton, DrawerButton {
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.setTitle("Selected", for: .normal)
            } else {
                self.setTitle("Heavy", for: .normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setTitle("Heavy", for: .normal)
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
