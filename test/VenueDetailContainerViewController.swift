//
//  VenueDetailContainerViewController.swift
//  test
//
//  Created by Gaurav Singh on 22/10/16.
//  Copyright © 2016 Gaurav Singh. All rights reserved.
//

import Foundation
import UIKit

class VenueDetailContainerViewController: UIViewController, UIScrollViewDelegate {

    
    var venueDetail: FoodVenue!

    func scrollViewDidScroll(scrollView: UIScrollView) {

        if scrollView.contentOffset.y < -99 {
            closeAction(nil)
        }

    }
    
    
    @IBAction func closeAction(sender: AnyObject?) {
        
        self.dismissViewControllerAnimated(true) {
            
        }
        
    }
    
    
    func addReviewAction() {
        
        performSegueWithIdentifier("addLocalReview", sender: self)

    }
    
    
    // MARK: - Segue Operations
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        guard let identifier = segue.identifier else {
            return
        }
        
        switch identifier {
            
        case "venueDetailSegue":
            let venueDetailController = segue.destinationViewController as! VenueDetailViewController
            venueDetailController.container = self
            
        case "addLocalReview":
            let reviewController = segue.destinationViewController as! ReviewViewController
            reviewController.container = self
            
        default:
            //No case
            
            break
        }
        
        
        
    }
    
    
}



