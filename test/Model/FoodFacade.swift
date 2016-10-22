//
//  ModelFacade.swift
//  test
//
//  Created by Gaurav Singh on 20/10/16.
//  Copyright © 2016 Gaurav Singh. All rights reserved.
//

import Foundation
import CoreLocation
import QuadratTouch


class FoodFacade {
    
    private static var foodExplorer = FoodExplorer()
    
    static func exploreVenues(by location: CLLocation, complition: (FoodVenueResponse -> Void)) {
        foodExplorer.findVenuesByLocation(location, complition: complition)
    }

    static func addReview(toVenue venueId: String, review: String, complition: (VenueReviewResponse -> Void)) {
        foodExplorer.addReviewToVenue(review, venueId: venueId, complition: complition)
    }
    
    static func addThumbsDown(toVenue venueId: String, complition: (VenueReviewResponse -> Void)) {
        foodExplorer.addThumbsDownToVenue(false, venueId: venueId, complition: complition)
    }
    
    
    
    
}



