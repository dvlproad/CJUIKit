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
        
        CGSize(width: 100, height: 200)
        ViewController.run()
//        CJToast.shortShowMessage("么", in: self.view, withLabelTextColor: nil, bezelViewColor: nil, hideAfterDelay: 5)
        
        let labelMaxHeight: CGFloat = CGFloat.greatestFiniteMagnitude
        let labelMaxWidth: CGFloat = self.view.frame.width - 4 * 10
        let labelWidth: CGFloat = labelMaxWidth;
        //        var maxSize = CGSize(width: 100.0, height: 200.0)
        CGSize(width: 100, height: 200)
        //        var maxSize = CGSize(width: labelWidth, height: CGFLOAT_MAX)
        
    }
    
    class func run() {
        print("run")
        CGSize(width: 100, height: 200)
    }

}

