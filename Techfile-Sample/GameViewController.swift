//
//  GameViewController.swift
//  Techfile-Sample
//
//  Created by Kenta Okuda on 7/13/16.
//  Copyright © 2016 Kenta Okuda. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var imgView1: UIImageView!
    @IBOutlet var imgView2: UIImageView!
    @IBOutlet var imgView3: UIImageView!
    
    @IBOutlet var resultLabel: UILabel!
    
    var timer: NSTimer!
    var score: Int = 0
    let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()    //スコア保存
    
    let width: CGFloat = UIScreen.mainScreen().bounds.size.width            //画面の幅を取得
    var positionX: [CGFloat] = [0.0, 0.0, 0.0]
    //棒の幅指定(設定値を変えることにより、１クロックでの移動幅を変更する)
    var dx: [CGFloat] = [1.0, 0.5, -1.0]
    
    func initData() {
        score = 1000
        positionX = [width/2, width/2, width/2]
    }
    
    func start() {
        initData()
        resultLabel.hidden = true   //ラベルの非表示
        timer = NSTimer.scheduledTimerWithTimeInterval(0.005, target: self, selector: #selector(GameViewController.up), userInfo: nil, repeats: true)
        timer.fire()
    }

//TODO:      ストップボタンのタップ後、ブロックの停止位置を固定する
    @IBAction func stop() {
        if timer.valid == true {
            timer.invalidate()      //タイマーの停止
            for i in 0..<3 {
                print(positionX[i]) //for debug
                score = score - abs(Int(width/2 - positionX[i]))*2  //基準値からのブロックのズレをもとにスコア算出
            }
//            imgView1.center.x = positionX[0]
//            imgView2.center.x = positionX[1]
//            imgView3.center.x = positionX[2]
            resultLabel.text = "Score: " + String(score)
            resultLabel.hidden = false
            saveScore()
        }
    }
    
    func saveScore() {
        let highScore1: Int = defaults.integerForKey("score1")
        let highScore2: Int = defaults.integerForKey("score2")
        let highScore3: Int = defaults.integerForKey("score3")
        
        if score > highScore1 {
            defaults.setInteger(score, forKey: "score1")
            defaults.setInteger(highScore1, forKey: "score2")
            defaults.setInteger(highScore2, forKey: "score3")
        } else if score > highScore2 {
            defaults.setInteger(score, forKey: "score2")
            defaults.setInteger(highScore2, forKey: "score3")
        } else if score > highScore3 {
            defaults.setInteger(score, forKey: "socre3")
        }
    }
    
    @IBAction func toTop() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
//FIXME:     リトライボタンを複数回タップすると、移動速度が上がり停止できなくなる。
    @IBAction func retry() {
        self.start()
    }
    
    func up() {
        for i in 0..<3 {
            if positionX[i] > width || positionX[i] < 0 {
                dx[i] = dx[i] * (-1)
            }
            positionX[i] += dx[i]
        }
        imgView1.center.x = positionX[0]
        imgView2.center.x = positionX[1]
        imgView3.center.x = positionX[2]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        positionX = [width/2, width/2, width/2]
        self.start()
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
