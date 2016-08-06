//
//  LobbyViewController.swift
//  Techfile-Sample
//
//  Created by Kenta Okuda on 2016/08/07.
//  Copyright © 2016年 Kenta Okuda. All rights reserved.
//

import UIKit
import AVFoundation

class LobbyViewController: UIViewController, AVAudioPlayerDelegate {
    
    var stamina: Float = 0
    var staminaTimer: NSTimer!
    var util: TechDraUtility!
    var player: Player!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var staminaBar: UIProgressView!
    @IBOutlet var levelLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player = Player()
        staminaBar.transform = CGAffineTransformMakeScale(1.0, 4.0)
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let level: Int = userDefaults.integerForKey("lebel")
        
        nameLabel.text = player.name
        levelLabel.text = String(format: "Lv. %d", level + 1)
        
        util = TechDraUtility()
        cureStamina()
    }
    
    func cureStamina() {
        staminaTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(self.updateStaminaValue), userInfo: nil, repeats: true)
        staminaTimer.fire()
    }
    
    func updateStaminaValue() {
        if stamina <= 100 {
            stamina = stamina + 1
            staminaBar.progress = stamina / 100
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        util.playBGM("lobby")
    }
    
    override func viewWillDisappear(animated: Bool) {
        util.stopBGM()
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

}