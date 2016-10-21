//
//  ModelResponse.swift
//  test
//
//  Created by Gaurav Singh on 20/10/16.
//  Copyright © 2016 Gaurav Singh. All rights reserved.
//

import Foundation


enum ResponseType {
    case success
    case failure
    case networkError
}


public class ModelResponse {

    var type: ResponseType
    
    init(type: ResponseType) {
        self.type = type
    }

}




public class FoodVenueResponse: ModelResponse {
    
    var list: [FoodVenue]?

}


