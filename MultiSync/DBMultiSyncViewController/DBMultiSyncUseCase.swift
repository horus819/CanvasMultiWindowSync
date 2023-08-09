//
//  DBMultiSyncUseCase.swift
//  MultiSync
//
//  Created by Jun Ho JANG on 2023/07/10.
//

import Foundation

protocol DBMultiSyncUseCase {
    func executeSave(line: Line, completion: @escaping (Result<Line, Error>) -> Void) throws
    func executeFetch(completion: @escaping (Result<[Line], Error>) -> Void)
}

final class DefaultDBMultiSyncUseCase: DBMultiSyncUseCase {
    
    private let repository: DrawingRepository
    
    init(repository: DrawingRepository) {
        self.repository = repository
    }
    
    func executeSave(line: Line, completion: @escaping (Result<Line, Error>) -> Void) throws {
        try repository.save(line: line, completion: completion)
    }
    
    func executeFetch(completion: @escaping (Result<[Line], Error>) -> Void) {
        repository.fetchLines(completion: completion)
    }
    
}
