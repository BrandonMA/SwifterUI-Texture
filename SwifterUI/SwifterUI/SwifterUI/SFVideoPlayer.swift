//
//  SFVideoPlayer.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 01/10/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit
import YouTubePlayer
import AVKit

open class SFVideoPlayer: SFDisplayNode {
    
    public var videoView: UIView? = nil {
        didSet {
            Dispatch.addAsyncTask(to: DispatchLevel.main) {
                self.layout()
            }
        }
    }
    
    public var youtubeView: YouTubePlayerView? = nil {
        didSet {
            Dispatch.addAsyncTask(to: DispatchLevel.main) {
                self.layout()
            }
        }
    }
    
    private var youtubeURL: URL? = nil
    
    public required init(automaticallyAdjustsColorStyle: Bool) {
        super.init(automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle)
    }
    
    public convenience init(with videoView: UIView, automaticallyAdjustsColorStyle: Bool) {
        self.init(automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle)
        self.videoView = videoView
    }
    
    public convenience init(with url: URL?, automaticallyAdjustsColorStyle: Bool) {
        self.init(automaticallyAdjustsColorStyle: automaticallyAdjustsColorStyle)
        self.youtubeURL = url
    }
    
    open override func layout() {
        super.layout()
        layoutVideoView()
    }
    
    open func layoutVideoView() {
        guard let videoView = self.videoView != nil ? self.videoView : self.youtubeView else { return }
        videoView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(videoView)
        NSLayoutConstraint.activate([
            videoView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: videoView == self.youtubeView ? 20:0),
            videoView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            videoView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            videoView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
            ])
    }
    
    open func load(youtubeURL url: URL) {
        self.youtubeURL = url
        if let youtubeURL = self.youtubeURL {
            Dispatch.addAsyncTask(to: DispatchLevel.main, handler: {
                self.youtubeView = YouTubePlayerView()
                self.youtubeView?.loadVideoURL(youtubeURL)
            })
        }
    }
    
    open func load(videoURL url: URL, parentController: UIViewController) {
        let player = AVPlayer(url: url)
        
        let controller = AVPlayerViewController()
        controller.player = player
        controller.allowsPictureInPicturePlayback = true
        controller.entersFullScreenWhenPlaybackBegins = true
        controller.didMove(toParentViewController: parentController)
        
        parentController.addChildViewController(controller)
        self.videoView = controller.view
    }
    
}









