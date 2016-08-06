//
//  TechMonstorViewController.swift
//  Techfile-Sample
//
//  Created by Kenta Okuda on 7/13/16.
//  Copyright © 2016 Kenta Okuda. All rights reserved.
//

import UIKit

class TechMonstorViewController: UIViewController {

    var timer: NSTimer!
    var enemyTimer: NSTimer!
    
    var enemy: Enemy!
    var player: Player!
    
    let util: TechDraUtility = TechDraUtility()
    
    @IBOutlet var backGroundImageView: UIImageView!
    @IBOutlet var attackButton: UIButton!
    
    @IBOutlet var enemyImageView: UIImageView!
    @IBOutlet var playerImageView: UIImageView!
    
    @IBOutlet var enemyHPBar: UIProgressView!
    @IBOutlet var playerHPBar: UIProgressView!
    
    @IBOutlet var enemyNameLabel: UILabel!
    @IBOutlet var playerNameLabel: UILabel!
    
    @IBOutlet var attackLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        enemyHPBar.transform = CGAffineTransformMakeScale(1.0, 4.0)
        playerHPBar.transform = CGAffineTransformMakeScale(1.0, 4.0)
        initStatus()
        
        enemyTimer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(enemy.speed), target: self, selector: #selector(self.enemyAttack), userInfo: nil, repeats: true)
        enemyTimer.fire()
    }
    
    func initStatus() {
        enemy = Enemy()
        player = Player()
        
        enemyNameLabel.text = enemy.name
        playerNameLabel.text = player.name
        
        enemyImageView.image = enemy.image
        playerImageView.image = player.image
        
        enemyHPBar.progress = enemy.currentHP / enemy.maxHP
        playerHPBar.progress = player.currentHP / player.maxHP
        
        cureHP()
    }
    
    @IBAction func playerAttack() {
        TechDraUtility.damageAnimation(enemyImageView)
        util.playBGM("SE_attack")
        
        enemy.currentHP = enemy.currentHP - player.attackPoint
        enemyHPBar.setProgress(enemy.currentHP / enemy.maxHP, animated: true)
        
        if enemy.currentHP <= 0 {
            finishBattle(enemyImageView, winPlayer: true)
        }
    }
    
    @IBAction func enemyAttack() {
        TechDraUtility.damageAnimation(enemyImageView)
        util.playBGM("SE_attack")
        
        player.currentHP = player.currentHP - enemy.attackPoint
        playerHPBar.setProgress(player.currentHP / player.maxHP, animated: true)
        
        if player.currentHP <= 0 {
            finishBattle(enemyImageView, winPlayer: false)
        }
    }
    
    func finishBattle(vanishImageView: UIImageView, winPlayer: Bool) {
        TechDraUtility.vanishAnimation(vanishImageView)
        util.stopBGM()
        timer.invalidate()
        enemyTimer.invalidate()
        
        var finishMessage: String!
        
        if attackButton.hidden != true {
            attackButton.hidden = true
            attackLabel.hidden = true
        }
        
        if winPlayer == true {
            util.playBGM("SE_fanfare")
            finishMessage = "プレイヤーの勝利！！"
        } else {
            util.playBGM("SE_gameover")
            finishMessage = "プレイヤーの敗北..."
        }
        
        let alert = UIAlertController(title: "バトル終了", message: finishMessage, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in self.dismissViewControllerAnimated(true, completion: nil)}))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func cureHP() {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(self.updateHPValue), userInfo: nil, repeats: true)
    }
    
    func updateHPValue() {
        if enemy.currentHP < enemy.maxHP {
            enemy.currentHP = enemy.currentHP + enemy.defencePoint
            enemyHPBar.progress = enemy.currentHP / enemy.maxHP
        }
        
        if player.currentHP < player.maxHP {
            player.currentHP = player.currentHP + player.defencePoint
            playerHPBar.progress = player.currentHP / player.maxHP
        }

    }
    
    override func viewDidAppear(animated: Bool) {
        util.playBGM("BGM_battle001")
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
