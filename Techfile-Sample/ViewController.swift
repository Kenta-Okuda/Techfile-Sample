//
//  ViewController.swift
//  Techfile-Sample
//
//  Created by Kenta Okuda on 7/13/16.
//  Copyright © 2016 Kenta Okuda. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    let appName = ["時計","カウント","電卓","クイズアプリ","なべあつ","ガチャアプリ","クラップ","単語帳アプリ","バラバラゲーム","フォトマスター","迷路ゲーム","テクモン"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appName.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! MainTableViewCell
        
        cell.appName.text = appName[indexPath.row]
        if indexPath.row % 2 != 0 {
            cell.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
            case 0: self.performSegueWithIdentifier("clock",        sender: nil)
            case 1: self.performSegueWithIdentifier("count",        sender: nil)
            case 2: self.performSegueWithIdentifier("calclator",    sender: nil)
            case 3: self.performSegueWithIdentifier("quiz",         sender: nil)
            case 4: self.performSegueWithIdentifier("nabeatsu",     sender: nil)
            case 5: self.performSegueWithIdentifier("gacha",        sender: nil)
            case 6: self.performSegueWithIdentifier("clap",         sender: nil)
            case 7: self.performSegueWithIdentifier("word_list",    sender: nil)
            case 8: self.performSegueWithIdentifier("bara",         sender: nil)
            case 9: self.performSegueWithIdentifier("photo_master", sender: nil)
            case 10: self.performSegueWithIdentifier("maze",        sender: nil)
            case 11: self.performSegueWithIdentifier("tech_monstor",sender: nil)
            default: return
        }
    }
    
    @IBAction func back(segue: UIStoryboardSegue) {
    }

}

