//
//  QuestionViewController.swift
//  Techfile-Sample
//
//  Created by Kenta Okuda on 7/13/16.
//  Copyright © 2016 Kenta Okuda. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    var quizArray = [[AnyObject]]()
    
    //正解数
    var correctAnswer:Int = 0
    
    //クイズを表示するTextView
    @IBOutlet var quizTextView: UITextView!
    
    //選択肢のボタン
    @IBOutlet var choiceButtons1: UIButton!
    @IBOutlet var choiceButtons2: UIButton!
    @IBOutlet var choiceButtons3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var tmpArray = [[AnyObject]]()
        
        //------------------------ここから下にクイズを書く------------------------//
        tmpArray.append(["問題文1" as AnyObject,"選択肢" as AnyObject,"選択肢2" as AnyObject,"選択肢3" as AnyObject,1 as AnyObject])
        tmpArray.append(["問題文2" as AnyObject,"選択肢" as AnyObject,"選択肢2" as AnyObject,"選択肢3" as AnyObject,2 as AnyObject])
        tmpArray.append(["問題文3" as AnyObject,"選択肢" as AnyObject,"選択肢2" as AnyObject,"選択肢3" as AnyObject,2 as AnyObject])
        tmpArray.append(["問題文4" as AnyObject,"選択肢" as AnyObject,"選択肢2" as AnyObject,"選択肢3" as AnyObject,3 as AnyObject])
        tmpArray.append(["問題文5" as AnyObject,"選択肢" as AnyObject,"選択肢2" as AnyObject,"選択肢3" as AnyObject,3 as AnyObject])
        tmpArray.append(["問題文6" as AnyObject,"選択肢" as AnyObject,"選択肢2" as AnyObject,"選択肢3" as AnyObject,3 as AnyObject])
        //------------------------ここから上にクイズを書く------------------------//
        
        // 問題をシャッフルしてquizArrayに格納する
        while (tmpArray.count > 0) {
            let index = Int(arc4random_uniform(UInt32(tmpArray.count)))
            quizArray.append(tmpArray[index])
            tmpArray.remove(at: index)
        }
        choiceQuiz()
    }
    
    func choiceQuiz() {
        quizTextView.text = quizArray[0][0] as! String
        
        //選択肢のボタンにそれぞれ選択肢のテキストをセット
        choiceButtons1.setTitle(quizArray[0][1] as? String, for: UIControlState())
        choiceButtons2.setTitle(quizArray[0][2] as? String, for: UIControlState())
        choiceButtons3.setTitle(quizArray[0][3] as? String, for: UIControlState())
    }
    
    @IBAction func choiceAnswer(_ sender: UIButton) {
        if quizArray[0][4] as! Int == sender.tag {
            //正解数を増やす
            correctAnswer = correctAnswer + 1
        }
        
        quizArray.remove(at: 0)
        //解いた問題数の合計が予め設定していた問題数に達したら結果画面へ
        if quizArray.count == 0 {
            performSegueToResult()
        } else {
            choiceQuiz()
        }
    }
    
    func performSegueToResult() {
        performSegue(withIdentifier: "toResultView", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "toResultView") {
            
            let resultView = segue.destination as! ResultViewController
            resultView.correctAnswer = self.correctAnswer
        }
        
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
