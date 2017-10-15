//
//  PitchPerfectController.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 14/10/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit

class PitchPerfectController: SFViewController<PitchPerfectNode> {
    
    // MARK: - Initializers
    
    init() {
        super.init(SFNode: PitchPerfectNode(automaticallyAdjustsColorStyle: true), automaticallyAdjustsColorStyle: true)
        self.SFNode.recordButton.addTarget(self, action: #selector(recordButtonDidTouch), forControlEvents: ASControlNodeEvent.touchUpInside)
        self.SFNode.stopButton.addTarget(self, action: #selector(stopButtonDidTouch), forControlEvents: ASControlNodeEvent.touchUpInside)
        self.SFNode.stopButton.isEnabled = false
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Instance Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.SFNode.recordButton.animator.animation = .slideInTop
        self.SFNode.recordButton.animator.damping = 0.7
        self.SFNode.recordingLabel.animator.animation = .fadeIn
        self.SFNode.stopButton.animator.animation = .slideInBottom
        self.SFNode.stopButton.animator.damping = 0.7
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.SFNode.recordButton.animator.startAnimation()
        self.SFNode.recordingLabel.animator.startAnimation()
        self.SFNode.stopButton.animator.startAnimation()
    }
    
    @objc func recordButtonDidTouch() {
        self.SFNode.recordingLabel.text = "Stop recording"
        self.SFNode.transitionLayout(withAnimation: true, shouldMeasureAsync: true, measurementCompletion: nil)
        self.SFNode.stopButton.isEnabled = true
        self.SFNode.recordButton.isEnabled = false
    }
    
    @objc func stopButtonDidTouch() {
        self.SFNode.recordingLabel.text = "Tap to record"
        self.SFNode.transitionLayout(withAnimation: true, shouldMeasureAsync: true, measurementCompletion: nil)
        self.SFNode.stopButton.isEnabled = false
        self.SFNode.recordButton.isEnabled = true
    }
    
}
