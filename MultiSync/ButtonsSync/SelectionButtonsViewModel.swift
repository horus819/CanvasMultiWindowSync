//
//  SelectionButtonsViewModel.swift
//  MultiSync
//
//  Created by Jun Ho JANG on 2023/08/08.
//

import Foundation

struct Selections {
    let isSelected: [Bool] = [false, false, false, false, false, false, false]
}

protocol SelectionButtonsViewModel {
    var isSelectedArray: [Bool] { get }
    
    func toggleSelection(at index: Int)
}

final class DefaultSelectionButtonsViewModel: SelectionButtonsViewModel {
    
    private(set) var isSelectedArray: [Bool]
    
    init(selections: Selections) {
        self.isSelectedArray = selections.isSelected
    }
    
    func toggleSelection(at index: Int) {
        if isSelectedArray[index] {
            isSelectedArray[index] = false
        } else {
            isSelectedArray[index] = true
        }
    }
    
}
