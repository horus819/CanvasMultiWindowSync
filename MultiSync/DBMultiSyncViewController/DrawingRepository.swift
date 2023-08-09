//
//  DrawingRepository.swift
//  MultiSync
//
//  Created by Jun Ho JANG on 2023/07/10.
//

import Foundation

protocol DrawingRepository {
    func fetchLines(completion: @escaping (Result<[Line], Error>) -> Void)
    func save(line: Line, completion: @escaping (Result<Line, Error>) -> Void) throws
}

enum TraceRepositoryError: Error {
    case decrypt
    case encrypt
    case decode
    case encode
}

final class DefaultDrawingRepository: DrawingRepository {

    private var drawingStorage: DrawingStorage

    init(drawingStorage: DrawingStorage) {
        self.drawingStorage = drawingStorage
    }
    
}

extension DefaultDrawingRepository {
    func fetchLines(completion: @escaping (Result<[Line], Error>) -> Void) {
        drawingStorage.fetchTraces { [weak self] result in
            do {
                switch result {
                case .success(let entity):
                    let decoded = try entity.map { try JSONDecoder().decode(Line.self, from: $0.drawing) }
                    completion(.success(decoded))
                    
                case .failure(let error):
                    completion(.failure(error))
                    
                }
            } catch {
                
            }
        }
    }

    func save(line: Line, completion: @escaping (Result<Line, Error>) -> Void) throws {
        let encoded = try JSONEncoder().encode(line)
        drawingStorage.save(data: encoded) { result in
            switch result {
            case .success(_):
                completion(.success(line))
                
            case .failure(let error):
                completion(.failure(error))
                
            }
        }
    }

}
