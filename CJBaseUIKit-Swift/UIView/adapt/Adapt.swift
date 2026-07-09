//
//  Adapt.swift
//  CJUIKitDemo
//
//  Created by qian on 2020/12/15.
//  Copyright © 2020年 dvlproad. All rights reserved.
//

import UIKit

// MARK: Width
public extension CGFloat {
    var cj_width: CGFloat {
        return UIScreen.main.bounds.width / 375 * self
    }
}

public extension Int {
    var cj_width: CGFloat {
        return UIScreen.main.bounds.width / 375 * CGFloat(self)
    }
}



// MARK: Font
public extension CGFloat {
    /// 根据屏幕高度自适应字体（基于 834pt 设计稿）
    var cj_font: CGFloat {
        return (self / 834.0) * UIScreen.main.bounds.height
    }
}

public extension Int {
    var cj_font: CGFloat {
        return CGFloat(self).cj_font
    }
}
