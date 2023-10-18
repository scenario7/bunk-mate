//
//  Lecture+CoreDataProperties.swift
//  bunk-mate
//
//  Created by Kevin Thomas on 12/10/23.
//
//

import Foundation
import CoreData


extension Lecture {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Lecture> {
        return NSFetchRequest<Lecture>(entityName: "Lecture")
    }

    @NSManaged public var blueValue: Double
    @NSManaged public var day: Int16
    @NSManaged public var endTime: Date?
    @NSManaged public var greenValue: Double
    @NSManaged public var redValue: Double
    @NSManaged public var startTime: Date?
    @NSManaged public var toSubject: Subject?

}

extension Lecture : Identifiable {

}
