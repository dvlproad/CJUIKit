//
//  CJLabel.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/12/23.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

import UIKit
class CJLabel: UILabel {
    //var insets: UIEdgeInsets?
    var insets: UIEdgeInsets = .zero

    override func drawText(in rect: CGRect) {
        return super.drawText(in: rect.inset(by: insets))
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    - (void)drawRect:(CGRect)rect {
        // Drawing code
    }
    */
}
