//
//  DrawingStorage.swift
//  MultiSync
//
//  Created by Jun Ho JANG on 2023/07/10.
//

import Foundation
import CoreData

enum TraceStorageError: Error {
    case fetch
    case save
    case delete
    case update
}

protocol DrawingStorage {
    func fetchTraces(completion: @escaping (Result<[DrawingEntity], Error>) -> Void)
    func save(data: Data, completion: @escaping (Result<DrawingEntity, Error>) -> Void)
}

final class DefaultDrawingStorage {
    
    private let coreDataStorage: CoreDataStorage

    init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
        self.coreDataStorage = coreDataStorage
    }
    
}

extension DefaultDrawingStorage: DrawingStorage {
    func fetchTraces(completion: @escaping (Result<[DrawingEntity], Error>) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            do {
                let request: NSFetchRequest = DrawingEntity.fetchRequest()
                let result = try context.fetch(request)
                completion(.success(result))
            } catch {
                completion(.failure(TraceStorageError.fetch))
            }
        }
    }

    func save(data: Data, completion: @escaping (Result<DrawingEntity, Error>) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            do {
                let entity = try DrawingEntity(drawing: data, insertInto: context)
                entity.drawing = data
                try context.save()
                completion(.success(entity))
            } catch {
                completion(.failure(TraceStorageError.save))
            }
        }
    }

}
