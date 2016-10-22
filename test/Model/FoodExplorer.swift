//
//  FoodExplorer.swift
//  test
//
//  Created by Gaurav Singh on 20/10/16.
//  Copyright © 2016 Gaurav Singh. All rights reserved.
//

import Foundation
import CoreLocation
import QuadratTouch
import CoreStore




class FoodExplorer {
    
    
    var session : Session!

    
    init() {
        
        let client = Client(clientID:       "LWRI25HSJG0CZ2J3AKVBITLA0HAXNGAZVRLJ1N12YUMBGD4Z",
                            clientSecret:   "OAPOE0LKSDZ5ZGIZ0IBAEASZAYHBED0GKREQD0CNZT3YFUTV",
                            redirectURL:    "testapp123://foursquare")
        
        var configuration = Configuration(client:client)
        configuration.shouldControllNetworkActivityIndicator = true
        
        Session.setupSharedSessionWithConfiguration(configuration)
        
        session = Session.sharedSession()
        session.logger = ConsoleLogger()

    }
    
    
    func findVenuesByLocation(location: CLLocation!, complition: (FoodVenueResponse -> Void)) {
        
        let fvResponse = FoodVenueResponse(type: .failure)
        var fvResponseList = [FoodVenue]()

        let ll      = "\(location.coordinate.latitude),\(location.coordinate.longitude)"
        let llAcc   = "\(location.horizontalAccuracy)"
        let alt     = "\(location.altitude)"
        let altAcc  = "\(location.verticalAccuracy)"
    
        let parameters = [
            Parameter.ll:ll,
            Parameter.llAcc:llAcc,
            Parameter.alt:alt,
            Parameter.altAcc:altAcc,
            Parameter.venuePhotos: "1",
            Parameter.query: "Food",
            Parameter.limit: "50",
            Parameter.offset: "0",
            Parameter.sortByDistance: "1"
        ]
        
        
        let task = session.venues.explore(parameters) { (result) -> Void in
            
            
            if !NSThread.isMainThread() {
                fatalError("!!!")
            }
            
            if let response = result.response {
                
                if let groups = response["groups"] as? [[String: AnyObject]]  {
                    for group in groups {
                        if let items = group["items"] as? [[String: AnyObject]] {
                            for item in items {
                                if let venueInfo = item["venue"] {

                                    var imageURL: String = ""
                                    if let featuredPhotos = venueInfo["featuredPhotos"] as? [String: AnyObject] {
                                        if let imgItems = featuredPhotos["items"] as? [[String: AnyObject]] where imgItems.first != nil {
                                            if let prefix = imgItems.first!["prefix"] as? String , let suffix = imgItems.first!["suffix"] as? String {
                                                let size = Int(UIScreen.mainScreen().bounds.size.width/2 * UIScreen.mainScreen().scale)
                                                imageURL = prefix + "\(size)x\(size)" + suffix
                                            }
                                        }
                                    }
                                    
                                    let id = venueInfo["id"] as? String
                                    let name = venueInfo["name"] as? String
                                    let rating = venueInfo["rating"] as? Int
                                    var distance = "N/A"
                                    
                                    if let location = venueInfo["location"] as? [String: AnyObject] {
                                        if let distanceRaw = location["distance"] as? Int {
                                            distance = distanceRaw < 1000 ? "\(distanceRaw) m" :  "\(distanceRaw/1000) km"
                                        }
                                    }

                                    //print(venueInfo)
                                    //let localreview = venueInfo[""]

                                    fvResponseList.append(FoodVenue(id: id, name: name, detail: "", thumbsdown: false, imagePath: imageURL, localReview: "", rating: rating, distance: distance))

                                }
                            }
                        }
                    }
                }
                
                fvResponse.list = fvResponseList
                fvResponse.type = .success

                complition(fvResponse)
                
                
            } else if let error = result.error  where !result.isCancelled() {
                
                print(error.localizedDescription)
                fvResponse.type = .failure
                complition(fvResponse)
                
            }
            
            
        }
        
        task.start()
        
    }
    
    
    
    
    
    func addReviewToVenue(review: String, venueId: String) {
        
        print(venueId)
        
        CoreStore.beginAsynchronous { (transaction) in
            
            if let fvMO = transaction.fetchOne(From(FoodVenueMO), Where("venueId = %@", venueId)) {
            
                fvMO.localReview = review
            
            } else {

                let fvMO = FoodVenueMO()
                fvMO.venueId = venueId
                fvMO.localReview = review

            }

            transaction.commit()
            
        }
        
    }
    
    
    
    func addThumbsDownToVenue(thumb: Bool, venueId: String) {

        CoreStore.beginAsynchronous { (transaction) in
            
            if let fvMO = transaction.fetchOne(From(FoodVenueMO), Where("venueId = %@", venueId)) {
                
                fvMO.thumbsDown = thumb
                
            } else {
                
                let fvMO = FoodVenueMO()
                fvMO.venueId = venueId
                fvMO.thumbsDown = thumb
                
            }
            
            transaction.commit()
            
        }
    }

    
    private func thumbsDownOfVenue(venueId: String) -> Bool {
        
        guard let fvMO = CoreStore.fetchOne(From(FoodVenueMO), Where("venueId = %@", venueId)) else {
            return false
        }
        
        return fvMO.thumbsDown

    }

    
    private func reviewOfVenue(venueId: String) -> String? {
    
        guard let fvMO = CoreStore.fetchOne(From(FoodVenueMO), Where("venueId = %@", venueId)) else {
            return nil
        }
        
        return fvMO.localReview
        
    }
    
    
}
