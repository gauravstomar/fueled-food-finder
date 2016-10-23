//
//  Review.swift
//  test
//
//  Created by Gaurav Singh on 22/10/16.
//  Copyright © 2016 Gaurav Singh. All rights reserved.
//

import Foundation
import UIKit


class ReviewViewController: UIViewController {

    
    var didUpdatedReview: (Void->Void)?
    var container: VenueDetailContainerViewController!
    
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var popupWidth: NSLayoutConstraint!
    @IBOutlet weak var popupBottom: NSLayoutConstraint!
    
    
    override func viewDidLoad() {

        popupView.layer.shadowColor = UIColor.blackColor().CGColor
        popupView.layer.shadowOffset = CGSize(width: 1, height: 1)
        popupView.layer.shadowOpacity = 0.5
        popupView.layer.shadowRadius = 5
        popupView.layer.masksToBounds =  false
        
        textView.alpha = 0
        popupView.alpha = 0
        popupWidth.constant -= 120
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ReviewViewController.keyboardUpdated(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ReviewViewController.keyboardUpdated(_:)), name: UIKeyboardWillHideNotification, object: nil)


        if let localReview = container.venueDetail.localReview {
            textView.text = localReview
        }
        
    }
    
    
    func keyboardUpdated(notification: NSNotification) {
        
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
            
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                self.popupBottom.constant = keyboardSize.height + 50
                self.view.layoutIfNeeded()
            }
            
            }, completion: { _ in
                
                
        })
        
    }

    override func viewDidAppear(animated: Bool) {

        self.textView.becomeFirstResponder()

        UIView.animateWithDuration(0.25) {
            self.popupView.alpha = 1
        }
        
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.AllowUserInteraction, animations: {
    
            self.popupWidth.constant += 120
            self.popupView.layoutIfNeeded()
            
            }) { (_) in
                
                UIView.animateWithDuration(0.25, animations: { 
                    self.textView.alpha = 1
                })

        }

    
    }
    
    @IBAction func doneAction(sender: AnyObject) {
        
        FoodFacade.addReview(toVenue: container.venueDetail.id, review: textView.text) { (response) in
            
            if response.type == .success {
                self.container.detailController.updateVenueDetails()
                self.closeView()
            } else {
                
            }
            
        }

    }
    
    @IBAction func cancleAction(sender: AnyObject) {
        
        closeView()
        
    }
    
    @IBAction func closeAction(sender: AnyObject) {
        
        closeView()
        
    }
    
    func closeView() {

        textView.resignFirstResponder()
        dismissViewControllerAnimated(true) {
            
        }

    }
    
    
}



