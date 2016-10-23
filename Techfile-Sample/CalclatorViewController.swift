//
//  CalclatorViewController.swift
//  Techfile-Sample
//
//  Created by Kenta Okuda on 7/13/16.
//  Copyright © 2016 Kenta Okuda. All rights reserved.
//

import UIKit

class CalclatorViewController: UIViewController {

    @IBOutlet var label: UILabel!
    var number: Int = 0
    var number2: Int = 0
    var oparation: Int = 0
    var push_btn: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initCalc() {
        number = 0
        number2 = 0
        oparation = 0
        push_btn = 0
        label.text = "0"
    }
    
    func disp(_ num:Int) {
        number = number * 10
        number += num
        label.text = String(number)
    }
    
    @IBAction func pushButton(_ sender: UIButton) {
        push_btn = Int((sender.titleLabel!.text)!)!
        disp(push_btn)
    }

    @IBAction func plus() {
        label.text = "0"
        oparation = 1
        number2 = number
        number = 0
    }
    
    @IBAction func minus() {
        label.text = "0"
        oparation = 2
        number2 = number
        number = 0
    }
    
    @IBAction func waru() {
        label.text = "0"
        oparation = 3
        number2 = number
        number = 0
    }
    
    @IBAction func kakeru() {
        label.text = "0"
        oparation = 4
        number2 = number
        number = 0
    }
    
    @IBAction func equal() {
        
        switch(oparation) {
        case 1:
            label.text = String(number2 + number)
            number = number2 + number
        case 2:
            label.text = String(number2 - number)
            number = number2 - number
        case 3:
            label.text = String(number2 / number)
            number = number2 / number
        case 4:
            label.text = String(number2 * number)
            number = number2 * number
        default:
            label.text = "Error"
            initCalc()
        }
    }
    
    @IBAction func clear() {
        initCalc()
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
