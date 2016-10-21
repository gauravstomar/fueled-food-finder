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


}



