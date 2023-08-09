//
//  DrawingEntity.swift
//  MultiSync
//
//  Created by Jun Ho JANG on 2023/07/10.
//

import Foundation
import CoreData

enum EncryptedTraceEntityError: Error {
    case cannotConvertToDomain
    case cannotInitializeEncryptedTraceEntity
}

@objc(DrawingEntity)
public class DrawingEntity: NSManagedObject {
    
    @NSManaged public var drawing: Data
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<DrawingEntity> {
        return NSFetchRequest<DrawingEntity>(entityName: "DrawingEntity")
    }
    
}

extension DrawingEntity {
    convenience init(drawing: Data, insertInto context: NSManagedObjectContext) throws {
        self.init(context: context)
        do {
            self.drawing = drawing
            try context.save()
        } catch {
            throw EncryptedTraceEntityError.cannotInitializeEncryptedTraceEntity
        }
    }
    
    func toDomain() -> Line {
        return .init(data: drawing)
    }
}

