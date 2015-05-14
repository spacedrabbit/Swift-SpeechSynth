//
//  SettingsViewController.swift
//  SpeechSynth
//
//  Created by Louis Tur on 5/13/15.
//  Copyright (c) 2015 Louis Tur. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tbSettings: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbSettings.delegate = self
        tbSettings.dataSource = self
        
        tbSettings.layer.cornerRadius = 15.0
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        
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
        
    }

}
