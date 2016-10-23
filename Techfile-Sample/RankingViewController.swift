//
//  RankingViewController.swift
//  Techfile-Sample
//
//  Created by Kenta Okuda on 7/13/16.
//  Copyright © 2016 Kenta Okuda. All rights reserved.
//

import UIKit

class RankingViewController: UIViewController {

    @IBOutlet var rankLabel1: UILabel!
    @IBOutlet var rankLabel2: UILabel!
    @IBOutlet var rankLabel3: UILabel!
    
    let defaults: UserDefaults = UserDefaults.standard
    
    @IBAction func toTop() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        rankLabel1.text = String(defaults.integer(forKey: "score1"))
        rankLabel2.text = String(defaults.integer(forKey: "score2"))
        rankLabel3.text = String(defaults.integer(forKey: "score3"))
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
