//
//  Subject+CoreDataProperties.swift
//  bunk-mate
//
//  Created by Kevin Thomas on 12/10/23.
//
//

import Foundation
import CoreData


extension Subject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Subject> {
        return NSFetchRequest<Subject>(entityName: "Subject")
    }

    @NSManaged public var attended: Double
    @NSManaged public var missed: Double
    @NSManaged public var name: String?
    @NSManaged public var requirement: Double
    @NSManaged public var toLectures: NSSet?

}

// MARK: Generated accessors for toLectures
extension Subject {

    @objc(addToLecturesObject:)
    @NSManaged public func addToToLectures(_ value: Lecture)

    @objc(removeToLecturesObject:)
    @NSManaged public func removeFromToLectures(_ value: Lecture)

    @objc(addToLectures:)
    @NSManaged public func addToToLectures(_ values: NSSet)

    @objc(removeToLectures:)
    @NSManaged public func removeFromToLectures(_ values: NSSet)

}

extension Subject : Identifiable {

}
