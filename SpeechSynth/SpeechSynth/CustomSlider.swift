//
//  CustomSlider.swift
//  SpeechSynth
//
//  Created by Louis Tur on 5/15/15.
//  Copyright (c) 2015 Louis Tur. All rights reserved.
//

import UIKit

class CustomSlider: UISlider {

    
    var sliderIdentifier: Int!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        sliderIdentifier = 0
    }
    
    func handleSliderValueChange(sender: CustomSlider){
        
    }

}
