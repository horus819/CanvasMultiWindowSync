//
//  DBMultiSyncViewModel.swift
//  MultiSync
//
//  Created by Jun Ho JANG on 2023/07/10.
//

import Foundation
import Combine

protocol DBMultiSyncViewModel {
    var drawingDataPublisher: AnyPublisher<[Line], Never> { get }
    
    func didLoadInitialDrawingData()
    func didDraw(line: Line)
}

final class DefaultDBMultiSyncViewModel: DBMultiSyncViewModel {
    
    private let useCase: DBMultiSyncUseCase
    
    private let drawingData: CurrentValueSubject<[Line], Never>
    var drawingDataPublisher: AnyPublisher<[Line], Never> {
        drawingData.eraseToAnyPublisher()
    }
    
    init(useCase: DBMultiSyncUseCase) {
        self.useCase = useCase
        self.drawingData = .init([])
    }
    
    func didLoadInitialDrawingData() {
        useCase.executeFetch { [weak self] result in
            switch result {
            case .success(let data):
                self?.drawingData.send(data)
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    func didDraw(line: Line) {
        do {
            try useCase.executeSave(line: line) { result in
                switch result {
                case .success(let success):
                    print(success)
                    
                case .failure(let error):
                    print(error)
                    
                }
            }
        } catch {
            
        }
    }
    
}
