//
//  MenuViewController.swift
//  GGG
//
//  Created by s15ti050 on 2017/09/09.
//  Copyright © 2017年 s15ti050. All rights reserved.
//

//

import Foundation
import UIKit
import AudioToolbox

class MenuViewController : UIViewController {
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
 
    @IBAction func onTouchCloseButton(_ sender: UIButton) {
        guard let rootViewController = rootViewController() else {return }
        rootViewController.dismissMenuViewController()
    }
   
    @IBAction func onTouchContentButton(_ sender: UIButton) {
        guard let rootViewController = rootViewController() else {return }
       rootViewController.dismissMenuViewController()
        
        let profileViewController = self.storyboard!.instantiateViewController(withIdentifier: "content")
        rootViewController.set(ViewController: profileViewController)
    }
    
    
    
    @IBAction func soundButton1(_ sender: UIButton) {
        appDelegate.soundID = 1005
        AudioServicesPlayAlertSound(SystemSoundID(appDelegate.soundID!))
    }
    
    @IBAction func soundButton2(_ sender: UIButton) {
        appDelegate.soundID = 1006
        AudioServicesPlayAlertSound(SystemSoundID(appDelegate.soundID!))        
    }
    
    
    @IBAction func soundButton3(_ sender: UIButton) {
        appDelegate.soundID = 1007
        AudioServicesPlayAlertSound(SystemSoundID(appDelegate.soundID!))
    }
    
    
    @IBAction func soundButton4(_ sender: UIButton) {
        appDelegate.soundID = 1008
        AudioServicesPlayAlertSound(SystemSoundID(appDelegate.soundID!))
    }
}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


