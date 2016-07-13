//
//  GachaResultViewController.swift
//  Techfile-Sample
//
//  Created by Kenta Okuda on 7/13/16.
//  Copyright © 2016 Kenta Okuda. All rights reserved.
//

import UIKit

class GachaResultViewController: UIViewController {

    @IBOutlet var haikeiImageView: UIImageView!
    @IBOutlet var monsterImageView: UIImageView!
    var monsterArray: [UIImage]!        //モンスター用配列

    override func viewDidLoad() {
        super.viewDidLoad()

        let number = Int(rand() % 10)   //乱数の生成
        print(number)                   //for debug
        
        monsterArray = [
            UIImage(named: "monster001.png")!,
            UIImage(named: "monster002.png")!,
            UIImage(named: "monster003.png")!,
            UIImage(named: "monster004.png")!,
            UIImage(named: "monster005.png")!,
            UIImage(named: "monster006.png")!,
            UIImage(named: "monster007.png")!,
            UIImage(named: "monster008.png")!,
            UIImage(named: "monster009.png")!,
            UIImage(named: "monster010.png")!
        ]
        
        monsterImageView.image = monsterArray[number]
        
        //モンスターによる背景画像の変更
        if number == 9 {
            haikeiImageView.image = UIImage(named: "bg_gold.png")
        } else if number > 6 {
            haikeiImageView.image = UIImage(named: "bg_red.png")
        } else {
            haikeiImageView.image = UIImage(named: "bg_blue.png")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //背景アニメーション
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        let animation = CABasicAnimation(keyPath: "transform")
        animation.fromValue = NSNumber(double: 0)                                   //Animation start
        animation.toValue = NSNumber(double: 2 * M_PI)                              //Animation end
        animation.valueFunction = CAValueFunction(name: kCAValueFunctionRotateZ)    //Z軸を中心とした回転
        animation.duration = 5                                                      //アニメーションの早さ
        animation.repeatCount = Float.infinity                                      //アニメーションの繰り返し
        haikeiImageView.layer.addAnimation(animation, forKey: nil)
    }
    
    //もどるButton
    @IBAction func modoru() {
        self.dismissViewControllerAnimated(true, completion: nil)
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
