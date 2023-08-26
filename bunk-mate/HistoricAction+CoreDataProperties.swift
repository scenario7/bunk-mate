//
//  HistoricAction+CoreDataProperties.swift
//  bunk-mate
//
//  Created by Kevin Thomas on 26/08/23.
//
//

import Foundation
import CoreData


extension HistoricAction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HistoricAction> {
        return NSFetchRequest<HistoricAction>(entityName: "HistoricAction")
    }

    @NSManaged public var attended: Bool
    @NSManaged public var dateSavedAt: Date?
    @NSManaged public var incremented: Bool
    @NSManaged public var subjectName: String?

}

extension HistoricAction : Identifiable {

}
