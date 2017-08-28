////
////  SFYoutubeNode.swift
////  SwifterUI
////
////  Created by Brandon Maldonado Alonso on 02/07/17.
////  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
////
//
//import AsyncDisplayKit
//
//// This is not even near to be complete... You should not use it
//open class SFYoutubeNode: SFWebNode {
//
//    // MARK: - Instance Methods
//
//    // didLoad: enables allowsInlineMediaPlayback and allowsPictureInPictureMediaPlayback
//    override open func didLoad() {
//        super.didLoad()
//        webView.allowsInlineMediaPlayback = true
//        webView.allowsPictureInPictureMediaPlayback = true
//    }
//
//    // loadVideo: Load a youtube video from the given url, it must be called in your controller's viewWillLayoutSubviews method to size correctly
//    // - Parameters:
//    //   videoURL: URL to be loaded
//    public func loadVideo(from videoURL: String) {
//        let watchString = "watch?v="
//        let iFrameURL = "<iframe width=\"\(self.frame.width)\" height=\"\(self.frame.height)\" src=\"\(videoURL.replacingOccurrences(of: watchString, with: "embed/"))?playsinline=1\" frameborder=\"0\" allowfullscreen></iframe>"
//        webView.loadHTMLString(iFrameURL, baseURL: nil)
//    }
//}

