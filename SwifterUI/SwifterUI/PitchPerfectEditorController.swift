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
        
        self.SFNode.slowButton.addTarget(self, action: #selector(slowButtonDidTouch), forControlEvents: .touchUpInside)
        self.SFNode.fastButton.addTarget(self, action: #selector(fastButtonDidTouch), forControlEvents: .touchUpInside)
        self.SFNode.highPitchButton.addTarget(self, action: #selector(highButtonDidTouch), forControlEvents: .touchUpInside)
        self.SFNode.lowPitchButton.addTarget(self, action: #selector(lowButtonDidTouch), forControlEvents: .touchUpInside)
        self.SFNode.echoPitchButton.addTarget(self, action: #selector(echoButtonDidTouch), forControlEvents: .touchUpInside)
        self.SFNode.reverbPitchButton.addTarget(self, action: #selector(reverbButtonDidTouch), forControlEvents: .touchUpInside)
        self.SFNode.stopButton.addTarget(self, action: #selector(stopButtonDidTouch), forControlEvents: .touchUpInside)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Instance Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.SFNode.slowButton.animator.animations = [SFSlideAnimation(direction: .left, type: .inside), SFFadeAnimation(type: .inside)]
        self.SFNode.slowButton.animator.delay = 0.3
        self.SFNode.fastButton.animator.animations = [SFSlideAnimation(direction: .right, type: .inside), SFFadeAnimation(type: .inside)]
        self.SFNode.fastButton.animator.delay = 0.3
        self.SFNode.highPitchButton.animator.animations = [SFSlideAnimation(direction: .left, type: .inside), SFFadeAnimation(type: .inside)]
        self.SFNode.highPitchButton.animator.delay = 0.3
        self.SFNode.lowPitchButton.animator.animations = [SFSlideAnimation(direction: .right, type: .inside), SFFadeAnimation(type: .inside)]
        self.SFNode.lowPitchButton.animator.delay = 0.3
        self.SFNode.echoPitchButton.animator.animations = [SFSlideAnimation(direction: .left, type: .inside), SFFadeAnimation(type: .inside)]
        self.SFNode.echoPitchButton.animator.delay = 0.3
        self.SFNode.reverbPitchButton.animator.animations = [SFSlideAnimation(direction: .right, type: .inside), SFFadeAnimation(type: .inside)]
        self.SFNode.reverbPitchButton.animator.delay = 0.3
        self.SFNode.stopButton.animator.animations = [SFSlideAnimation(direction: .bottom, type: .inside), SFFadeAnimation(type: .inside)]
        self.SFNode.stopButton.animator.delay = 0.3

        self.SFNode.slowButton.animator.start()
        self.SFNode.highPitchButton.animator.start()
        self.SFNode.echoPitchButton.animator.start()
        self.SFNode.fastButton.animator.start()
        self.SFNode.lowPitchButton.animator.start()
        self.SFNode.reverbPitchButton.animator.start()
        self.SFNode.stopButton.animator.start()
    }
    
    @objc func slowButtonDidTouch() {
        self.SFNode.slowButton.animator.animations = [SFPopAnimation(type: .outside)]
        self.SFNode.slowButton.animator.start()
    }

    @objc func fastButtonDidTouch() {
        self.SFNode.fastButton.animator.animations = [SFPopAnimation(type: .outside)]
        self.SFNode.fastButton.animator.start()
    }

    @objc func highButtonDidTouch() {
        self.SFNode.highPitchButton.animator.animations = [SFPopAnimation(type: .outside)]
        self.SFNode.highPitchButton.animator.start()
    }

    @objc func lowButtonDidTouch() {
        self.SFNode.lowPitchButton.animator.animations = [SFPopAnimation(type: .outside)]
        self.SFNode.lowPitchButton.animator.start()
    }

    @objc func echoButtonDidTouch() {
        self.SFNode.echoPitchButton.animator.animations = [SFPopAnimation(type: .outside)]
        self.SFNode.echoPitchButton.animator.start()
    }

    @objc func reverbButtonDidTouch() {
        self.SFNode.reverbPitchButton.animator.animations = [SFPopAnimation(type: .outside)]
        self.SFNode.reverbPitchButton.animator.start()
    }

    @objc func stopButtonDidTouch() {
        self.SFNode.stopButton.animator.animations = [SFPopAnimation(type: .outside)]
        self.SFNode.stopButton.animator.start()
    }
}












