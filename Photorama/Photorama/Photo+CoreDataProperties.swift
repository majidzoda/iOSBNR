//
//  Photo+CoreDataProperties.swift
//  Photorama
//
//  Created by Firdavsii Majidzoda on 2/8/23.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var dateTaken: Date?
    @NSManaged public var photoID: String?
    @NSManaged public var remoteURL: URL?
    @NSManaged public var title: String?
    @NSManaged public var vitewsTotal: Int16

}

extension Photo : Identifiable {

}
