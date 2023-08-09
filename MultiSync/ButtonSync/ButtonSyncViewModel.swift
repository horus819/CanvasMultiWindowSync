//
//  ButtonSyncViewModel.swift
//  MultiSync
//
//  Created by Jun Ho JANG on 2023/08/07.
//

import Foundation
import Combine

protocol ButtonSyncViewModel {
    var isSelected: Bool { get }
    var selected: CurrentValueSubject<Bool, Never> { get }
    
    func toggleSelectButton()
}

final class DefaultButtonSyncViewModel: ButtonSyncViewModel {
    
    var isSelected: Bool
    var selected: CurrentValueSubject<Bool, Never>
    
    init(selection: Selection) {
        self.isSelected = selection.isSelected
        self.selected = .init(isSelected)
    }
    
    func toggleSelectButton() {
        if isSelected {
            isSelected = false
        } else {
            isSelected = true
        }
    }
    
}
