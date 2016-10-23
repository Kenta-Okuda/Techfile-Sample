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
        
        tableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appName.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainTableViewCell
        
        cell.appName.text = appName[(indexPath as NSIndexPath).row]
        if (indexPath as NSIndexPath).row % 2 != 0 {
            cell.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath as NSIndexPath).row {
            case 0: self.performSegue(withIdentifier: "clock",        sender: nil)
            case 1: self.performSegue(withIdentifier: "count",        sender: nil)
            case 2: self.performSegue(withIdentifier: "calclator",    sender: nil)
            case 3: self.performSegue(withIdentifier: "quiz",         sender: nil)
            case 4: self.performSegue(withIdentifier: "nabeatsu",     sender: nil)
            case 5: self.performSegue(withIdentifier: "gacha",        sender: nil)
            case 6: self.performSegue(withIdentifier: "clap",         sender: nil)
            case 7: self.performSegue(withIdentifier: "word_list",    sender: nil)
            case 8: self.performSegue(withIdentifier: "bara",         sender: nil)
            case 9: self.performSegue(withIdentifier: "photo_master", sender: nil)
            case 10: self.performSegue(withIdentifier: "maze",        sender: nil)
            case 11: self.performSegue(withIdentifier: "tech_monstor",sender: nil)
            default: return
        }
    }
    
    @IBAction func back(_ segue: UIStoryboardSegue) {
    }

}

