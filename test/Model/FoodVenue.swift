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
    var imagePath: String?
    var distance: String!
    var verbose: AnyObject?
    
    init(id: String!, name: String?, imagePath: String?, rating: Int?, distance: String!, verbose: AnyObject?) {
        
        self.id = id
        self.name = name
        self.imagePath = imagePath
        self.rating = rating
        self.distance = distance
        self.verbose = verbose
        
    }
    
}


