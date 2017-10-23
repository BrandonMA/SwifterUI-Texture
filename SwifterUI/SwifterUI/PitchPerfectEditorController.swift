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
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    // MARK: - Initializers
    
    init(with fileURL: URL) {
        self.recordedAudioURL = fileURL
        super.init(SFNode: PitchPerfectEditorNode(), automaticallyAdjustsColorStyle: true)
        
        self.SFNode.slowButton.addTarget(self, action: #selector(didTouch(button:)), forControlEvents: .touchUpInside)
        self.SFNode.fastButton.addTarget(self, action: #selector(didTouch(button:)), forControlEvents: .touchUpInside)
        self.SFNode.highPitchButton.addTarget(self, action: #selector(didTouch(button:)), forControlEvents: .touchUpInside)
        self.SFNode.lowPitchButton.addTarget(self, action: #selector(didTouch(button:)), forControlEvents: .touchUpInside)
        self.SFNode.echoPitchButton.addTarget(self, action: #selector(didTouch(button:)), forControlEvents: .touchUpInside)
        self.SFNode.reverbPitchButton.addTarget(self, action: #selector(didTouch(button:)), forControlEvents: .touchUpInside)
        self.SFNode.stopButton.addTarget(self, action: #selector(didTouch(button:)), forControlEvents: .touchUpInside)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Instance Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
    }
    
    override func prepareAnimations() {
        self.SFNode.slowButton.animator.animations = [SFSlideAnimation(direction: .left, type: .inside), SFFadeAnimation(type: .inside)]
        self.SFNode.fastButton.animator.animations = [SFSlideAnimation(direction: .right, type: .inside), SFFadeAnimation(type: .inside)]
        self.SFNode.highPitchButton.animator.animations = [SFSlideAnimation(direction: .left, type: .inside), SFFadeAnimation(type: .inside)]
        self.SFNode.lowPitchButton.animator.animations = [SFSlideAnimation(direction: .right, type: .inside), SFFadeAnimation(type: .inside)]
        self.SFNode.echoPitchButton.animator.animations = [SFSlideAnimation(direction: .left, type: .inside), SFFadeAnimation(type: .inside)]
        self.SFNode.reverbPitchButton.animator.animations = [SFSlideAnimation(direction: .right, type: .inside), SFFadeAnimation(type: .inside)]
        self.SFNode.stopButton.animator.animations = [SFSlideAnimation(direction: .bottom, type: .inside), SFFadeAnimation(type: .inside)]
    }
    
    @objc func didTouch(button: SFButtonNode) {
        
        button.animator.animations = [SFPopAnimation(type: .outside)]
        button.animator.start()
        
        if button == self.SFNode.slowButton {
            playSound(rate: 0.5)
        } else if button == self.SFNode.fastButton {
            playSound(rate: 1.5)
        } else if button == self.SFNode.highPitchButton {
            playSound(pitch: 1000)
        } else if button == self.SFNode.lowPitchButton {
            playSound(pitch: -1000)
        } else if button == self.SFNode.echoPitchButton {
            playSound(echo: true)
        } else if button == self.SFNode.reverbPitchButton {
            playSound(reverb: true)
        } else if button == self.SFNode.stopButton {
            stopAudio()
        }
        
    }
    
    // MARK: - Audio Functions
    
    struct Alerts {
        static let DismissAlert = "Dismiss"
        static let RecordingDisabledTitle = "Recording Disabled"
        static let RecordingDisabledMessage = "You've disabled this app from recording your microphone. Check Settings."
        static let RecordingFailedTitle = "Recording Failed"
        static let RecordingFailedMessage = "Something went wrong with your recording."
        static let AudioRecorderError = "Audio Recorder Error"
        static let AudioSessionError = "Audio Session Error"
        static let AudioRecordingError = "Audio Recording Error"
        static let AudioFileError = "Audio File Error"
        static let AudioEngineError = "Audio Engine Error"
    }
    
    func setupAudio() {
        // initialize (recording) audio file
        do {
            audioFile = try AVAudioFile(forReading: recordedAudioURL as URL)
        } catch {
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            showErrorAlert(title: Alerts.AudioFileError, errorDescription: String(describing: error), actions: [action])
        }
    }
    
    func playSound(rate: Float? = nil, pitch: Float? = nil, echo: Bool = false, reverb: Bool = false) {
        
        // initialize audio engine components
        audioEngine = AVAudioEngine()
        
        // node for playing audio
        audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attach(audioPlayerNode)
        
        // node for adjusting rate/pitch
        let changeRatePitchNode = AVAudioUnitTimePitch()
        if let pitch = pitch {
            changeRatePitchNode.pitch = pitch
        }
        if let rate = rate {
            changeRatePitchNode.rate = rate
        }
        audioEngine.attach(changeRatePitchNode)
        
        // node for echo
        let echoNode = AVAudioUnitDistortion()
        echoNode.loadFactoryPreset(.multiEcho1)
        audioEngine.attach(echoNode)
        
        // node for reverb
        let reverbNode = AVAudioUnitReverb()
        reverbNode.loadFactoryPreset(.cathedral)
        reverbNode.wetDryMix = 50
        audioEngine.attach(reverbNode)
        
        // connect nodes
        if echo == true && reverb == true {
            connectAudioNodes(audioPlayerNode, changeRatePitchNode, echoNode, reverbNode, audioEngine.outputNode)
        } else if echo == true {
            connectAudioNodes(audioPlayerNode, changeRatePitchNode, echoNode, audioEngine.outputNode)
        } else if reverb == true {
            connectAudioNodes(audioPlayerNode, changeRatePitchNode, reverbNode, audioEngine.outputNode)
        } else {
            connectAudioNodes(audioPlayerNode, changeRatePitchNode, audioEngine.outputNode)
        }
        
        // schedule to play and start the engine!
        audioPlayerNode.stop()
        audioPlayerNode.scheduleFile(audioFile, at: nil) {
            
            var delayInSeconds: Double = 0
            
            if let lastRenderTime = self.audioPlayerNode.lastRenderTime, let playerTime = self.audioPlayerNode.playerTime(forNodeTime: lastRenderTime) {
                
                if let rate = rate {
                    delayInSeconds = Double(self.audioFile.length - playerTime.sampleTime) / Double(self.audioFile.processingFormat.sampleRate) / Double(rate)
                } else {
                    delayInSeconds = Double(self.audioFile.length - playerTime.sampleTime) / Double(self.audioFile.processingFormat.sampleRate)
                }
            }
            
            // schedule a stop timer for when audio finishes playing
            self.stopTimer = Timer(timeInterval: delayInSeconds, target: self, selector: #selector(self.stopAudio), userInfo: nil, repeats: false)
            RunLoop.main.add(self.stopTimer!, forMode: RunLoopMode.defaultRunLoopMode)
        }
        
        do {
            try audioEngine.start()
        } catch {
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            showErrorAlert(title: Alerts.AudioEngineError, errorDescription: String(describing: error), actions: [action])
            return
        }
        
        // play the recording!
        audioPlayerNode.play()
    }
    
    func connectAudioNodes(_ nodes: AVAudioNode...) {
        for x in 0..<nodes.count-1 {
            audioEngine.connect(nodes[x], to: nodes[x+1], format: audioFile.processingFormat)
        }
    }
    
    @objc func stopAudio() {
        
        if let audioPlayerNode = audioPlayerNode {
            audioPlayerNode.stop()
        }
        
        if let stopTimer = stopTimer {
            stopTimer.invalidate()
        }
        
        if let audioEngine = audioEngine {
            audioEngine.stop()
            audioEngine.reset()
        }
    }
}












