//
//  ViewController.swift
//  GGG
//
//  Created by s15ti050 on 2017/09/08.
//  Copyright © 2017年 s15ti050. All rights reserved.
//
import Foundation
import UIKit
import AudioToolbox

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource ,UITextFieldDelegate{
    

    @IBAction func Button(_ sender: UIBarButtonItem) {
//    }
//    @IBAction func onTouchBootMenuButton(_ sender: UIBarButtonItem) {
        guard let rootViewController = rootViewController() else { return }
        rootViewController.presentMenuViewController()
        
    }
//    
//    @IBAction func onTouchCloseMenuButton(sender: UIButton) {
//        guard let rootViewController = rootViewController() else {return }
//        rootViewController.dismissMenuViewController()
//    }
//    
    var dataList = [""]
    var dataList2 = [""]
    var dataList3 = [""]

    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var barButton: UIToolbar!
    
    let hStr = UILabel()
    let mStr = UILabel()
    let sStr = UILabel()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()

        dataList = createDate(from: 0, to: 23)
        dataList2 = createDate(from: 0, to: 59)
        dataList3 = createDate(from: 0, to: 59)
        
        picker.delegate = self
        picker.dataSource = self
        

        hStr.text = "時間"
        hStr.sizeToFit()
        hStr.frame = CGRectMake(picker.bounds.width/4 + 9 * hStr.bounds.width/16,
                                picker.bounds.height/2 + (hStr.bounds.height/2) + barButton.bounds.height,
                                hStr.bounds.width, hStr.bounds.height)
        self.view.addSubview(hStr)
        
//        let mStr = UILabel()
        mStr.text = "分"
        mStr.sizeToFit()
        mStr.frame = CGRectMake(picker.bounds.width/2 + 25 * mStr.bounds.width/16,
                                picker.bounds.height/2 + mStr.bounds.height/2 + barButton.bounds.height,
                                mStr.bounds.width, mStr.bounds.height)
        self.view.addSubview(mStr)
        
//        let sStr = UILabel()
        sStr.text = "秒"
        sStr.sizeToFit()
        sStr.frame = CGRectMake(3 * picker.bounds.width/4 + 8 * sStr.bounds.width/4,
                                picker.bounds.height/2 + (sStr.bounds.height/2) + barButton.bounds.height,
                                sStr.bounds.width, sStr.bounds.height)
        self.view.addSubview(sStr)


    }

 
    var check = 0 //1の時
    var check1 = 1 //1の時、止まっている 2の時、ストップを押された場合の挙動
    var check2 = 0 //1の時、数え上げ中なので、＋１０秒とか受け付けない
    var check3 = 0 //1の時、計算中なので、動かしても値変えさせない
    var timer: Timer?
    var currentSeconds = 0
    var second = 0
    var minite = 0
    var hour = 0
//    var soundID1: SystemSoundID = AppDelegate.soundID
    
    
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        picker.isHidden = false
        hStr.isHidden = false
        mStr.isHidden = false
        sStr.isHidden = false
        
        currentSeconds = 0

        check = 1
        check1 = 1
        check3 = 0
        label.text = String(format:"%02d:%02d:%02d", hour, minite, second)
        currentSeconds = hour * 3600 + minite * 60 + second
        startButton.setTitle("Start", for: UIControlState.normal)
    }
    
//    
//    @IBAction func stopButtonTapped(_ sender: UIButton) {
//        if check1 == 0 || check1 == 3{
//            check1 = 2
//        startButton.setTitle("Start", for: UIControlState.normal)
//        }
// 
//    }

    @IBOutlet weak var label: UILabel!
    
//    
//    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    @IBAction func startButtonTapped(_ sender: UIButton) { //とりあえず、数え上げはしない


        if check1 == 1 && currentSeconds != 0 {
            check1 = 0
            start()
            check3 = 1
            check = 0
            startButton.setTitle("Stop", for: UIControlState.normal)

        }
        else if check1 == 2 && currentSeconds != 0 {
            start()
            check3 = 1
            check = 0
            startButton.setTitle("Stop", for: UIControlState.normal)
        }
          else if check1 == 0 || check1 == 3{
            
            check1 = 2
            startButton.setTitle("Start", for: UIControlState.normal)
            }
        
    }
    
    func start() {
        picker.isHidden = true
        hStr.isHidden = true
        mStr.isHidden = true
        sStr.isHidden = true
        if check1 != 2 {
            currentSeconds = hour * 3600 + minite * 60 + second
            label.text = String(format:"%02d:%02d:%02d", hour, minite, second)
        }
        else { //stopからここにきている場合、hourとかは減ってないので、減った分の値を代入
            label.text = String(format:"%02d:%02d:%02d", currentSeconds / 3600, (currentSeconds % 3600) / 60, (currentSeconds % 3600) % 60)
            check1 = 3
        }
        print(currentSeconds)
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.update), userInfo: nil, repeats: true);
    }
    
    
    
    func update() {
        if currentSeconds == 0 {
            timer?.invalidate()
            if check == 0 {
                
                AudioServicesPlayAlertSound(SystemSoundID(appDelegate.soundID!))
                startButton.setTitle("Start", for: UIControlState.normal)
                picker.isHidden = false
                check3 = 0
                label.text = String(format:"%02d:%02d:%02d",hour, minite, second)
                check1 = 1
                currentSeconds = hour * 3600 + minite * 60 + second
            }
            check = 0
            check1 = 1
        }
        else if check1 == 1 || check1 == 2  {
        }
            
        else {
            currentSeconds -= 1
            label.text = String(format:"%02d:%02d:%02d", currentSeconds / 3600, (currentSeconds % 3600) / 60, (currentSeconds % 3600) % 60)
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
        label.text = String(format:"%02d:%02d:%02d", hour, minite, second)
        }
    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    func createDate (from: Int,to :Int) -> [String]{
        var data = [String]()
        for num in from...to {
            data.append(String(num))
        }
        return data
    }

//    // 表示/非表示を切り替え
//    func changeVisible(visible: Bool) {
//        if visible {
//            .hidden = false
//        } else {
//            label.hidden = true
//        }
//    }
    
    func setLabel() {
        
    }
    
}
