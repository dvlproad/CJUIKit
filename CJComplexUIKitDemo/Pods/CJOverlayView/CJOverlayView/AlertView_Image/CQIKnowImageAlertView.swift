//
//  CardImproveAlertView.swift
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//
//  含图片的alert视图(按钮只有一个，图片在中间)

import Foundation
import UIKit
import SnapKit

public class CQIKnowImageAlertView: UIView {
    fileprivate var titleLable: UILabel?
    fileprivate var desLabel: UILabel?
    fileprivate var flagImageView: UIImageView?
    fileprivate var improveButton1: UIButton?
    @objc fileprivate var IKnowClickBlock: ((_ bAlertView: CQIKnowImageAlertView)->())?
    
    public init(frame: CGRect, title: String, desText: String, image: UIImage, iknowTitle: String, iknowClickBlock: ((_ bAlertView: CQIKnowImageAlertView)->())?) {
        super.init(frame: frame)
        
        self.setupViews()
        self.titleLable?.text = title
        self.updateDesText(desText: desText)
        self.flagImageView?.image = image
        self.improveButton1?.setTitle(iknowTitle, for: .normal)
        self.IKnowClickBlock = iknowClickBlock
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func updateDesText(desText: String) -> Void {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.1
        paragraphStyle.alignment = .center
        self.desLabel?.attributedText = NSMutableAttributedString(string: desText, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    func setupViews() -> Void {
        self.backgroundColor = UIColor.white
        
        self.layer.cornerRadius = 30
        self.layer.masksToBounds = true
        
        let titleLable: UILabel = UILabel()
        titleLable.textColor = UIColor.init(red: 12/255.0, green: 16/255.0, blue: 27/255.0, alpha: 1.0) //0C101B
        titleLable.font = UIFont(name: "PingFangSC-Semibold", size: 18)
        titleLable.textAlignment = .center
        titleLable.text = "完善资料"
        self.addSubview(titleLable)
        titleLable.snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalToSuperview().offset(44)
            make.height.equalTo(24)
        }
        self.titleLable = titleLable
        
        let desLabel: UILabel = UILabel()
        desLabel.textColor = UIColor.init(red: 102/255.0, green: 104/255.0, blue: 118/255.0, alpha: 1.0) //6D6F76
        desLabel.font = UIFont(name: "PingFangSC-Regular", size: 12)
        desLabel.numberOfLines = 0
        desLabel.lineBreakMode = .byWordWrapping
        self.addSubview(desLabel)
        desLabel.snp_makeConstraints { (make) in
            make.top.equalTo(titleLable.snp_bottom).offset(10)
            make.left.equalTo(self).offset(34)
            make.centerX.equalTo(self)
            make.height.equalTo(38) // 36的高度不够显示两行，改成38
        }
        self.desLabel = desLabel
        
        let emptyImageView: UIImageView = UIImageView.init()
        emptyImageView.image = UIImage.init(named: "pic_guide_improve")
        self.addSubview(emptyImageView)
        emptyImageView.snp_makeConstraints { (make) in
            make.top.equalTo(desLabel.snp_bottom).offset(10)
            make.width.height.equalTo(160)
            make.centerX.equalTo(titleLable)
        }
        self.flagImageView = emptyImageView
        
        let improveButton1: UIButton = self.improveButton()
        improveButton1.addTarget(self, action: #selector(imporveInfo1), for: .touchUpInside)
        improveButton1.setTitle("去完善", for: .normal)
        self.addSubview(improveButton1)
        improveButton1.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(34)
            make.centerX.equalTo(self)
            make.top.equalTo(emptyImageView.snp_bottom).offset(10)
            make.height.equalTo(44)
        }
        self.improveButton1 = improveButton1
    }
    
    func improveButton() -> UIButton {
        let improveButton: UIButton = UIButton.init(type: .custom)
        improveButton.backgroundColor = UIColor.init(red: 12/255.0, green: 16/255.0, blue: 27/255.0, alpha: 1.0) //0C101B
        improveButton.layer.cornerRadius = 22
        improveButton.layer.masksToBounds = true
        improveButton.titleLabel?.font = UIFont(name: "PingFangSC-Semibold", size: 16)
        
        let enableColor = UIColor.init(white: 1, alpha: 1)
        improveButton.setTitleColor(enableColor, for: .normal)
        
        let disableColor = UIColor(red: 0.427, green: 0.435, blue: 0.463, alpha: 1)
        improveButton.setTitleColor(disableColor, for: .disabled)
        
        return improveButton
    }
    
    @objc func imporveInfo1() -> Void {
        self.IKnowClickBlock?(self)
    }
    
    public class func viewHeight() -> CGFloat {
        return 374
    }
}
