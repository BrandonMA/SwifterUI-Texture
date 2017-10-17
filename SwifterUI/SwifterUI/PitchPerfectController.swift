//
//  PitchPerfectController.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 14/10/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit
import AVFoundation

class PitchPerfectController: SFViewController<PitchPerfectNode> {
    
    // MARK: - Instance Properties
    
    var audioRecorder: AVAudioRecorder!
    
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
        self.SFNode.recordingLabel.animator.animation = .fadePopUp
        self.SFNode.stopButton.animator.animation = .slideInBottom
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.SFNode.recordButton.animator.startAnimation()
        self.SFNode.recordingLabel.animator.startAnimation()
        self.SFNode.stopButton.animator.startAnimation()
    }
    
    @objc func recordButtonDidTouch() {
        self.SFNode.recordingLabel.text = "Stop recording"
        self.SFNode.stopButton.isEnabled = true
        self.SFNode.recordButton.isEnabled = false
        self.SFNode.recordButton.animator.animation = .popUp
        self.SFNode.recordButton.animator.startAnimation()
//        prepareAudioRecorder()
    }
    
    @objc func stopButtonDidTouch() {
        self.SFNode.recordingLabel.text = "Tap to record"
        self.SFNode.stopButton.isEnabled = false
        self.SFNode.recordButton.isEnabled = true
        self.SFNode.stopButton.animator.animation = .shake
        self.SFNode.stopButton.animator.startAnimation()
//        stopAudioRecorder()
    }
    
    func prepareAudioRecorder() {
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        guard let filePath = URL(string: "\(dirPath)/\(recordingName)") else { fatalError() }
        let session = AVAudioSession.sharedInstance()

//        do {
//            try session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
//            try audioRecorder = AVAudioRecorder(url: filePath, settings: [:])
//        } catch let error { print(error.localizedDescription) }
//
//        audioRecorder.isMeteringEnabled = true
//        audioRecorder.prepareToRecord()
//        audioRecorder.record()
    }
    
    func stopAudioRecorder() {
        audioRecorder.stop()
        let session = AVAudioSession.sharedInstance()
        do { try session.setActive(false)
        } catch let error { print(error.localizedDescription) }
    }
    
}













