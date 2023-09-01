//
//  ColorPickerButton.swift
//  MultiSync
//
//  Created by Jun Ho JANG on 2023/09/01.
//

import UIKit

final class BlackColorPickerButton: UIButton, DrawerButton {
    
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

final class RedColorPickerButton: UIButton, DrawerButton {
    
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

final class BlueColorPickerButton: UIButton, DrawerButton {
    
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

final class YellowColorPickerButton: UIButton, DrawerButton {
    
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

final class GreenColorPickerButton: UIButton, DrawerButton {
    
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
