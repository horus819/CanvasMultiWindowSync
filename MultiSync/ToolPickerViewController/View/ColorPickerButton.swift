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
                self.setTitle("Selected", for: .normal)
            } else {
                self.setTitle("Black", for: .normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setTitle("Black", for: .normal)
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
    
}

final class RedColorPickerButton: UIButton, DrawerButton {
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.setTitle("Selected", for: .normal)
            } else {
                self.setTitle("Red", for: .normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setTitle("Red", for: .normal)
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
    
}

final class BlueColorPickerButton: UIButton, DrawerButton {
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.setTitle("Selected", for: .normal)
            } else {
                self.setTitle("Blue", for: .normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setTitle("Blue", for: .normal)
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

}

final class YellowColorPickerButton: UIButton, DrawerButton {
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.setTitle("Selected", for: .normal)
            } else {
                self.setTitle("Yellow", for: .normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setTitle("Yellow", for: .normal)
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

}

final class GreenColorPickerButton: UIButton, DrawerButton {
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.setTitle("Selected", for: .normal)
            } else {
                self.setTitle("Green", for: .normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setTitle("Green", for: .normal)
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

}

final class ColorPickerButton: UIButton, DrawerButton {
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.setTitle("Selected", for: .normal)
            } else {
                self.setTitle("Picker", for: .normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setTitle("Picker", for: .normal)
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

}
