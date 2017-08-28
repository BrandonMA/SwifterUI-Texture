//
//  Group.swift
//  Fluid-UI-Framework
//
//  Created by Brandon Maldonado Alonso on 18/05/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import UIKit
import CoreLocation

typealias JSON = [String: AnyObject]
let APIKEY = "503e36704b574d3834375c421d0335d"

// MARK: Organizer Class

struct Organizer {
    let name: String!
    let thumbUrl: URL!
}

// MARK: LocationService Class

final class LocationService {
    var coordinate: CLLocationCoordinate2D? = CLLocationCoordinate2D(latitude: 51.509980, longitude: -0.133700)
}

// MARK: Group Class

struct Group {
    let createdAt: Double!
    let photoUrl: URL!
    let city: String!
    let country: String!
    let organizer: Organizer!
    
    var timeInterval: String {
        let date = Date(timeIntervalSince1970: createdAt)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        return dateFormatter.string(from: date)
    }
}

// MARK: MeetupService Class

final class MeetupService {
    
    var baseUrl: String = "https://api.meetup.com/"
    lazy var session: URLSession = URLSession.shared
    
    func fetchMeetupGroupInLocation(latitude: Double, longitude: Double, completion: @escaping (_ results: [JSON]?, _ error: Error?) -> ()) {
        
        guard let url = URL(string: "\(baseUrl)find/groups?&lat=\(latitude)&lon=\(longitude)&page=10&key=\(APIKEY)") else {
            fatalError()
        }
        
        session.dataTask(with: url) { (data, response, error) in
            
            Dispatch.addAsyncTask(to: DispatchLevel.main, handler: { 
                do {
                    if let data = data {
                        let results = try JSONSerialization.jsonObject(with: data) as? [JSON]
                        completion(results, nil);
                    }
                    
                } catch let underlyingError {
                    completion(nil, underlyingError);
                }
            })
            
            }.resume()
    }
}

// MARK: MeetupFeedDataManager Class

final class MeetupFeedDataManager {
    
    fileprivate var meetupService: MeetupService?
    fileprivate var locationService: LocationService?
    
    init(meetupService: MeetupService, locationService: LocationService) {
        self.meetupService = meetupService
        self.locationService = locationService
    }
    
    func organizerItemFromJSONDictionary(entry: JSON) -> Organizer? {
        guard let name = entry["name"] as? String, let photo = entry["photo"] as? JSON, let thumbUrl = photo["thumb_link"] as? String else { return nil }
        
        return Organizer(name: name, thumbUrl: URL(string: thumbUrl))
    }
    
    func groupItemFromJSONDictionary(entry: JSON) -> Group? {
        
        guard let created = entry["created"] as? Double else { return nil }
        
        guard let city = entry["city"] as? String else { return nil }
        
        guard let country = entry["country"] as? String else { return nil }
        
        guard let keyPhoto = entry["key_photo"] as? JSON else { return nil }
        
        guard let photoUrl = keyPhoto["photo_link"] as? String else { return nil }
        
        guard let organizerJSON = entry["organizer"] as? JSON else { return nil }
        
        guard let organizer = organizerItemFromJSONDictionary(entry: organizerJSON) else { return nil }
        
        let group = Group(createdAt: created, photoUrl: URL(string: photoUrl), city: city, country: country, organizer: organizer)
                
        return group
    }
    
    func searchForGroupNearby(completion: @escaping (_ groups: [Group]?, _ error: Error?) -> ()) {
        
        let coordinate = locationService?.coordinate
        
        meetupService?.fetchMeetupGroupInLocation(latitude: coordinate!.latitude, longitude: coordinate!.longitude, completion: { (results, error) in
            
            guard error == nil else { completion(nil, error); return }
            
            guard let results = results else { fatalError() }
            
            let groups = results.flatMap(self.groupItemFromJSONDictionary)
            
            completion(groups, nil)
        })
    }
}



