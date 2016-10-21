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
    
    var name: String?
    var detail: String?
    var thumbsdown: Bool
    var imagePath: String?
    var localReview: String?
    var rating: Int?
    var distance: String!
    
    init(name: String?, detail: String?, thumbsdown: Bool, imagePath: String?, localReview: String?, rating: Int?, distance: String!) {

        self.name = name
        self.detail = detail
        self.thumbsdown = thumbsdown
        self.imagePath = imagePath
        self.localReview = localReview
        self.rating = rating
        self.distance = distance
        
    }
    
}


