//
//  ViewController.swift
//  CJUIKitSwiftDemo
//
//  Created by 李超前 on 2019/4/27.
//  Copyright © 2019 dvlproad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        CJToast.shortShowMessage("么", in: self.view, withLabelTextColor: nil, bezelViewColor: nil, hideAfterDelay: 5)
    }


}

