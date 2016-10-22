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

    
    // MARK: - Segue Operations
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "venueDetailSegue" {
            
            let venueDetailController = segue.destinationViewController as! VenueDetailViewController
            venueDetailController.container = self
            
        }
        
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {

        if scrollView.contentOffset.y < -99 {
            closeAction(nil)
        }

    }
    
    
    @IBAction func closeAction(sender: AnyObject?) {
        
        self.dismissViewControllerAnimated(true) {
            
        }
        
    }
    
    
}



