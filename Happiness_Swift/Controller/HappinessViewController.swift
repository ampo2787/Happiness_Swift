//
//  HappinessViewController.swift
//  Happiness_Swift
//
//  Created by JihoonPark on 04/02/2019.
//  Copyright © 2019 JihoonPark. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, FaceViewDelegate{

    @IBOutlet weak var happinessLabel: UILabel!
    @IBOutlet weak var faceView: FaceView!
    @IBOutlet weak var happinessSlider: UISlider!
    
    @IBAction func happinessSliderChanged(_ sender: UISlider) {
        self.sethappiness(newHappiness: Int(sender.value))
    }
    
    var happiness:Int?
    let MAX_HAPPINESS = 100
    let MIN_HAPPINESS = 0
    let DEFAULT_HAPPINESS = 50
    
    func happinessToSmilness(happiness:Int) -> CGFloat {
        let ratioOfHappiness:CGFloat = CGFloat(happiness - MIN_HAPPINESS) / CGFloat(MAX_HAPPINESS - MIN_HAPPINESS)
        let smileness:CGFloat = ratioOfHappiness * 2.0 - 1.0
        return smileness
    }
    
    func sethappiness(newHappiness:Int) {
        if newHappiness < MIN_HAPPINESS {
            happiness = MIN_HAPPINESS
        }
        else if newHappiness > MAX_HAPPINESS{
            happiness = MAX_HAPPINESS
        }
        else{
            happiness = newHappiness
        }
        self.updateFaceView()
    }
    
    
    func updateFaceView() {
        self.happinessSlider.value = Float(self.happiness!)
        self.happinessLabel.text = String(self.happiness!)
        self.faceView.setNeedsDisplay()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        faceView.delegate = self
        faceView.reset()
        
        self.view.layer.backgroundColor = UIColor.lightGray.cgColor
        self.happiness = DEFAULT_HAPPINESS
        self.updateFaceView()
    }
    
    func smilenessForFaceView(requestor: FaceView) -> CGFloat {
        var smileness : CGFloat = 0.0
        if requestor == self.faceView {
            smileness = happinessToSmilness(happiness: self.happiness!)
        }
        return smileness
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
