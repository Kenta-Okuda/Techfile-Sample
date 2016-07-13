//
//  NabeatsuViewController.swift
//  Techfile-Sample
//
//  Created by Kenta Okuda on 7/13/16.
//  Copyright © 2016 Kenta Okuda. All rights reserved.
//

import UIKit

class NabeatsuViewController: UIViewController {

    var number: Int = 0
    @IBOutlet var label: UILabel!
    @IBOutlet var faceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = String(0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func isAho() ->Bool {
        var checkNum: Int
        checkNum = number
        
        if number % 3 == 0 {
            return true
        }
        while checkNum != 0 {
            if checkNum % 10 == 3 {
                return true
            } else {
                checkNum /= 10
            }
        }
        return false
    }
    
    @IBAction func plusButton(){
        number = number + 1
        label.text = String(number)
        if isAho() == true {
            faceLabel.text = "ﾍ(ﾟ∀ﾟﾍ)ｱﾋｬ"
        } else {
            faceLabel.text = "(゜o゜)"
        }
    }
    
    @IBAction func clear() {
        number = 0
        label.text = String(number)
        faceLabel.text = "(゜o゜)"
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
