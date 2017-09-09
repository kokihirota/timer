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
    
    
    
    var dataList = ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"]
    var dataList2 = ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"]
                                     
    @IBOutlet weak var picker: UIPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        picker.dataSource = self
        
    }
    
    var check = 0 //1の時
    var check1 = 1 //1の時、止まっている
    var check2 = 0 //1の時、数え上げ中なので、＋１０秒とか受け付けない
    var check3 = 0 //1の時、計算中なので、動かしても値変えさせない
    var timer: Timer?
    var currentSeconds = 0
    var second = 0
    var minite = 0
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        currentSeconds = 0
//        label.text = "\(currentSeconds)"
//                label.text = String(format:" %02d分 %02d秒", 0, 0)
        check = 1
        check1 = 1
        check3 = 0
                    label.text = String(format:" %02d分 %02d秒", minite, second)
        currentSeconds = minite * 60 + second
        
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
        currentSeconds = second + minite * 60
        print(currentSeconds)
//        label.text = "\(currentSeconds / 60):\(currentSeconds % 60)"
        
        label.text = String(format:" %02d分 %02d秒", minite, second)
        
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
                            label.text = String(format:" %02d分 %02d秒", minite, second)
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
                    label.text = String(format:" %02d分 %02d秒", currentSeconds / 60, currentSeconds % 60)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
 
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {

            return dataList.count
        }
        
        return dataList2.count
    }
    

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        if component == 0 {
            return dataList[row]
        }
        
        return dataList2[row]
    }
    
            var row1 = Int()
    var row2 = Int()
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if component == 0 {
           row1 = row
            print(row)
        }
        if component == 1 {
            row2 = row
        }
        
        second = row2
        minite = row1
 
//        while check3 == 1 {
//            
//        }
      
        if check3 == 0 {
        currentSeconds = row1 * 60 + row2
        label.text = String(format:" %02d分 %02d秒", minite, second)
        }

        
        //              label.text = "\(currentSeconds / 60):\(currentSeconds % 60)"
   
    }
}
