//
//  ViewController.swift
//  CoffeShops
//
//  Created by Brandon Maldonado Alonso on 30/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

class FoursquareViewController: SFViewController<FoursquareNode>, CLLocationManagerDelegate, ASTableDataSource, ASTableDelegate, SFSearchBarDelegate {
    
    var baseString = "https://api.foursquare.com/v2/venues/search?"
    var clientID = "4HLMJ1HSGPVF4CC11PCJNUYV2U0AAIDJLCAMOL535MNXNZQ3"
    var clientSecret = "41FOB5223EBJNSANICEMLB0V1C4ZCZJGEBDANMPFEZOJPKIJ"
    let locationManager = CLLocationManager()
    var venues: [Venue] = []
    var filteredVenues: [Venue] = []
    
    init() {
        super.init(SFNode: FoursquareNode(), automaticallyAdjustsColorStyle: true)
        self.SFNode.tableNode.dataSource = self
        self.SFNode.tableNode.delegate = self
        self.SFNode.searchBar.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.SFNode.searchBar.animator.animation = .scaleIn
        self.SFNode.searchBar.animator.delay = 0.3
        self.SFNode.searchBar.animator.damping = 0.7
        self.SFNode.searchBar.animator.startAnimation()
    }
    
    func updateBaseString(with coordinate: CLLocationCoordinate2D) {
        self.baseString += "ll=\(coordinate.latitude),\(coordinate.longitude)"
        self.baseString += "&client_id=\(clientID)&client_secret=\(clientSecret)&v=\(Date.today(with: "YYYYMMDD"))"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func startSearch() {
        guard let url = URL(string: self.baseString) else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
                fatalError()
            }
            
            guard let responseData = data else { return }
            
            do {
                guard let jsonObject = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any] else { return }
                
                if let responseDict = jsonObject["response"] as? [String: Any] {
                    if let venuesDict = responseDict["venues"] as? [[String: Any]] {
                        var annotations: [MKPointAnnotation] = []
                        venuesDict.forEach({ (finalDict) in
                            let venue = Venue(with: finalDict)
                            self.venues.append(venue)
                            self.filteredVenues.append(venue)
                            let annotation = MKPointAnnotation()
                            annotation.coordinate = CLLocationCoordinate2D(latitude: venue.location.lat, longitude: venue.location.lng)
                            annotations.append(annotation)
                        })
                        
                        Dispatch.addAsyncTask(to: DispatchLevel.main, handler: {
                            self.SFNode.tableNode.reloadSections(IndexSet(integer: 0), with: UITableViewRowAnimation.automatic)
                            self.SFNode.mapNode.annotations = annotations
                        })
                    }
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
            
        }
        task.resume()
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { fatalError() }
        SFNode.mapNode.mapView?.centerCoordinate = locValue
        locationManager.stopUpdatingLocation()
        SFNode.mapNode.mapView?.setUserTrackingMode(MKUserTrackingMode.follow, animated: true)
        updateBaseString(with: locValue)
        startSearch()
    }
    
    // MARK: - ASTableDataSource
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return self.filteredVenues.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let block: ASCellNodeBlock = {
            let venue = self.filteredVenues[indexPath.row]
            let cell = FoursquareCell(automaticallyAdjustsColorStyle: self.automaticallyAdjustsColorStyle)
            cell.titleLabel.text = venue.name
            cell.subtitleLabel.text = "\(venue.location.address)"
            cell.subtitleLabel.textTypeAttributes["\(venue.location.address)"] = [SFTextTypeName: SFTextType.button]
            return cell
        }
        return block
    }
    
    func tableNode(_ tableNode: ASTableNode, willDisplayRowWith node: ASCellNode) {
        guard let node = node as? FoursquareCell else { return }
        node.animator.animation = .slideInLeft
        node.animator.startAnimation()
    }
    
    // MARK: - SFSearchBarDelegate
    
    func didType(searchBar: SFSearchBar, text: String) {
        
        let initialSize = filteredVenues.count
        
        if text == "" {
            filteredVenues = venues
        } else {
            filteredVenues = venues.filter({ (venue) -> Bool in
                print("Text: \(venue.name.lowercased()) containt: \(text.lowercased())")
                return venue.name.lowercased().contains(text.lowercased())
            })
        }
        
        if self.filteredVenues.count != initialSize {
            Dispatch.addAsyncTask(to: DispatchLevel.main, handler: {
                self.SFNode.tableNode.reloadSections(IndexSet(integer: 0), with: UITableViewRowAnimation.automatic)
            })
        }
    }
    
    func cancelButtonDidTouch(searchBar: SFSearchBar) {
        let initialSize = filteredVenues.count
        filteredVenues = venues
        if self.filteredVenues.count != initialSize {
            Dispatch.addAsyncTask(to: DispatchLevel.main, handler: {
                self.SFNode.tableNode.reloadSections(IndexSet(integer: 0), with: UITableViewRowAnimation.automatic)
            })
        }
    }
}







