//
//  MenuViewController.swift
//  ResearchSideMenu
//
//  Created by mothule on 2016/09/18.
//  Copyright © 2016年 mothule. All rights reserved.
//

import Foundation
import UIKit

class MenuViewController : UIViewController {
    @IBAction func onTouchCloseButton(_ sender: UIButton) {
        guard let rootViewController = rootViewController() else {return }
        rootViewController.dismissMenuViewController()
    }
    
    @IBAction func onTouchContentButton(_ sender: UIButton) {
        guard let rootViewController = rootViewController() else {return }
        rootViewController.dismissMenuViewController()
        
        let profileViewController = self.storyboard!.instantiateViewController(withIdentifier: "content")
        rootViewController.set(contentViewController: profileViewController)
    }
    
}

