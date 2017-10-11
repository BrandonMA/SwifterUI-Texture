//
//  VideoPlayerExample.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 01/10/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

class VideoPlayerNodeExample: SFDisplayNode {
    
    lazy var videoNode: SFVideoPlayer = {
        let node = SFVideoPlayer(automaticallyAdjustsColorStyle: self.automaticallyAdjustsColorStyle)
        return node
    }()
    
    lazy var bottomButton: SFButtonNode = {
        let button = SFButtonNode(automaticallyAdjustsColorStyle: self.automaticallyAdjustsColorStyle)
        button.font = UIFont.boldSystemFont(ofSize: 22)
        button.text = "Hola"
        button.shouldHaveAlternativeColors = true
        button.cornerRadius = 10
        return button
    }()
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let ratioLayout = ASRatioLayoutSpec(ratio: 9/16, child: videoNode)
        bottomButton.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: ASDimensionUnit.points, value: 300), height: ASDimension(unit: ASDimensionUnit.points, value: 44))
        
        let stack = ASStackLayoutSpec(direction: ASStackLayoutDirection.vertical, spacing: 24, justifyContent: ASStackLayoutJustifyContent.center, alignItems: ASStackLayoutAlignItems.center, children: [ratioLayout, bottomButton])
        
        return stack
    }
    
}

class VideoPlayerControllerExample: SFViewController<VideoPlayerNodeExample>, SFVideoPlayerDelegate {
    
    init() {
        super.init(SFNode: VideoPlayerNodeExample(), automaticallyAdjustsColorStyle: true)
        self.SFNode.videoNode.delegate = self
        guard let url = URL(string: "https://www.youtube.com/watch?v=_pMCjZSvvxE") else { return }
        self.SFNode.videoNode.youtubeURL = url
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.SFNode.videoNode.animator.animation = .scaleIn
        self.SFNode.bottomButton.animator.animation = .slideInBottom
        self.SFNode.videoNode.animator.delay = 0.3
        self.SFNode.bottomButton.animator.delay = 0.3
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.SFNode.videoNode.animator.startAnimation()
        self.SFNode.bottomButton.animator.startAnimation()
    }
}










