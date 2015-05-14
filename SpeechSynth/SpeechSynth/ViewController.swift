//
//  ViewController.swift
//  SpeechSynth
//
//  Created by Louis Tur on 5/13/15.
//  Copyright (c) 2015 Louis Tur. All rights reserved.
//

import UIKit
import QuartzCore
import AVFoundation

class ViewController: UIViewController, AVSpeechSynthesizerDelegate {
    
    @IBOutlet weak var tvEditor: UITextView!
    @IBOutlet weak var btnSpeak: UIButton!
    @IBOutlet weak var btnPause: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    @IBOutlet weak var pvSpeechProgress: UIProgressView!
    
    let speechSynthesizer = AVSpeechSynthesizer()
    
    var rate: Float!
    var pitch: Float!
    var volume: Float!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvEditor.layer.cornerRadius = 15.0
        btnSpeak.layer.cornerRadius = 40.0
        btnPause.layer.cornerRadius = 40.0
        btnStop.layer.cornerRadius  = 40.0

        tvEditor.text = "Some default text\n and now with some\nline breaks to test\npausing"
        
        btnPause.alpha = 0.0
        btnStop.alpha = 0.0
        
        pvSpeechProgress.alpha = 0.0
        pvSpeechProgress.progress = 0.0
        
        if !loadSettings() {
            registerDefaultSettings()
        }
        
        speechSynthesizer.delegate = self
        
        var swipeDownGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipeDownGesture:")
        swipeDownGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Down
        view.addGestureRecognizer(swipeDownGestureRecognizer)
    }
    
    func handleSwipeDownGesture (gestureRecognizer: UISwipeGestureRecognizer){
        tvEditor.resignFirstResponder()
    }
    
    // MARK: NSUserDefaults registering/loading
    
    func registerDefaultSettings() {
        rate = AVSpeechUtteranceDefaultSpeechRate
        pitch = 1.0
        volume = 1.0
        
        let defaultSpeechSettings: Dictionary<NSObject, AnyObject> = ["rate":rate, "pitch":pitch, "volume":volume]
        NSUserDefaults.standardUserDefaults().registerDefaults(defaultSpeechSettings)
    }
    
    func loadSettings() -> Bool {
        let userDefaults = NSUserDefaults.standardUserDefaults() as NSUserDefaults
        
        if let theRate: Float = userDefaults.valueForKey("rate") as? Float {
            rate = theRate
            pitch = userDefaults.valueForKey("pitch") as! Float
            volume = userDefaults.valueForKey("volume") as! Float
            
            return true
        }
        
        return false
    }
    
    // MARK: Button Visibility
    
    func animateActionButtonAppearance(shouldHideSpeakButton: Bool) {
        var speakButtonAlphaValue: CGFloat = 1.0
        var pauseStopButtonsAlphaValue: CGFloat = 0.0
        
        if shouldHideSpeakButton {
            speakButtonAlphaValue = 0.0
            pauseStopButtonsAlphaValue = 1.0
        }
        
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.btnSpeak.alpha = speakButtonAlphaValue
            self.btnPause.alpha = pauseStopButtonsAlphaValue
            self.btnStop.alpha = pauseStopButtonsAlphaValue
        })
    }

    // MARK: Button Actions

    @IBAction func speak(sender: AnyObject){
        
        if !speechSynthesizer.speaking {
            let textParagraphs = tvEditor.text.componentsSeparatedByString("\n")
            
            for pieceOfText in textParagraphs {
                let speechUtterance = AVSpeechUtterance(string: pieceOfText)
                speechUtterance.rate = rate
                speechUtterance.volume = volume
                speechUtterance.pitchMultiplier = pitch
                
                speechUtterance.postUtteranceDelay = 0.005
                
                speechSynthesizer.speakUtterance(speechUtterance)
            }
            
        } else {
            speechSynthesizer.continueSpeaking()
        }
        
        animateActionButtonAppearance(true)
    }
    
    @IBAction func pauseSpeech(sender: AnyObject){
        speechSynthesizer.pauseSpeakingAtBoundary(AVSpeechBoundary.Word)
        animateActionButtonAppearance(false)
    }
    
    @IBAction func stopSpeech(sender: AnyObject){
        speechSynthesizer.stopSpeakingAtBoundary(AVSpeechBoundary.Immediate)
        animateActionButtonAppearance(false)
    }
    
    // MARK: AVSpeech Delegate
    
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer!, didFinishSpeechUtterance utterance: AVSpeechUtterance!) {
        animateActionButtonAppearance(false)
    }

}

