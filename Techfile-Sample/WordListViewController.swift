//
//  WordListViewController.swift
//  Techfile-Sample
//
//  Created by Kenta Okuda on 7/13/16.
//  Copyright © 2016 Kenta Okuda. All rights reserved.
//

import UIKit

class WordListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(_ segue: UIStoryboardSegue){
        
    }
    
    @IBAction func startButtonTapped() {
        let saveData = UserDefaults.standard
        
        if let wordArray = saveData.array(forKey: "WORD") {
            if wordArray.count  > 0 {
                self.performSegue(withIdentifier: "toQuestionView", sender: nil)
                return
            }
        }
        
        let alert: UIAlertController = UIAlertController(title: "単語", message: "まずは「単語一覧」をタップして単語登録をしてください", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
