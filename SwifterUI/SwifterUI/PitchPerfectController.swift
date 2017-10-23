//
//  PitchPerfectController.swift
//  SwifterUI
//
//  Created by Brandon Maldonado Alonso on 14/10/17.
//  Copyright © 2017 Brandon Maldonado Alonso. All rights reserved.
//

import AsyncDisplayKit
import AVFoundation

class PitchPerfectController: SFViewController<PitchPerfectNode>, AVAudioRecorderDelegate {
    
    // MARK: - Instance Properties
    
    var audioRecorder: AVAudioRecorder?
    
    // MARK: - Initializers
    
    init() {
        super.init(SFNode: PitchPerfectNode(), automaticallyAdjustsColorStyle: true)
        self.SFNode.recordButton.addTarget(self, action: #selector(didTouch(button:)), forControlEvents: ASControlNodeEvent.touchUpInside)
        self.SFNode.stopButton.addTarget(self, action: #selector(didTouch(button:)), forControlEvents: ASControlNodeEvent.touchUpInside)
        self.SFNode.stopButton.isEnabled = false
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Instance Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    override func prepareAnimations() {
        self.SFNode.recordButton.animator.animations = [SFSlideAnimation(direction: .top, type: .inside)]
        self.SFNode.recordingLabel.animator.animations = [SFFadeAnimation(type: .inside), SFPopAnimation(type: .outside)]
        self.SFNode.stopButton.animator.animations = [SFSlideAnimation(direction: .bottom, type: .inside)]
    }
    
    @objc func didTouch(button: SFButtonNode) {
        
        button.animator.animations = [SFPopAnimation(type: .outside)]
        button.animator.start()
        
        if button == self.SFNode.recordButton {
            self.SFNode.stopButton.isEnabled = true
            self.SFNode.recordButton.isEnabled = false
            self.SFNode.recordingLabel.text = "Stop recording"
            startAudioRecorder()
        } else if button == self.SFNode.stopButton {
            self.SFNode.recordingLabel.text = "Tap to record"
            self.SFNode.stopButton.isEnabled = false
            self.SFNode.recordButton.isEnabled = true
            stopAudioRecorder()
        }
        
        self.SFNode.transitionLayout(withAnimation: true, shouldMeasureAsync: true, measurementCompletion: nil)
        
    }
    
    func startAudioRecorder() {
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        guard let filePath = URL(string: "\(dirPath)/\(recordingName)") else { fatalError() }
        let session = AVAudioSession.sharedInstance()

        Dispatch.addAsyncTask(to: DispatchLevel.background) {
            // Start AVAudioSession on background thread to not stop UI
            do {
                try session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
                try self.audioRecorder = AVAudioRecorder(url: filePath, settings: [:])
            } catch let error { print(error.localizedDescription) }
            
            // Prepare audioRecorder
            self.audioRecorder?.delegate = self
            self.audioRecorder?.isMeteringEnabled = true
            self.audioRecorder?.prepareToRecord()
            
            // Start recording on main thread once the AVAudioSession is ready
            Dispatch.addAsyncTask(to: .main, handler: {
                self.audioRecorder?.record()
            })
        }
    }
    
    func stopAudioRecorder() {
        
        // Stop recording on main thread
        audioRecorder?.stop()
        
        Dispatch.addAsyncTask(to: .background) {
            // Once recording has been completed, stop the AVAudioSession on background thread
            let session = AVAudioSession.sharedInstance()
            do { try session.setActive(false)
            } catch let error { print(error.localizedDescription) }
        }
    }
    
    // MARK: - AVAudioRecorderDelegate
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag == true {
            let controller = PitchPerfectEditorController(with: recorder.url)
            self.navigationController?.pushViewController(controller, animated: true)
        } else {
            self.showErrorAlert(title: "Error al grabar", errorDescription: "No se a podido guardar la grabación", actions: [])
        }
    }
    
}













