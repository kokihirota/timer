//
//  ViewController.swift
//  GGG
//
//  Created by s15ti050 on 2017/09/08.
//  Copyright © 2017年 s15ti050. All rights reserved.
//

//        測定中に時間をコロコロすると、値が変わっちゃう

import UIKit
import AudioToolbox

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // 選択肢
//    var dataList = ["ss"]
//    var dataList2 = ["xx"]
    
//    var dataList = ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23"]
//    
//    
//    var dataList2 = ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"]
//    var dataList3 = ["0","1","2","3","4","5","6 ","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"]
//    
    
    var dataList = [""]
    var dataList2 = [""]
    var dataList3 = [""]
    
    var ee = [Int]()

    @IBOutlet weak var picker: UIPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataList = createDate(from: 0, to: 23)
        dataList2 = createDate(from: 0, to: 59)
        dataList3 = createDate(from: 0, to: 59)
        
        picker.delegate = self
        picker.dataSource = self
        
        let hStr = UILabel()
        hStr.text = "時間"
        hStr.sizeToFit()
        hStr.frame = CGRectMake(picker.bounds.width/4 + 3 * hStr.bounds.width/8,
                                picker.bounds.height/2 + (hStr.bounds.height/2),
                                hStr.bounds.width, hStr.bounds.height)
        self.view.addSubview(hStr)
        let mStr = UILabel()
        mStr.text = "分"
        mStr.sizeToFit()
        mStr.frame = CGRectMake(picker.bounds.width/2 + 19 * mStr.bounds.width/16,
                                picker.bounds.height/2 + mStr.bounds.height/2,
                                mStr.bounds.width, mStr.bounds.height)
        self.view.addSubview(mStr)
        
        
        let sStr = UILabel()
        sStr.text = "秒"
        sStr.sizeToFit()
        sStr.frame = CGRectMake(3 * picker.bounds.width/4 + 7 * sStr.bounds.width/4,
                                picker.bounds.height/2 + (sStr.bounds.height/2),
                                sStr.bounds.width, sStr.bounds.height)
        self.view.addSubview(sStr)
        
        
        
    }
    
    var check = 0 //1の時
    var check1 = 1 //1の時、止まっている
    var check2 = 0 //1の時、数え上げ中なので、＋１０秒とか受け付けない
    var check3 = 0 //1の時、計算中なので、動かしても値変えさせない
    var timer: Timer?
    var currentSeconds = 0
    var second = 0
    var minite = 0
    var hour = 0
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        currentSeconds = 0
//        label.text = "\(currentSeconds)"
//                label.text = String(format:" %02d分 %02d秒", 0, 0)
        check = 1
        check1 = 1
        check3 = 0
                    label.text = String(format:"残り %02d時間 %02d分 %02d秒", hour, minite, second)
        currentSeconds = hour * 3600 + minite * 60 + second
        
    }
    
    
    @IBAction func stopButtonTapped(_ sender: UIButton) {
        if check1 == 0 {
            check1 = 1
        }
    }
    
    
    @IBOutlet weak var label: UILabel!
    @IBAction func startButtonTapped(_ sender: UIButton) { //とりあえず、数え上げはしない
        if check1 == 1 && currentSeconds != 0 {
            check1 = 0
            start()
            check3 = 1
        check = 0
        }
    }
    
    func start() {
        currentSeconds = hour * 3600 + minite * 60 + second
        print(currentSeconds)
//        label.text = "\(currentSeconds / 60):\(currentSeconds % 60)"
        
        label.text = String(format:"残り %02d時間 %02d分 %02d秒", hour, minite, second)
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.update), userInfo: nil, repeats: true);
        
    }
    
    func update() {
        if currentSeconds == 0 {
            timer?.invalidate()
            let soundID: SystemSoundID = 1005
            if check == 0 {
                AudioServicesPlayAlertSound(soundID)
                check3 = 0
                            label.text = String(format:"残り %02d時間 %02d分 %02d秒",hour, minite, second)
            }
            check = 0
            check1 = 1
//        label.text = String(format:" %02d分 %02d秒", currentSeconds / 60, currentSeconds % 60)
//            label.text = "\(currentSeconds / 60):\(currentSeconds % 60)"
        }
        else if check1 == 1 {
        }
            
        else {
            currentSeconds -= 1
//            label.text = "\(currentSeconds / 60):\(currentSeconds % 60)"
                    label.text = String(format:"残り %02d時間 %02d分 %02d秒", currentSeconds / 3600, (currentSeconds % 3600) / 60, (currentSeconds % 3600) % 60)
            print(currentSeconds)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
 
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {
            return dataList.count
        }
        else if component == 1 {
            return dataList2.count
        }
        else {
            return dataList3.count
        }
    }
    

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        if component == 0 {
            return dataList[row]
        }
        else if component == 1 {
            return dataList2[row]
        }
        else {
            return dataList3[row]
        }
    }
    
    

//    //サイズを返すメソッド
//    func pickerView(_ pickerView: UIPickerView, widthForComponent component:Int) -> CGFloat {
//        
//        switch component {
//        case 0:
//            return 70
//            
//        case 1:
//            return 70
//            
//        default:
//            return 100
//        }
//        
//    }
    
    
    
            var row1 = Int()
    var row2 = Int()
    var row3 = Int()
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if component == 0 {
           row3 = row
        }
        else if component == 1 {
            row2 = row
        }
        else {
            row1 = row
        }
        
        second = row1
        minite = row2
        hour = row3
      
        if check3 == 0 {
        currentSeconds = row3 * 3600 + row2 * 60 + row1
        label.text = String(format:"残り %02d時間 %02d分 %02d秒", hour, minite, second)
        }
    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    func createDate (from: Int,to :Int) -> [String]{
        var data = [String]()
        for num in 0...59 {
            data.append(String(num))
        }
        return data
    }

}
