//
//  Employee+CoreDataProperties.swift
//  CoreDataSampleApp
//
//  Created by rahulverma on 15/8/23.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var name: String?
    @NSManaged public var designation: String?
    @NSManaged public var department: String?
    @NSManaged public var age: Int16

}

extension Employee : Identifiable {

}
