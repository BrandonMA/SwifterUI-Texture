//
//  FoursquareModel.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 30/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

protocol FoursquareDataManagerDelegate: class {
    func didFinishDownload(venues: [Venue])
}

class FoursquareDataManager: NSObject {
    
    // MARK: - Instance Properties
    
    var baseString = "https://api.foursquare.com/v2/venues/search?"
    var clientID = "4HLMJ1HSGPVF4CC11PCJNUYV2U0AAIDJLCAMOL535MNXNZQ3"
    var clientSecret = "41FOB5223EBJNSANICEMLB0V1C4ZCZJGEBDANMPFEZOJPKIJ"
    var venues: [Venue] = []
    weak var delegate: FoursquareDataManagerDelegate? = nil
    
    // MARK: - Instance Methods
    
    func updateBaseString(with coordinate: CLLocationCoordinate2D) {
        self.baseString += "ll=\(coordinate.latitude),\(coordinate.longitude)"
        self.baseString += "&client_id=\(clientID)&client_secret=\(clientSecret)&v=\(Date.today(with: "YYYYMMDD"))"
    }
    
    func startDownload() {
        guard let url = URL(string: self.baseString) else { return }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil { fatalError() }
            guard let responseData = data else { return }
            
            do {
                guard let jsonObject = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any] else { return }
                if let responseDict = jsonObject["response"] as? [String: Any] {
                    if let venuesDict = responseDict["venues"] as? [[String: Any]] {
                        var annotations: [MKPointAnnotation] = []
                        venuesDict.forEach({ (finalDict) in
                            let venue = Venue(with: finalDict)
                            self.venues.append(venue)
                            let annotation = MKPointAnnotation()
                            annotation.coordinate = CLLocationCoordinate2D(latitude: venue.location.lat, longitude: venue.location.lng)
                            annotations.append(annotation)
                        })
                        self.delegate?.didFinishDownload(venues: self.venues)
                    }
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
}

struct Location {
    
    // MARK: - Instance Properties
    
    var address: String = "No tiene dirección"
    var lat: Double = 0.0
    var lng: Double = 0.0
    
    // MARK: - Initializers
    
    init(with dict: [String: Any]) {
        
        guard let address = dict["address"] as? String else { return }
        self.address = address
        
        guard let lat = dict["lat"] as? Double else { return }
        self.lat = lat
        
        guard let lng = dict["lng"] as? Double else { return }
        self.lng = lng
    }
    
}

struct Venue {
    
    // MARK: - Instance
    
    var name: String = ""
    var location: Location
    
    // MARK: - Initializers
    
    init(with dict: [String: Any]) {
        
        guard let name = dict["name"] as? String else { fatalError() }
        self.name = name
        
        guard let location = dict["location"] as? [String: Any] else { fatalError() }
        self.location = Location(with: location)
        
    }
}
