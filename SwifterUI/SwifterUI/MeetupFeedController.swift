//
//  MeetupFeedViewController.swift
//  SWifterUI
//
//  Created by Brandon Maldonado Alonso on 17/05/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class MeetupFeedController: SFTableNodeController, UINavigationControllerDelegate{
    
    // MARK: Instance Properties

    let meetUpService = MeetupService()
    let locationService = LocationService()
    var meetUpFeedDataManager: MeetupFeedDataManager!
    var groups: [Group] = []
        
    // MARK: Initializers
    
    init() {
        
        let newNode = SFTableNode()
        
        newNode.shouldHaveRefreshControl = true
        
        super.init(SFTableNode: newNode, automaticallyAdjustsColorStyle: true)
        
        self.shouldHaveSearchBar = true
                
        self.meetUpFeedDataManager = MeetupFeedDataManager(meetupService: meetUpService, locationService: locationService)
        
        self.SFNode.allowsSelection = true
        self.SFNode.isUserInteractionEnabled = true
        
        self.meetUpFeedDataManager.searchForGroupNearby { (groups, error) in
            
            if let error = error {
                print(error.localizedDescription)
                
            } else if let groups = groups {
                
                self.groups = groups
                
                let indexSet = IndexSet(integer: 0)
                                
                Dispatch.addAsyncTask(to: DispatchLevel.main, handler: {
                    self.SFNode.reloadSections(indexSet, with: UITableViewRowAnimation.automatic)
                    self.updateColors()
                })
                
            } else {
                print("unkown error")
            }
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(stopRefreshing))
        self.navigationItem.title = "Prueba"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UINavigationControllerDelegate
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SFZoomTransition(operation: operation)
    }
    
    // MARK: - ASTableDataSource
    
    override func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    
    override func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        
        let group = groups[indexPath.row]
        
        let block: () -> ASCellNode = {
            let cellNode = MeetupFeedCellNode(automaticallyAdjustsColorStyle: self.automaticallyAdjustsColorStyle)
            cellNode.organizerAvatarImageNode.url = group.organizer.thumbUrl
            cellNode.organizerNameTextNode.text = group.organizer.name
            cellNode.photoImageNode.url = group.photoUrl
            cellNode.locationLabelNode.text = "\(group.city!), \(group.country!)"
            cellNode.locationLabelNode.textTypeAttributes["\(group.city!), \(group.country!)"] = [SFTextTypeName: SFTextType.button]
            cellNode.timeIntervalSincePost.text = group.timeInterval
            cellNode.selectionStyle = .none
            return cellNode
        }
        
        return block
    }
    
    func tableNode(_ tableNode: ASTableNode, willDisplayRowWith node: ASCellNode) {
        guard let node = node as? MeetupFeedCellNode else { return }
        node.animator.animation = .scaleIn
        node.animator.startAnimation()
    }
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        guard let node = tableNode.nodeForRow(at: indexPath) as? MeetupFeedCellNode else { return }
        if let image = node.photoImageNode.image {
            let controller = SFImageZoomNodeController(withImage: image, automaticallyAdjustsColorStyle: true)
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    // MARK: - Instance Methods
    
    @objc func stopRefreshing() {
        self.SFNode.endRefreshing()
    }

}
