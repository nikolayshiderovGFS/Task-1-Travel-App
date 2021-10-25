//
//  Landmark+CoreDataProperties.swift
//  Checklists
//
//  Created by Nikolay Shiderov on 25.10.21.
//
//

import Foundation
import CoreData


extension Landmark {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Landmark> {
        return NSFetchRequest<Landmark>(entityName: "Landmark")
    }

    @NSManaged public var lmname: String?
    @NSManaged public var lmdescription: String?

}

extension Landmark : Identifiable {

}
