//
//  Food.swift
//  test
//
//  Created by Gaurav Singh on 20/10/16.
//  Copyright © 2016 Gaurav Singh. All rights reserved.
//

import UIKit
import Foundation



public class FoodVenue {
    
    var id: String!
    var rating: Int?
    var name: String?
    var thumbImagePath: String?
    var distance: String!
    var verbose: AnyObject?
    
    init(id: String!, name: String?, thumbImagePath: String?, rating: Int?, distance: String!, verbose: AnyObject?) {
        
        self.id = id
        self.name = name
        self.thumbImagePath = thumbImagePath
        self.rating = rating
        self.distance = distance
        self.verbose = verbose
        
    }
    
}


public class FoodVenueDetails: FoodVenue {

    var thumbsdown: Bool
    var localReview: String?
    var formattedAddress: String?
    var fullImagePath: String?

    init(withFoodVenue venue:FoodVenue) {

        self.thumbsdown = false
        super.init(id: venue.id, name: venue.name, thumbImagePath: venue.thumbImagePath, rating: venue.rating, distance: venue.distance, verbose: venue.verbose)

    }

}
