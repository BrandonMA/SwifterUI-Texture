//
//  ViewController.swift
//  CoffeShops
//
//  Created by Brandon Maldonado Alonso on 30/09/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

class FoursquareNode: SFDisplayNode {
    
    lazy var mapNode: ASMapNode = {
        let mapNode = ASMapNode()
        mapNode.isLiveMap = true
        mapNode.mapView?.showsUserLocation = true
        return mapNode
    }()
    
    lazy var searchBar: SFSearchBar = {
        let searchBar = SFSearchBar(automaticallyAdjustsColorStyle: self.automaticallyAdjustsColorStyle)
        return searchBar
    }()
    
    lazy var tableNode: SFTableNode = {
        let tableNode = SFTableNode(automaticallyAdjustsColorStyle: self.automaticallyAdjustsColorStyle)
        tableNode.allowsSelection = false
        return tableNode
    }()
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        tableNode.style.width = ASDimension(unit: ASDimensionUnit.fraction, value: 1)
        tableNode.style.flexGrow = 1.0
        let ratioLayout = ASRatioLayoutSpec(ratio: 9/16, child: mapNode)
        let searchBarLayout = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16), child: searchBar)
        let stackLayout = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: 0, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.start, children: [ratioLayout, searchBarLayout, tableNode])
        return stackLayout
    }
}

class FoursquareCell: SFCellNode {
    
    lazy var titleLabel: SFLabelNode = {
        let label = SFLabelNode(automaticallyAdjustsColorStyle: self.automaticallyAdjustsColorStyle)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.isLayerBacked = true
        return label
    }()
    
    lazy var subtitleLabel: SFDetailLabelNode = {
        let label = SFDetailLabelNode(automaticallyAdjustsColorStyle: self.automaticallyAdjustsColorStyle)
        label.isLayerBacked = true
        return label
    }()
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let stackLayout = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: 8, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.start, children: [titleLabel, subtitleLabel])
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8), child: stackLayout)
    }
    
}

class FoursquareViewController: SFViewController<FoursquareNode>, CLLocationManagerDelegate, ASTableDataSource, ASTableDelegate {
    
    var baseString = "https://api.foursquare.com/v2/venues/search?"
    var clientID = "4HLMJ1HSGPVF4CC11PCJNUYV2U0AAIDJLCAMOL535MNXNZQ3"
    var clientSecret = "41FOB5223EBJNSANICEMLB0V1C4ZCZJGEBDANMPFEZOJPKIJ"
    let locationManager = CLLocationManager()
    var venues: [Venue] = []
    
    init() {
        super.init(SFNode: FoursquareNode(), automaticallyAdjustsColorStyle: true)
        self.SFNode.tableNode.dataSource = self
        self.SFNode.tableNode.delegate = self
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
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
        SFNode.mapNode.mapView?.setUserTrackingMode(MKUserTrackingMode.follow, animated: true)
        locationManager.stopUpdatingLocation()
        updateBaseString(with: locValue)
        startSearch()
    }
    
    // MARK: - ASTableDataSource
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return self.venues.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let block: ASCellNodeBlock = {
            let venue = self.venues[indexPath.row]
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
}







