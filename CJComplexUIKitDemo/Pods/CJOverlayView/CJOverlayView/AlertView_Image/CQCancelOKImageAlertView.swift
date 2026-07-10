//
//  CQCancelOKImageAlertView.swift
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//
//  含图片的alert视图(按钮有两个，图片在中间)

import Foundation
import UIKit
import SnapKit
import CJContainer
// 因为引入的CJContainer 不是Swift库，所以你所在的工程的Podfile，至少单独需要 pod 'CJContainer', :modular_headers => true，或者全局设置#use_frameworks! 或 use_modular_headers! 的一种

public class CQCancelOKImageAlertView: UIView {
    fileprivate var imageLabelView: CQHorizontalImageLabelView?
    fileprivate var desLabel: UILabel?
    fileprivate var emptyImageView: UIImageView?
    fileprivate var okButton: UIButton?
    fileprivate var cancelButton: UIButton?
    @objc var okBlock: ((_ bAlertView: CQCancelOKImageAlertView)->())?
    @objc var cancelBlock: ((_ bAlertView: CQCancelOKImageAlertView)->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc public func config(title: String, desText: String, flagImage: UIImage, cancelTitle: String, okTitle: String, cancelHandel: ((_ bAlertView: CQCancelOKImageAlertView)->())?, okHandel: ((_ bAlertView: CQCancelOKImageAlertView)->())?) -> Void {
        self.imageLabelView?.titleLable.text = title
        self.desLabel?.text = desText
            
        self.imageLabelView?.updateAndReconstraintImageView(with: nil)
        self.emptyImageView?.image = flagImage
        self.okButton?.setTitle(okTitle, for: .normal)
        self.cancelButton?.setTitle(cancelTitle, for: .normal)
        self.okBlock = okHandel
        self.cancelBlock = cancelHandel
    }
    
    
    func setupViews() -> Void {
        self.backgroundColor = UIColor.white
        
        self.layer.cornerRadius = 30
        self.layer.masksToBounds = true
        
        let imageLabelView: CQHorizontalImageLabelView = CQHorizontalImageLabelView.init(iconHeight: 22, iconTitleSpacing: 0, contentHorizontalAlignment: UIControl.ContentHorizontalAlignment.center)
        self.addSubview(imageLabelView)
        imageLabelView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(50)
            make.centerX.equalTo(self)
            make.top.equalToSuperview().offset(44)
            make.height.equalTo(24)
        }
        self.imageLabelView = imageLabelView
        
        let titleLable: UILabel = imageLabelView.titleLable
        titleLable.numberOfLines = 0 // 支持多行标题
        let titleColor: UIColor = UIColor.init(red: 12/255.0, green: 16/255.0, blue: 27/255.0, alpha: 1.0) //0C101B
        titleLable.textColor = titleColor
        titleLable.font = UIFont(name: "PingFangSC-Semibold", size: 18)
        titleLable.textAlignment = .center
        titleLable.text = "完善资料"
        
        
        let desLabel: UILabel = UILabel()
        desLabel.textColor = UIColor.init(red: 102/255.0, green: 104/255.0, blue: 118/255.0, alpha: 1.0) //6D6F76
        desLabel.font = UIFont(name: "PingFangSC-Regular", size: 12)
        desLabel.numberOfLines = 0
        desLabel.lineBreakMode = .byWordWrapping
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.1
        paragraphStyle.alignment = .center
        desLabel.attributedText = NSMutableAttributedString(string: "你要先完善资料，这样喜欢对方之后才会被对方看到～", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        self.addSubview(desLabel)
        desLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLable.snp.bottom).offset(10)
            make.left.equalTo(self).offset(34)
            make.centerX.equalTo(self)
            make.height.equalTo(40)
        }
        self.desLabel = desLabel
        
        let emptyImageView: UIImageView = UIImageView.init()
        emptyImageView.image = UIImage.init(named: "pic_guide_improve")
        self.addSubview(emptyImageView)
        emptyImageView.snp.makeConstraints { (make) in
            make.top.equalTo(desLabel.snp.bottom).offset(20)
            make.width.height.equalTo(160)
            make.centerX.equalTo(titleLable)
        }
        self.emptyImageView = emptyImageView
        
        let improveButton1: UIButton = self.improveButton()
        improveButton1.addTarget(self, action: #selector(clickOK), for: .touchUpInside)
        improveButton1.setTitle("马上开启", for: .normal)
        self.addSubview(improveButton1)
        improveButton1.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(34)
            make.centerX.equalTo(self)
            make.top.equalTo(emptyImageView.snp.bottom).offset(10)
            make.height.equalTo(50)
        }
        self.okButton = improveButton1
        
        let improveButton2: UIButton = self.improveButton()
        improveButton2.setTitleColor(titleColor, for: .normal)
        improveButton2.backgroundColor = UIColor.clear
        improveButton2.addTarget(self, action: #selector(clickCancel), for: .touchUpInside)
        improveButton2.setTitle("稍后再说", for: .normal)
        self.addSubview(improveButton2)
        improveButton2.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(34)
            make.centerX.equalTo(self)
            make.top.equalTo(improveButton1.snp.bottom).offset(10)
            make.height.equalTo(50)
        }
        self.cancelButton = improveButton2
    }
    
    func improveButton() -> UIButton {
        let improveButton: UIButton = UIButton.init(type: .custom)
        improveButton.backgroundColor = UIColor.init(red: 12/255.0, green: 16/255.0, blue: 27/255.0, alpha: 1.0) //0C101B
        improveButton.layer.cornerRadius = 25
        improveButton.layer.masksToBounds = true
        
        let enableColor = UIColor.init(white: 1, alpha: 1)
        improveButton.setTitleColor(enableColor, for: .normal)
        
        let disableColor = UIColor(red: 0.427, green: 0.435, blue: 0.463, alpha: 1)
        improveButton.setTitleColor(disableColor, for: .disabled)
        
        return improveButton
    }
    
    @objc func clickOK() -> Void {
        self.okBlock?(self)
    }
    
    @objc func clickCancel() -> Void {
        self.cancelBlock?(self)
    }
    
    class func viewHeight() -> CGFloat {
        return 380
    }
}
