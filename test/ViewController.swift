//
//  ViewController.swift
//  test
//
//  Created by Gaurav Singh on 19/10/16.
//  Copyright © 2016 Gaurav Singh. All rights reserved.
//

import UIKit
import CoreLocation
import AlamofireImage

class ViewController: UIViewController {

    
    var currentLocation: CLLocation?
    var locationManager = CLLocationManager()

    var venueItems: [FoodVenue]?
    @IBOutlet weak var headerHeight: NSLayoutConstraint!

    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var listingCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        listingCollectionView.contentInset = UIEdgeInsetsMake(74, 0, 10, 0)
        headerHeight.constant = view.bounds.height-20
        
    }

    override func viewDidAppear(animated: Bool) {
    
        super.viewDidAppear(animated)

 
        listingCollectionView.alpha = 0
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        locationManagerDidUpdatedStatus(CLLocationManager.authorizationStatus())

    }
    
    
    func initialViewAdjustment() {

        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: UIViewAnimationOptions.AllowUserInteraction, animations: {

            self.listingCollectionView.alpha = 1
            self.headerHeight.constant = 64
            self.view.layoutIfNeeded()
    
            }) { (_) in
                
                self.activityIndicator.stopAnimating()
                
        }

    }
    
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        
        listingCollectionView.performBatchUpdates(nil, completion: { (_) in
            
        })
        
    }
    
    
    // MARK: - Segue Operations
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "detailContainerSegue" {
            
            
            guard let cell = sender as? UICollectionViewCell else {
                return
            }
            
            guard let indexPath = listingCollectionView.indexPathForCell(cell) else {
                return
            }
            
            guard let venue = venueItems?[indexPath.row] else {
                return
            }
            
            
            let venueDetailController = segue.destinationViewController as! VenueDetailContainerViewController
            venueDetailController.venueDetail = FoodVenueDetails(withFoodVenue: venue)
            
            
        }
        
    }

}


extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let itemsCount = venueItems?.count else {
            return 0
        }
        return itemsCount
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        guard let venue = venueItems?[indexPath.item], let cell = collectionView.dequeueReusableCellWithReuseIdentifier("FoodCell", forIndexPath: indexPath) as? FoodCell else {
            return UICollectionViewCell()
        }
        
        cell.titleLabel.text = venue.name
        
        if let url = NSURL(string: venue.thumbImagePath!) where venue.thumbImagePath != nil {
            
            let placeholderImage = UIImage(named: "foodPlaceholder")
            
            cell.iconImage.af_setImageWithURL(url,
                                              placeholderImage: placeholderImage,
                                              filter: nil,
                                              progress: nil,
                                              progressQueue: dispatch_get_main_queue(),
                                              imageTransition: UIImageView.ImageTransition.CrossDissolve(0.5),
                                              runImageTransitionIfCached: false,
                                              completion: { _ in })
            
            
        }
        
        cell.layer.shouldRasterize = true;
        cell.layer.rasterizationScale = UIScreen.mainScreen().scale
        
        var text = "🚖\(venue.distance)"
        
        if (venue.rating != nil) {
            text = text + " ⭐️\(venue.rating!)"
        }
        
        cell.detailLabel.text = text
        
        cell.containerView.layer.shadowColor = UIColor.blackColor().CGColor
        cell.containerView.layer.shadowOffset = CGSize(width: 0.3, height: 0.3)
        cell.containerView.layer.shadowOpacity = 0.5
        cell.containerView.layer.shadowRadius = 1.75
        cell.containerView.layer.masksToBounds =  false

        return cell
        
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        var m: CGFloat = UIDevice.currentDevice().orientation.isLandscape.boolValue ? 0.25 : 0.333
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            m = UIDevice.currentDevice().orientation.isLandscape.boolValue ? 0.333 : 0.5
        }
        
        let w = (collectionView.bounds.width * m) - 15
        let h = w * 1

        return CGSizeMake(w, h)
        
    }

    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

        dispatch_async(dispatch_get_main_queue()) { 
            self.performSegueWithIdentifier("detailContainerSegue", sender: self)
        }

    }
    
    
}

extension ViewController: CLLocationManagerDelegate {

    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        locationManagerDidUpdatedStatus(status)

    }
    
    
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        
        print(error.localizedDescription)
        
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let newLocation = locations.first else {
            return
        }

        if venueItems == nil {
            FoodFacade.explore(venuesByLocation: newLocation, complition: { response in
                self.initialViewAdjustment()
                self.venueItems = response.list
                self.listingCollectionView.reloadData()
            })
        }
        currentLocation = newLocation
        locationManager.stopUpdatingLocation()

    }
    
    func locationManagerDidUpdatedStatus(status: CLAuthorizationStatus) {
        
        switch status {
        case .NotDetermined:
            self.locationManager.requestWhenInUseAuthorization()
            print("NotDetermined")
        case .AuthorizedWhenInUse, .AuthorizedAlways:
            self.locationManager.startUpdatingLocation()
            print("AuthorizedWhenInUse or AuthorizedAlways")
        default:
            print("No Permissions//Showing Fueled Collective Nearby")
            FoodFacade.explore(venuesByLocation: CLLocation(latitude: 40.72428, longitude: -73.9973532), complition: { response in
                self.initialViewAdjustment()
                self.venueItems = response.list
                self.listingCollectionView.reloadData()
            })
        }

    }
    
}


class FoodCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!

}


