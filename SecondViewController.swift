//
//  SecondViewController.swift
//  GGG
//
//  Created by s15ti050 on 2017/09/10.
//  Copyright © 2017年 s15ti050. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
print("aaa")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    var timer: Timer?
    var currentSeconds = 0.0
    
    var countnow = false
    
//    print("aaa")
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        if !countnow {
            startButton.setTitle("STOP", for: UIControlState.normal)
            countnow = true
            start()
        }
        else {
            startButton.setTitle("START", for: UIControlState.normal)
            stop()
        }
    }
    
    func update() {
        if countnow {
            currentSeconds += 0.01
            
            Label.text = "\(String(format: "%02d:%02d:%02d",Int(currentSeconds) / 60 ,Int(currentSeconds) % 60, Int(currentSeconds * 100) % 100))"
            }
        }
    
    func start() {
                timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(SecondViewController.update), userInfo: nil, repeats: true);
        
    }
    
    func stop() {
        countnow = false
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
    countnow = false
        currentSeconds = 0.0
        Label.text = "\(String(format: "%02d:%02d:%02d",Int(currentSeconds) / 60 ,Int(currentSeconds) % 60, Int(currentSeconds * 100) % 100))"
        startButton.setTitle("START", for: UIControlState.normal)
    }
    
    /*
     @IBOutlet weak var resr: UIButton!
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
