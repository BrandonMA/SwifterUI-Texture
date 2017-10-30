//
//  SFVideoPlayer.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 01/10/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit
import AVKit

open class SFVideoPlayer: SFDisplayNode {
    
    // MARK: - Instance Properties
    
    private var videoNode: SFPlayerContainerNode? = nil
    private var youtubeNode: SFYoutubeNode? = nil
    open var url: URL? = nil { didSet { prepareVideoNode() } }
    open var youtubeURL: URL? = nil { didSet { prepareYoutubeNode() } }
    open weak var delegate: SFVideoPlayerDelegate? = nil
    
    // MARK: - Initializers
    
    public required init(automaticallyAdjustsColorStyle: Bool) {
        super.init(automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle)
    }
    
    // MARK: - Instance Methods
    
    open override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        var node: ASDisplayNode
        
        if let videoNode = self.videoNode {
            node = videoNode
        } else if let youtubeNode = self.youtubeNode {
            node = youtubeNode
        } else {
            return ASLayoutSpec()
        }
        
        node.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: ASDimensionUnit.fraction, value: 1), height: ASDimension(unit: ASDimensionUnit.fraction, value: 1))
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: node == self.youtubeNode ? 20 : 0, left: 0, bottom: 0, right: 0), child: ASRelativeLayoutSpec(horizontalPosition: ASRelativeLayoutSpecPosition.start, verticalPosition: ASRelativeLayoutSpecPosition.start, sizingOption: ASRelativeLayoutSpecSizingOption.minimumSize, child: node))
    }
        
    open func prepareVideoNode() {
        guard let url = self.url else { return }
        let controller = AVPlayerViewController()
        let player = AVPlayer(url: url)
        controller.player = player
        controller.allowsPictureInPicturePlayback = true
        controller.entersFullScreenWhenPlaybackBegins = true
        delegate?.prepare(mediaController: controller)
        self.videoNode = SFPlayerContainerNode(videoView: controller.view, automaticallyAdjustsColorStyle: true)
        self.transitionLayout(withAnimation: true, shouldMeasureAsync: true, measurementCompletion: nil)
    }
    
    open func prepareYoutubeNode() {
        self.youtubeNode = SFYoutubeNode(automaticallyAdjustsColorStyle: self.automaticallyAdjustsColorStyle)
        if let youtubeURL = self.youtubeURL {
            Dispatch.addAsyncTask(to: DispatchLevel.main, handler: {
                self.youtubeNode?.youtubeView.loadVideoURL(youtubeURL)
            })
        }
    }
}









