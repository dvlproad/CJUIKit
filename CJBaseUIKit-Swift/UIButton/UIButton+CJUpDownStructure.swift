//
//  UIButton+CJUpDownStructure.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/7/3.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

extension UIButton {
    /**
     *  将图片和文字竖直排放（调用前提：必须保证你的button的size已经确定后才能调用）
     *  @attention  也要保证Button的宽度一定要大于等于图片的宽
     *
     *  @param spacing 图片和文字的间隔为多少
     */
    func cjVerticalImageAndTitle(spacing: CGFloat) {
        let imageSize: CGSize = self.imageView!.frame.size
        var titleSize: CGSize = self.titleLabel!.frame.size
        let text: String = self.titleLabel!.text!
        let font: UIFont = self.titleLabel!.font
        //CGSize textSize = [text sizeWithFont:font];
        let maxSize: CGSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        let attributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: font
        ]
        
        let textRect: CGRect = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        let textSize: CGSize = textRect.size
        let frameWidth: CGFloat = CGFloat(ceilf(Float(textSize.width)))
        let frameHeight: CGFloat = CGFloat(ceilf(Float(textSize.height)))
        let frameSize: CGSize = CGSize(width: frameWidth, height: frameHeight)
        if titleSize.width+0.5 < frameSize.width {
            titleSize.width = frameSize.width
        }
        let totalFrameHeight: CGFloat = (imageSize.height+spacing+titleSize.height)
        self.imageEdgeInsets = UIEdgeInsets(top: -(totalFrameHeight-imageSize.height), left: 0.0, bottom: 0.0, right: -titleSize.width)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: -(totalFrameHeight-titleSize.height), right: 0)
    }
    
    /**
     *  左图片、右文字时候
     *
     *  @param spacing          图片与文字的间隔
     *  @param leftOffset       视图与左边缘的距离
     */
    func cjLeftImageOffset(leftOffset: CGFloat, imageAndTitleSpacing spacing: CGFloat) {
        self.contentHorizontalAlignment = .left
        //水平左对齐
        self.contentVerticalAlignment = .center
        //垂直居中对齐
        /**
         * 按照上面的操作 按钮的内容对津贴屏幕左边缘 不美观 可以添加一下代码实现间隔已达到美观
         * UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
         *    top: 为正数：表示向下偏移  为负数：表示向上偏移
         *   left: 为整数：表示向右偏移  为负数：表示向左偏移
         * bottom: 为整数：表示向上偏移  为负数：表示向下偏移
         *  right: 为整数：表示向左偏移  为负数：表示向右偏移
         *
         **/
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: leftOffset, bottom: 0, right: 0)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: leftOffset+spacing, bottom: 0, right: 0)

    }    
}
