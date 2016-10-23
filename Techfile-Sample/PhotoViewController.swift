//
//  PhotoViewController.swift
//  Techfile-Sample
//
//  Created by Kenta Okuda on 7/13/16.
//  Copyright © 2016 Kenta Okuda. All rights reserved.
//

import UIKit
import Social

class PhotoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func precentPickerController(_ sourceType: UIImagePickerControllerSourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!) {
        self.dismiss(animated: true, completion: nil)
        
        photoImageView.image = image
    }
    
    @IBAction func selectButtonTapped(_ sender: UIButton) {
        //選択肢のタイトル、メッセージ、アラートタイプの設定
        let alertController = UIAlertController(title: "画像の取得先を選択", message: nil, preferredStyle: .actionSheet)
        
        //選択肢の名前と処理
        let firstAction = UIAlertAction(title: "カメラ", style: .default) {
            action in
            self.precentPickerController(.camera)
        }
        
        let secondAction = UIAlertAction(title: "アルバム", style: .default) {
            action in
            self.precentPickerController(.photoLibrary)
        }
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        
        //選択肢をアラートに登録
        alertController.addAction(firstAction)
        alertController.addAction(secondAction)
        alertController.addAction(cancelAction)
        
        //選択肢を表示
        present(alertController, animated: true, completion: nil)
    }
    
    //テキストの合成
    func drawText(_ image: UIImage) -> UIImage {
        //テキストの内容
        let text = "Life is Tech!"
        
        //グラフィックコンテキストの生成、編集開始
        UIGraphicsBeginImageContext(image.size)
        
        //読み込んだ写真の書き出し
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        
        //書き出す位置と大きさ
        let textRect = CGRect(x: 5, y: 5, width: image.size.width - 5, height: image.size.height - 5)
        
        //テキストの特性（フォント、カラー、スタイル）の設定
        let textFontAttributes = [
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: 120),
            NSForegroundColorAttributeName: UIColor.red,
            NSParagraphStyleAttributeName: NSMutableParagraphStyle.default
        ]
        
        //指定範囲にテキストを描写
        text.draw(in: textRect, withAttributes: textFontAttributes)
        
        //グラフィックコンテキストの画像を取得
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        //グラフィックコンテキストの編集終了
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    //画像の合成
    func drawMaskImage(_ image: UIImage) -> UIImage {
        //グラフィックコンテキストの生成、編集開始
        UIGraphicsBeginImageContext(image.size)
        
        //読み込んだ写真の書き出し
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        
        //マスク画像
        let maskImage = UIImage(named: "lifeistech_logo_1280x720")
        
        //描き出す位置と大きさの設定
        let offset: CGFloat = 50.0
        let maskRect = CGRect(
            x: image.size.width - maskImage!.size.width - offset,
            y: image.size.height - maskImage!.size.height - offset,
            width: maskImage!.size.width, height: maskImage!.size.height)
        
        //指定範囲に画像を描写
        maskImage!.draw(in: maskRect)
        
        //グラフィックコンテキストの取得
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        //グラフィックコンテキストの編集終了
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    //アラート
    func simpleAlert(_ titleString: String) {
        let alertController = UIAlertController(title: titleString, message: nil, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func processButtonTapped(_ sender: UIButton) {
        guard let selectedPhoto = photoImageView.image else {
            simpleAlert("画像がありません")
            return
        }
        //選択肢のタイトル、メッセージ、アラートタイプの設定
        let alertController = UIAlertController(title: "合成するパーツを選択", message: nil, preferredStyle: .actionSheet)
        
        //選択肢の名前と処理
        let firstAction = UIAlertAction(title: "テキスト", style: .default) {
            action in
            
            self.photoImageView.image = self.drawText(selectedPhoto)
        }
        let secondAction = UIAlertAction(title: "LiT!ロゴ", style: .default) {
            action in
            
            self.photoImageView.image = self.drawMaskImage(selectedPhoto)
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        
        //選択肢をアラートに登録
        alertController.addAction(firstAction)
        alertController.addAction(secondAction)
        alertController.addAction(cancelAction)
        
        //選択肢を表示
        present(alertController, animated: true, completion: nil)
    }
    
    func postToSNS(_ serviceType: String) {
        let myComposeView = SLComposeViewController(forServiceType: serviceType)
        
        myComposeView?.setInitialText("PhotoMasterからの投稿！")
        myComposeView?.add(photoImageView.image)
        self.present(myComposeView!, animated: true, completion: nil)
    }
    
    @IBAction func uploadButtonTapped(_ sender: UIButton) {
        guard let selectedPhoto = photoImageView.image else {
            simpleAlert("画像がありません")
            return
        }
        //選択肢のタイトル、メッセージ、アラートタイプの設定
        let alertController = UIAlertController(title: "アップロード先を選択", message: nil, preferredStyle: .actionSheet)
        
        //選択肢の名前と処理
        let firstAction = UIAlertAction(title: "Facebookに投稿", style: .default) {
            action in
            
            self.postToSNS(SLServiceTypeFacebook)
        }
        let secondAction = UIAlertAction(title: "Twitterに投稿", style: .default) {
            action in
            
            self.postToSNS(SLServiceTypeTwitter)
        }
        let thirdAction = UIAlertAction(title: "カメラロールに保存", style: .default) {
            action in
            UIImageWriteToSavedPhotosAlbum(selectedPhoto, self, nil, nil)
            self.simpleAlert("アルバムに保存されました")
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        
        //選択肢をアラートに登録
        alertController.addAction(firstAction)
        alertController.addAction(secondAction)
        alertController.addAction(thirdAction)
        alertController.addAction(cancelAction)
        
        //選択肢を表示
        present(alertController, animated: true, completion: nil)
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
