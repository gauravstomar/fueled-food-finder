//
//  VenueDetailViewController.swift
//  test
//
//  Created by Gaurav Singh on 22/10/16.
//  Copyright © 2016 Gaurav Singh. All rights reserved.
//

import Foundation
import UIKit



class VenueDetailViewController: UIViewController {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingsLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var thumbsDownButton: UIButton!
    @IBOutlet weak var verboseTextView: UITextView!
    @IBOutlet weak var verboseTextHeight: NSLayoutConstraint!
    
    
    var container: VenueDetailContainerViewController!

    
    @IBAction func reviewAction(sender: AnyObject) {

        container.addReviewAction()
        
    }
    
    @IBAction func thumbsDownAction(sender: AnyObject) {

        FoodFacade.addThumbsDown(toVenue: container.venueDetail.id) { (_) in

            UIView.animateWithDuration(0.25, animations: { 
                self.thumbsDownButton.alpha = 0.25
            })

        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
    
        let venue = container.venueDetail
        

       // self.thumbsDownButton.alpha = ( venue.thumbsdown ? 0.25 : 1 )

        
        if let url = NSURL(string: venue.imagePath!) where venue.imagePath != nil {
            
            let placeholderImage = UIImage(named: "foodPlaceholder")
            
            imageView.af_setImageWithURL(url,
                                         placeholderImage: placeholderImage,
                                         filter: nil,
                                         progress: nil,
                                         progressQueue: dispatch_get_main_queue(),
                                         imageTransition: UIImageView.ImageTransition.CrossDissolve(0.5),
                                         runImageTransitionIfCached: false,
                                         completion: { _ in })
        
            
            nameLabel.text = venue.name
            ratingsLabel.text = "🚖\( venue.distance ) away"
            distanceLabel.text = "⭐️\( venue.rating != nil ? "\(venue.rating!)/10 Ratings" : "N/A" )"


            
            verboseTextHeight.constant = verboseTextView.sizeThatFits(verboseTextView.bounds.size).height
            
        }

    }
    
    
    
    
    
    
}





