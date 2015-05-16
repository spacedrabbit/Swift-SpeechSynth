//
//  SettingsViewController.swift
//  SpeechSynth
//
//  Created by Louis Tur on 5/13/15.
//  Copyright (c) 2015 Louis Tur. All rights reserved.
//

import UIKit
import AVFoundation

protocol SettingsViewControllerDelegate{
    func didSaveSettings()
}

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tbSettings: UITableView!
    
    var pitch: Float!
    var rate: Float!
    var volume: Float!
    
    var delegate: SettingsViewControllerDelegate!
    
    let speechSettings = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbSettings.delegate = self
        tbSettings.dataSource = self
        
        tbSettings.layer.cornerRadius = 15.0
        
        loadUserDefaults(speechSettings)
      
    }
    
    func handleSliderValueChange(sender: CustomSlider) {
        switch sender.sliderIdentifier {
        case 100:
            rate = sender.value
        case 200:
            pitch = sender.value
        default:
            volume = sender.value
        }
        tbSettings.reloadData()
    }
    
    func loadUserDefaults(defaults: NSUserDefaults) -> Bool{
        if let defaultPitch = defaults.valueForKey("pitch") as? Float {
            pitch = defaultPitch
            rate = defaults.valueForKey("rate") as! Float
            volume = defaults.valueForKey("volume") as! Float
            
            return true
        } else{
            pitch = 1.0
            rate = 1.0
            volume = 1.0
            
            return false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        
        if indexPath.row < 3 {
            cell = tableView.dequeueReusableCellWithIdentifier("idCellSlider", forIndexPath: indexPath) as! UITableViewCell
            
            let keyLabel = cell.contentView.viewWithTag(10) as? UILabel
            let valueLabel = cell.contentView.viewWithTag(20) as? UILabel
            let slider = cell.contentView.viewWithTag(30) as? CustomSlider
            
            var value: Float = 0.0
            switch indexPath.row {
                case 0:
                    value = rate
                    keyLabel?.text = "Rate"
                    valueLabel?.text = NSString(format: "%.2f", rate) as String
                    slider?.minimumValue = AVSpeechUtteranceMinimumSpeechRate
                    slider?.maximumValue = AVSpeechUtteranceMaximumSpeechRate
                    slider?.sliderIdentifier = 100
                    slider?.addTarget(self, action: "handleSliderValueChange:", forControlEvents: UIControlEvents.ValueChanged)
                case 1:
                    value = pitch
                    keyLabel?.text = "Pitch"
                    valueLabel?.text = NSString(format: "%.2f", pitch) as String
                    slider?.minimumValue = 0.5
                    slider?.maximumValue = 2.0
                    slider?.sliderIdentifier = 200
                    slider?.addTarget(self, action: "handleSliderValueChange:", forControlEvents: UIControlEvents.ValueChanged)
                default:
                    value = volume
                    keyLabel?.text = "Volume"
                    valueLabel?.text = NSString(format: "%.2f", volume) as String
                    slider?.minimumValue = 0.0
                    slider?.maximumValue = 1.0
                    slider?.sliderIdentifier = 300
                    slider?.addTarget(self, action: "handleSliderValueChange:", forControlEvents: UIControlEvents.ValueChanged)
            }
            
            if slider?.value != value {
                slider?.value = value
            }
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row < 3{
            return 100.0
        } else {
            return 170.0
        }
    }
    
    @IBAction func saveSettings(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setFloat(rate, forKey: "rate")
        NSUserDefaults.standardUserDefaults().setFloat(pitch, forKey: "pitch")
        NSUserDefaults.standardUserDefaults().setFloat(volume, forKey: "volume")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        self.delegate.didSaveSettings()
        navigationController?.popViewControllerAnimated(true)
    }

}
