//
//  CombineMultiSyncViewModel.swift
//  MultiSync
//
//  Created by Jun Ho JANG on 2023/07/10.
//

import Foundation
import Combine
import PencilKit

protocol CombineMultiSyncViewModel {
    var drawingPublisher: AnyPublisher<[PKDrawing], Never> { get }
    
    func didLoadDrawing()
    func didFetchDrawing(_ drawing: PKDrawing)
}

final class DefaultCombineMultiSyncViewModel: CombineMultiSyncViewModel {
    
    private let drawingData: CurrentValueSubject<[PKDrawing], Never>
    var drawingPublisher: AnyPublisher<[PKDrawing], Never> {
        drawingData.eraseToAnyPublisher()
    }
    
    init() {
        self.drawingData = .init([])
    }
    
    func didLoadDrawing() {
        drawingData.send([PKDrawing()])
    }
    
    func didFetchDrawing(_ drawing: PKDrawing) {
        drawingData.value.append(drawing)
    }
    
}
