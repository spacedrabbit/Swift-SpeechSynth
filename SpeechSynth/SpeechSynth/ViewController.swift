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

class ViewController: UIViewController {
    
    @IBOutlet weak var tvEditor: UITextView!
    @IBOutlet weak var btnSpeak: UIButton!
    @IBOutlet weak var btnPause: UIButton!
    @IBOutlet weak var btnStop: UIButton!
    @IBOutlet weak var pvSpeechProgress: UIProgressView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvEditor.layer.cornerRadius = 15.0
        btnSpeak.layer.cornerRadius = 40.0
        btnPause.layer.cornerRadius = 40.0
        btnStop.layer.cornerRadius  = 40.0
        // Do any additional setup after loading the view, typically from a nib.
        
        btnPause.alpha = 0.0
        btnStop.alpha = 0.0
        
        pvSpeechProgress.alpha = 0.0
        pvSpeechProgress.progress = 0.0
        
        var swipeDownGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipeDownGesture:")
        swipeDownGestureRecognizer.direction = UISwipeGestureRecognizerDirection.Down
        view.addGestureRecognizer(swipeDownGestureRecognizer)
    }
    
    func handleSwipeDownGesture (gestureRecognizer: UISwipeGestureRecognizer){
        tvEditor.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func speak(sender: AnyObject){
        
    }
    
    @IBAction func pauseSpeech(sender: AnyObject){
        
    }
    
    @IBAction func stopSpeech(sender: AnyObject){
        
    }
}

