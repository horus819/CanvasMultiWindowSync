//
//  RuntimeSyncViewModel.swift
//  MultiSync
//
//  Created by Jun Ho JANG on 2023/07/10.
//

import Foundation
import Combine
import PencilKit

protocol RuntimeSyncViewModel {
    var strokesPublisher: AnyPublisher<[PKStroke], Never> { get }
    
    func didLoadStrokes()
    func didDraw(stroke: [PKStroke])
}

final class DefaultRuntimeSyncViewModel: RuntimeSyncViewModel {
    
    private let strokes: CurrentValueSubject<[PKStroke], Never>
    var strokesPublisher: AnyPublisher<[PKStroke], Never> {
        strokes.eraseToAnyPublisher()
    }
    
    init() {
        self.strokes = CurrentValueSubject([])
    }
    
    func didLoadStrokes() {
        strokes.send([])
    }
    
    func didDraw(stroke: [PKStroke]) {
        strokes.value = stroke
    }
    
}
