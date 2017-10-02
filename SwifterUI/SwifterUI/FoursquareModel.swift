//
//  FoursquareModel.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 30/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import UIKit

struct Location {
    var address: String = "No tiene dirección"
    var lat: Double = 0.0
    var lng: Double = 0.0
    
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
    
    var name: String = ""
    var location: Location
    
    init(with dict: [String: Any]) {
        
        guard let name = dict["name"] as? String else { fatalError() }
        self.name = name
        
        guard let location = dict["location"] as? [String: Any] else { fatalError() }
        self.location = Location(with: location)
        
    }
}
