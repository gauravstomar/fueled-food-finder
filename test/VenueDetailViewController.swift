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
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var verboseTableView: UITableView!
    
    var container: VenueDetailContainerViewController!
    private var verboseListings = [VenueListingGroup]()
    
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
    
    override func viewDidLoad() {
        
        verboseTableView.backgroundColor = UIColor.clearColor()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        updateVenueDetails()
        
    }
    
    internal func updateVenueDetails() {
        
        if (container.venueDetail != nil) {
            
            FoodFacade.detail(ofVenue: container.venueDetail) { (response) in
                
                if let venueDetail = response.details {
                    self.container.venueDetail = venueDetail
                    self.reloadVenueDetaisViews()
                } else {
                    return
                }
                
            }
            
        }

    }
    
    
    private func reloadVenueDetaisViews() {

        let venue = container.venueDetail
        
        self.thumbsDownButton.alpha = ( venue.thumbsdown ? 0.25 : 1 )

        if let url = NSURL(string: venue.fullImagePath!) where venue.fullImagePath != nil {
            
            let placeholderImage = UIImage(named: "foodPlaceholder")
            
            let h = UIScreen.mainScreen().bounds.height / 2

            if Int(h) < venue.fullImageHight {
                imageViewHeight.constant = h
            } else {
                imageViewHeight.constant = CGFloat(venue.fullImageHight)
            }

            imageView.af_setImageWithURL(url,
                                         placeholderImage: placeholderImage,
                                         filter: nil,
                                         progress: nil,
                                         progressQueue: dispatch_get_main_queue(),
                                         imageTransition: UIImageView.ImageTransition.FlipFromTop(0.5),
                                         runImageTransitionIfCached: false,
                                         completion: { _ in
                                            self.imageView.contentMode = .ScaleAspectFit
                                            })
            
        }

        nameLabel.text = venue.name
        ratingsLabel.text = "🚖\( venue.distance ) away"
        distanceLabel.text = "⭐️\( venue.rating != nil ? "\(venue.rating!)/10 Ratings" : "N/A" )"

        verboseListings = [VenueListingGroup]()
        
        let localReview = venue.localReview?.characters.count > 0 ? venue.localReview : "N/A"
        verboseListings.append(VenueListingGroup(title: "My Review", rows: [VenueListingItem(title: localReview)]))
        verboseListings.append(VenueListingGroup(title: "Address", rows: [VenueListingItem(title: venue.formattedAddress)]))
        verboseListings.append(VenueListingGroup(title: "URL", rows: [VenueListingItem(title: venue.url)]))
        verboseListings.append(VenueListingGroup(title: "Categories", rows: [VenueListingItem(title: venue.categories)]))
        verboseListings.append(VenueListingGroup(title: "Here now", rows: [VenueListingItem(title: venue.hereNow)]))
        verboseListings.append(VenueListingGroup(title: "Verified", rows: [VenueListingItem(title: (venue.verified ? "✔︎ Verified" : "✘ Not Verified"))]))

        verboseTableView.reloadData()
    
    }
    
    
    
}


extension VenueDetailViewController: UITableViewDelegate, UITableViewDataSource {


    func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return verboseListings.count
        
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return verboseListings[section].rows.count

    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("VenueDetailCell", forIndexPath: indexPath) as! VenueDetailCell
        
        let obj = verboseListings[indexPath.section].rows[indexPath.row]
        
        cell.detailLabel.text = obj.title
        cell.selectionStyle = .None
        
        return cell
        
    }

    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return verboseListings[section].title
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {

        if let headerView = view as? UITableViewHeaderFooterView, let textLabel = headerView.textLabel {
            textLabel.font = UIFont.systemFontOfSize(12, weight: UIFontWeightUltraLight)
            headerView.backgroundView?.backgroundColor = UIColor.clearColor()
            headerView.contentView.backgroundColor = UIColor.clearColor()
            textLabel.textColor = UIColor.whiteColor()
        }
        
    }
    


}



class VenueDetailCell: UITableViewCell {

    @IBOutlet weak var detailLabel: UILabel!
}


private class VenueListingGroup {
    
    var title: String?
    var rows: [VenueListingItem]!
    
    init(title: String?, rows: [VenueListingItem]) {
        self.title = title
        self.rows = rows
    }
}


private class VenueListingItem {
    var title: String?
    
    init(title: String?) {
        self.title = title
    }
}






