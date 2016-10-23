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

    
    var venueDetail: FoodVenueDetails!
    var reviewController: ReviewViewController!
    var detailController: VenueDetailViewController!

    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        
        scrollView.alpha = 0
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        UIView.animateWithDuration(0.5) {
            self.scrollView.alpha = 1
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
            detailController = segue.destinationViewController as! VenueDetailViewController
            detailController.container = self
            
        case "addLocalReview":
            reviewController = segue.destinationViewController as! ReviewViewController
            reviewController.container = self
            
        default:
            //No case
            
            break
        }
        
        
        
    }
    
    
}



