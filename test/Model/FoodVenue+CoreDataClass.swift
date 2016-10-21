//
//  Food+CoreDataClass.swift
//  
//
//  Created by Gaurav Singh on 20/10/16.
//
//

import Foundation
import CoreData


public class FoodVenueMO: NSManagedObject {

    @NSManaged public var venueId: String?
    @NSManaged public var thumbsDown: Bool
    @NSManaged public var localReview: String?

}
