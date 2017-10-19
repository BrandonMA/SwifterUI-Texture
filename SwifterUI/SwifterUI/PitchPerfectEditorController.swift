//
//  PitchPerfectEditorController.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 17/10/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

class PitchPerfectEditorController: SFViewController<PitchPerfectEditorNode> {
    
    // MARK: - Instance Properties
    
    var recordedAudioURL: URL
    
    // MARK: - Initializers
    
    init(with fileURL: URL) {
        self.recordedAudioURL = fileURL
        super.init(SFNode: PitchPerfectEditorNode(), automaticallyAdjustsColorStyle: true)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Instance Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.SFNode.slowButton.animator.animation = .fadeInLeft
        self.SFNode.slowButton.animator.delay = 0.3
        self.SFNode.highPitchButton.animator.animation = .fadeInLeft
        self.SFNode.highPitchButton.animator.delay = 0.3
        self.SFNode.echoPitchButton.animator.animation = .fadeInLeft
        self.SFNode.echoPitchButton.animator.delay = 0.3
        self.SFNode.fastButton.animator.animation = .fadeInRight
        self.SFNode.fastButton.animator.delay = 0.3
        self.SFNode.lowPitchButton.animator.animation = .fadeInRight
        self.SFNode.lowPitchButton.animator.delay = 0.3
        self.SFNode.reverbPitchButton.animator.animation = .fadeInRight
        self.SFNode.reverbPitchButton.animator.delay = 0.3
        self.SFNode.stopButton.animator.animation = .fadeInBottom
        self.SFNode.stopButton.animator.delay = 0.3
        
        self.SFNode.slowButton.animator.startAnimation()
        self.SFNode.highPitchButton.animator.startAnimation()
        self.SFNode.echoPitchButton.animator.startAnimation()
        self.SFNode.fastButton.animator.startAnimation()
        self.SFNode.lowPitchButton.animator.startAnimation()
        self.SFNode.reverbPitchButton.animator.startAnimation()
        self.SFNode.stopButton.animator.startAnimation()
    }
    
}







