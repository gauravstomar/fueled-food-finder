# Fueled Food Finder


Fueled Food Finder is a lightweight iOS App uses Foursquare APIs to find nearby restaurants.
It supports follwong features:
  - Explore upto 50 nearby restaurants from your Current location or BROADWAY, NEW YORK
  - Ordered by Shortest Location
  - See details and Ratings of the restaurant
  - Ability to read/write locally stored reviews for a visited restaurant.
  - Ability to thumbs-down a restaurant such that it is never considered as an option for dining.

> NOTE: Providing location access is not necessary if your are
> looking for BROADWAY, NEW YORK restaurants.
> The idea is that a
> resturent finder app should be
> publishable as-is, as genric app, without
> looking like it's been made for specific location or instructions.


### Tech

Fueled Food Finder is powered with fully working, testable and maintainable Swift 2.3 codebase, accommodating; 
- Cocoa Touch (UIKit + Foundation + Location) APIs
- Creative and Ingenuitive UX
- Refined Architectures and Design Patterns
- Foursquare REST APIs

It also uses a number of open source projects to work properly:
* [CocoaPods](https://cocoapods.org) - A dependency manager for Swift and Objective-C Cocoa projects
* [QuadratTouch](https://github.com/Constantine-Fry/das-quadrat) - A Swift wrapper for Foursquare API. iOS and OSX
* [CoreStore](https://github.com/JohnEstropia/CoreStore) - Unleashing the real power of Core Data with the elegance and safety of Swift
* [Alamofire](https://github.com/Alamofire/Alamofire) - Elegant HTTP Networking in Swift

And of course Fueled Food Finder itself is open source with a [public repository](https://github.com/gauravstomar/fueled-food-finder) on GitHub.

### Installation

Dillinger requires [XCode 8+](http://developer.apple.com) and [CocoaPods](https://cocoapods.org)  to run.

```sh
$ sudo gem install cocoapods //incase you not have cocoapod
$ cd fueled-food-finder
$ pod install
```

### Todos

 - Write Tests
 - Rethink Github Save
 - Add Code Comments
 - Add UI feedback for tap events and other gestures

### Demo Video

https://youtu.be/3zzfWL1MXOs

### License

MIT

