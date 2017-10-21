//
//  ViewController.swift
//  CoffeShops
//
//  Created by Brandon Maldonado Alonso on 30/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

class FoursquareViewController: SFViewController<FoursquareNode>, CLLocationManagerDelegate, ASTableDataSource, ASTableDelegate, SFSearchBarDelegate, FoursquareDataManagerDelegate {
    
    // MARK: - Instance Properties
    
    let locationManager = CLLocationManager()
    var filteredVenues: [Venue] = []
    var manager: FoursquareDataManager = FoursquareDataManager()
    
    // MARK: - Initializers
    
    init() {
        super.init(SFNode: FoursquareNode(), automaticallyAdjustsColorStyle: true)
        self.SFNode.tableNode.dataSource = self
        self.SFNode.tableNode.delegate = self
        self.SFNode.searchBar.delegate = self
        self.manager.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Instance Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.SFNode.searchBar.animator.animation = .scaleIn
        self.SFNode.searchBar.animator.delay = 0.3
        self.SFNode.searchBar.animator.start()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - FoursquareDataManagerDelegate
    
    func didFinishDownload(venues: [Venue]) {
        self.filteredVenues = venues
        
        Dispatch.addAsyncTask(to: DispatchLevel.main) {
            let indexSet = IndexSet(integer: 0)
            self.SFNode.tableNode.reloadSections(indexSet, with: .automatic)
            
            for venue in venues {
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: venue.location.lat, longitude: venue.location.lng)
                self.SFNode.mapNode.annotations.append(annotation)
            }
        }
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { fatalError() }
        SFNode.mapNode.mapView?.centerCoordinate = locValue
        locationManager.stopUpdatingLocation()
        SFNode.mapNode.mapView?.setUserTrackingMode(MKUserTrackingMode.follow, animated: true)
        self.manager.updateBaseString(with: locValue)
        self.manager.startDownload()
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
//        node.animator.animation = .slideInLeft
        node.animator.start()
    }
    
    // MARK: - SFSearchBarDelegate
    
    func didType(searchBar: SFSearchBar, text: String) {
        
        let initialSize = filteredVenues.count
        
        if text == "" {
            filteredVenues = self.manager.venues
        } else {
            filteredVenues = self.manager.venues.filter({ (venue) -> Bool in
                print("Text: \(venue.name.lowercased()) containt: \(text.lowercased())")
                return venue.name.lowercased().contains(text.lowercased())
            })
        }
        
        if self.filteredVenues.count != initialSize {
            Dispatch.addAsyncTask(to: .main, handler: {
                self.SFNode.tableNode.reloadSections(IndexSet(integer: 0), with: UITableViewRowAnimation.automatic)
            })
        }
    }
    
    func cancelButtonDidTouch(searchBar: SFSearchBar) {
        let initialSize = filteredVenues.count
        filteredVenues = self.manager.venues
        if self.filteredVenues.count != initialSize {
            Dispatch.addAsyncTask(to: .main, handler: {
                self.SFNode.tableNode.reloadSections(IndexSet(integer: 0), with: UITableViewRowAnimation.automatic)
            })
        }
    }
}







