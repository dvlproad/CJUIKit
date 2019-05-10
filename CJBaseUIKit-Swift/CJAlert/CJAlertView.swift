//
//  CJAlertView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/3/11.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

import UIKit
import CoreText
import SnapKit

class CJAlertView: UIView {
    private var _flagImageViewHeight: CGFloat = 0.0
    private var _titleLabelHeight: CGFloat = 0.0
    private var _messageLabelHeight: CGFloat = 0.0
    private var _bottomPartHeight: CGFloat = 0.0  //底部区域高度(包含底部按钮及可能的按钮上部的分隔线及按钮下部与边缘的距离)
    
    private(set) var size: CGSize = CGSize.zero
    
    
    //第一个视图(一般为flagImageView，如果flagImageView不存在，则为下一个即titleLabel，以此类推)与顶部的间隔
    private(set) var firstVerticalInterval: CGFloat = 0
    
    //第二个视图与第一个视图的间隔
    private(set) var secondVerticalInterval: CGFloat = 0
    
    //第三个视图与第二个视图的间隔
    private(set) var thirdVerticalInterval: CGFloat = 0
    
    //底部buttons视图与其上面的视图的最小间隔(上面的视图一般为message；如果不存在message,则是title；如果再不存在，则是flagImage)
    private(set) var bottomMinVerticalInterval: CGFloat = 0
    
    var flagImageView: UIImageView?
    var titleLabel: UILabel?
    
    var messageScrollView: UIScrollView?
    var messageContainerView: UIView?
    var messageLabel: UILabel?
    
    var cancelButton: UIButton?
    var okButton: UIButton?
    
    var cancelHandle: (()->())?
    var okHandle: (()->())?
    
    // MARK: - ClassMethod
    class func alertViewWithSize(size: CGSize,
                                 flagImage: UIImage!,
                                 title: String,
                                 message: String,
                                 cancelButtonTitle: String,
                                 okButtonTitle: String,
                                 cancelHandle:(()->())?,
                                 okHandle: (()->())?) -> CJAlertView
    {
        //①创建
        let alertView: CJAlertView = CJAlertView.init(size: size, firstVerticalInterval: 15, secondVerticalInterval: 10, thirdVerticalInterval: 10, bottomMinVerticalInterval: 10)
    
        //②添加 flagImage、titleLabel、messageLabel
        //[alertView setupFlagImage:flagImage title:title message:message configure:configure]; //已拆解成以下几个方法
        if flagImage != nil {
            alertView.addFlagImage(flagImage, CGSize(width: 38, height: 38))
        }
        if title.count > 0 {
            alertView.addTitleWithText(title, font: UIFont.systemFont(ofSize: 18.0), textAlignment: .center, margin: 20, paragraphStyle: nil)
        }
        if message.count > 0 {
            let paragraphStyle: NSMutableParagraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
            paragraphStyle.lineBreakMode = .byCharWrapping
            paragraphStyle.lineSpacing = 4
            alertView.addMessageWithText(message, font: UIFont.systemFont(ofSize: 14.0), textAlignment: .center, margin: 20, paragraphStyle: paragraphStyle)
        }
    
        //③添加 cancelButton、okButton
        alertView.addBottomButtons(actionButtonHeight: 50, cancelButtonTitle: cancelButtonTitle, okButtonTitle: okButtonTitle, cancelHandle: cancelHandle, okHandle: okHandle)
    
        return alertView;
    }

    
    // MARK: - Init
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     *  创建alertView
     *  @brief  这里所说的三个视图范围为：flagImageView(有的话，一定是第一个)、titleLabel(有的话，有可能一或二)、messageLabel(有的话，有可能一或二或三)
     *
     *  @param size                     alertView的大小
     *  @param firstVerticalInterval    第一个视图(一般为flagImageView，如果flagImageView不存在，则为下一个即titleLabel，以此类推)与顶部的间隔
     *  @param secondVerticalInterval   第二个视图与第一个视图的间隔(如果少于两个视图,这个值设为0即可)
     *  @param thirdVerticalInterval    第三个视图与第二个视图的间隔(如果少于三个视图,这个值设为0即可)
     *  @param bottomMinVerticalInterval 底部buttons区域视图与其上面的视图的最小间隔(上面的视图一般为message；如果不存在message,则是title；如果再不存在，则是flagImage)
     *
     *  @return alertView
     */
    init(size: CGSize,
         firstVerticalInterval: CGFloat,
         secondVerticalInterval: CGFloat,
         thirdVerticalInterval: CGFloat,
         bottomMinVerticalInterval: CGFloat)
    {
        super.init(frame: CGRect.zero)

        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 3
        
        self.size = size
        self.firstVerticalInterval = firstVerticalInterval
        self.secondVerticalInterval = secondVerticalInterval
        self.thirdVerticalInterval = thirdVerticalInterval
        self.bottomMinVerticalInterval = bottomMinVerticalInterval
    }
    
    
    /// 添加指示图标
    func addFlagImage(_ flagImage: UIImage, _ imageViewSize: CGSize) {
        if self.flagImageView == nil {
            let flagImageView: UIImageView = UIImageView.init()
            self.addSubview(flagImageView)
            
            self.flagImageView = flagImageView;
        }
        self.flagImageView!.image = flagImage;
        
        self.flagImageView?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self);
            make.width.equalTo(imageViewSize.width);
            make.top.equalTo(self).offset(self.firstVerticalInterval);
            make.height.equalTo(imageViewSize.height);
        })
        _flagImageViewHeight = imageViewSize.height;
        
        if (self.titleLabel != nil) {
            //由于约束部分不一样，使用update会增加一个新约束，又没设置优先级，从而导致约束冲突。而如果用remake的话，又需要重新设置之前已经设置过的，否则容易缺失。所以使用masnory时候，使用优先级比较合适
            self.titleLabel!.snp.updateConstraints({ (make) in
                make.top.equalTo(self.flagImageView!.snp_bottom).offset(self.secondVerticalInterval);
            })
        }
        
        if self.messageScrollView != nil {
            self.messageScrollView!.snp.updateConstraints { (make) in
                if self.titleLabel != nil {
                    make.top.equalTo(self.titleLabel!.snp_bottom).offset(self.thirdVerticalInterval);
                } else {
                    make.top.greaterThanOrEqualTo(self.flagImageView!.snp_bottom).offset(self.secondVerticalInterval);
                }
            }
        }
    }
    
    
    // MARK: - AddView
    ///添加title
    func addTitleWithText(_ text: String? = "",
                          font: UIFont,
                          textAlignment: NSTextAlignment,
                          margin titleLabelLeftOffset: CGFloat,
                          paragraphStyle: NSMutableParagraphStyle?)
    {
        if self.size.equalTo(CGSize.zero) {
            return
        }
        if self.titleLabel == nil {
            let titleLabel: UILabel = UILabel(frame: CGRect.zero)
            //titleLabel.backgroundColor = [UIColor purpleColor];
            titleLabel.numberOfLines = 0
            titleLabel.textAlignment = .center
            titleLabel.textColor = UIColor.black
            self.addSubview(titleLabel)
            self.titleLabel = titleLabel
        }
//        if text == nil {
//            text = ""
//            //若为nil,则设置[[NSMutableAttributedString alloc] initWithString:labelText]的时候会崩溃
//        }
        let titleLabelMaxWidth: CGFloat = self.size.width-2*titleLabelLeftOffset
        let titleLabelMaxSize: CGSize = CGSize(width: titleLabelMaxWidth, height: CGFloat.greatestFiniteMagnitude)
        let titleTextSize: CGSize = CJAlertView.getTextSize(from: text!, with: font, maxSize: titleLabelMaxSize, lineBreakMode: .byCharWrapping, paragraphStyle: paragraphStyle)
        
        var titleTextHeight: CGFloat = titleTextSize.height
        let lineStringArray: [NSString] = CJAlertView.getLineStringArray(labelText: text!, font: font, maxTextWidth: titleLabelMaxWidth)
        let lineCount: NSInteger = lineStringArray.count
        var lineSpacing: CGFloat = paragraphStyle?.lineSpacing ?? 0
        if lineSpacing == 0 {
            lineSpacing = 2
        }
        titleTextHeight += CGFloat(lineCount)*lineSpacing
        if paragraphStyle == nil {
            self.titleLabel!.text = text
        } else {
            let attributes: [NSAttributedString.Key : Any] = [
                NSAttributedString.Key.paragraphStyle: paragraphStyle!,
                NSAttributedString.Key.font: font,
                //NSAttributedString.Key.foregroundColor: textColor,
                //NSAttributedString.Key.kern: 1.5f //字体间距
            ]
            
            let attributedText: NSMutableAttributedString = NSMutableAttributedString(string: text!)
            attributedText.addAttributes(attributes, range: NSMakeRange(0, text!.count))
            //[attributedText addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, text.length)];
            self.titleLabel!.attributedText = attributedText

        }
        self.titleLabel!.font = font
        self.titleLabel!.textAlignment = textAlignment
        self.titleLabel!.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self);
            make.left.equalTo(self).offset(titleLabelLeftOffset);
            if self.flagImageView != nil {
                make.top.equalTo(self.flagImageView!.snp_bottom).offset(self.secondVerticalInterval);
            } else {
                make.top.greaterThanOrEqualTo(self).offset(self.firstVerticalInterval);//优先级
            }
            make.height.equalTo(titleTextHeight);
        })
        _titleLabelHeight = titleTextHeight
        if self.messageScrollView != nil {
            self.messageScrollView?.snp.updateConstraints({ (make) in
                if self.flagImageView != nil {
                    make.top.equalTo(self.titleLabel!.snp_bottom).offset(self.thirdVerticalInterval);
                } else {
                    make.top.equalTo(self.titleLabel!.snp_bottom).offset(self.secondVerticalInterval);
                }
            })
        }

    }

    
    
    // MARK: - Private
    //以下获取textSize方法取自NSString+CJTextSize
    class func getTextSize(from string: String, with font: UIFont, maxSize: CGSize, lineBreakMode: NSLineBreakMode, paragraphStyle: NSMutableParagraphStyle?) -> CGSize {
        var paragraphStyle = paragraphStyle
        if (string.count == 0) {
            return CGSize.zero
        }
        
        
        if paragraphStyle == nil {
            paragraphStyle = NSParagraphStyle.default as? NSMutableParagraphStyle
            paragraphStyle?.lineBreakMode = lineBreakMode
        }
        let attributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle!,
            NSAttributedString.Key.font: font
        ]
        let options: NSStringDrawingOptions = .usesLineFragmentOrigin
        
        let textRect: CGRect = string.boundingRect(with: maxSize, options: options, attributes: attributes, context: nil)
        let size: CGSize = textRect.size
        return CGSize(width: ceil(size.width), height: ceil(size.height))
    }
    
    ///获取每行的字符串组成的数组
    class func getLineStringArray(labelText: String, font: UIFont, maxTextWidth: CGFloat) -> [NSString] {
        //convert UIFont to a CTFont
        let fontName: CFString = font.fontName as CFString
        let fontSize: CGFloat = font.pointSize
        let fontRef: CTFont = CTFontCreateWithName(fontName, fontSize, nil);
        
        let attString: NSMutableAttributedString = NSMutableAttributedString.init(string: labelText)
        attString.addAttribute(kCTFontAttributeName as NSAttributedString.Key, value: fontRef, range: NSMakeRange(0, attString.length))
        
        
        let framesetter: CTFramesetter = CTFramesetterCreateWithAttributedString(attString)
        
        let path: CGMutablePath = CGMutablePath();
        path.addRect(CGRect(x: 0, y: 0, width: maxTextWidth, height: 100000))
        
        let frame: CTFrame  = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, nil)
        let lines: NSArray = CTFrameGetLines(frame)
        
        
        let lineStringArray: NSMutableArray = NSMutableArray.init()
        for line in lines {
            let lineRef: CTLine = line as! CTLine
            let lineRange: CFRange = CTLineGetStringRange(lineRef)
            let range: NSRange = NSRange(location: lineRange.location, length: lineRange.length)
            
            let startIndex = labelText.index(labelText.startIndex, offsetBy: range.location)
            let endIndex = labelText.index(startIndex, offsetBy: range.length)
            
            let lineString: String = String(labelText[startIndex ..< endIndex])

            lineStringArray.add(lineString)
            
        }
        
        return lineStringArray as! [NSString]
    }
    
    
    
    ///添加message的方法(paragraphStyle:当需要设置message行距、缩进等的时候才需要设置，其他设为nil即可)
    func addMessageWithText(_ text: String? = "",
                            font: UIFont,
                            textAlignment: NSTextAlignment,
                            margin messageLabelLeftOffset: CGFloat,
                            paragraphStyle: NSMutableParagraphStyle?)
    {
        //NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
        //paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
        //paragraphStyle.lineSpacing = lineSpacing;
        //paragraphStyle.headIndent = 10;
        
        if self.size.equalTo(CGSize.zero) {
            return
        }
        if self.messageScrollView == nil {
            let scrollView: UIScrollView = UIScrollView()
            //scrollView.backgroundColor = [UIColor redColor];
            self.addSubview(scrollView)
            self.messageScrollView = scrollView
            let containerView: UIView = UIView()
            //containerView.backgroundColor = [UIColor greenColor];
            scrollView.addSubview(containerView)
            self.messageContainerView = containerView
            let messageTextColor: UIColor = UIColor(red: 136/255.0, green: 136/255.0, blue: 136/255.0, alpha: 1)
            //#888888
            let messageLabel: UILabel = UILabel(frame: CGRect.zero)
            messageLabel.numberOfLines = 0
            //UITextView *messageLabel = [[UITextView alloc] initWithFrame:CGRectZero];
            //messageLabel.editable = NO;
            messageLabel.textAlignment = .center
            messageLabel.textColor = messageTextColor
            containerView.addSubview(messageLabel)
            self.messageLabel = messageLabel
        }
        let messageLabelMaxWidth: CGFloat = self.size.width-2*messageLabelLeftOffset
        let messageLabelMaxSize: CGSize = CGSize(width: messageLabelMaxWidth, height: CGFloat.greatestFiniteMagnitude)
        let messageTextSize: CGSize = CJAlertView.getTextSize(from: text!, with: font, maxSize: messageLabelMaxSize, lineBreakMode: .byCharWrapping, paragraphStyle: paragraphStyle)
        
        var messageTextHeight: CGFloat = messageTextSize.height
        let lineStringArray: [NSString] = CJAlertView.getLineStringArray(labelText: text!, font: font, maxTextWidth: messageLabelMaxWidth)
        
        let lineCount: NSInteger = lineStringArray.count
        var lineSpacing: CGFloat = paragraphStyle!.lineSpacing
        if lineSpacing == 0 {
            lineSpacing = 2
        }
        messageTextHeight += CGFloat(lineCount)*lineSpacing

        
        if (paragraphStyle == nil) {
            self.messageLabel!.text = text;
        } else {
            let attributes: [NSAttributedString.Key : Any] = [
                NSAttributedString.Key.paragraphStyle: paragraphStyle!,
                NSAttributedString.Key.font: font,
                //NSAttributedString.Key.foregroundColor: textColor,
                //NSAttributedString.Key.kern: 1.5f //字体间距
            ]
            
            let attributedText: NSMutableAttributedString = NSMutableAttributedString(string: text!)
            attributedText.addAttributes(attributes, range: NSMakeRange(0, text!.count))
            //[attributedText addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, text.length)];
            
            self.messageLabel!.attributedText = attributedText
        }
        
        self.messageLabel!.font = font
        self.messageLabel!.textAlignment = textAlignment
        self.messageScrollView?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self);
            make.left.equalTo(self).offset(messageLabelLeftOffset);
            if (self.titleLabel != nil) {
                if (self.flagImageView != nil) {
                    make.top.equalTo(self.titleLabel!.snp_bottom).offset(self.thirdVerticalInterval);
                } else {
                    make.top.equalTo(self.titleLabel!.snp_bottom).offset(self.secondVerticalInterval);
                }
            } else if (self.flagImageView != nil) {
                make.top.greaterThanOrEqualTo(self.flagImageView!.snp_bottom).offset(self.secondVerticalInterval);//优先级
            } else {
                make.top.greaterThanOrEqualTo(self).offset(self.firstVerticalInterval);//优先级
            }
            
            make.height.equalTo(messageTextHeight);
        })
        
        self.messageContainerView!.snp.makeConstraints({ (make) in
            make.left.right.equalTo(self.messageScrollView!)
            make.top.bottom.equalTo(self.messageScrollView!)
            make.width.equalTo(self.messageScrollView!.snp_width)
            make.height.equalTo(messageTextHeight)
        })
        
        self.messageLabel?.snp.makeConstraints({ (make) in
            make.left.right.equalTo(self.messageContainerView!);
            make.top.equalTo(self.messageContainerView!);
            make.height.equalTo(messageTextHeight);
        })
        _messageLabelHeight = messageTextHeight;
    }
    
    
    
    ///添加 message 的边框等(几乎不会用到)
    func addMessageLayer(borderWidth: CGFloat, borderColor: CGColor?, cornerRadius: CGFloat) {
        assert((self.messageScrollView != nil), "请先添加messageScrollView")
        self.messageScrollView!.layer.borderWidth = borderWidth
        if borderColor != nil {
            self.messageScrollView!.layer.borderColor = borderColor
        }
        self.messageScrollView!.layer.cornerRadius = cornerRadius
    }
    
    
    ///添加底部按钮
    /**
     *  添加底部按钮方法①：按指定布局添加底部按钮
     *
     *  @param bottomButtons        要添加的按钮组合(得在外部额外实现点击后的关闭alert操作)
     *  @param actionButtonHeight   按钮高度
     *  @param bottomInterval       按钮与底部的距离
     *  @param axisType             横排还是竖排
     *  @param fixedSpacing         两个控件间隔
     *  @param leadSpacing          第一个控件与边缘的间隔
     *  @param tailSpacing          最后一个控件与边缘的间隔
     */
    func addBottomButtons(bottomButtons: [UIButton],
                          actionButtonHeight: CGFloat, //withHeight
                          bottomInterval: CGFloat,
                          axisType: MASAxisType,
                          fixedSpacing: CGFloat,
                          leadSpacing: CGFloat,
                          tailSpacing: CGFloat
                          )
    {
        let buttonCount: Int = bottomButtons.count
        if axisType == .horizontal {
            _bottomPartHeight = 0+actionButtonHeight+bottomInterval
        } else {
            _bottomPartHeight = leadSpacing+CGFloat(buttonCount)*(actionButtonHeight+fixedSpacing)-fixedSpacing+tailSpacing
            
        }
        for bottomButton in bottomButtons {
            self.addSubview(bottomButton)
        }
        

        
    
//        if buttonCount > 1 {
//            bottomButtons.snp.makeConstraints { (make) in
//                make?.bottom.equalTo(-bottomInterval)
//                make?.height.equalTo(actionButtonHeight)
//            }
//            bottomButtons.snp.distributeViews(along: axisType, withFixedSpacing: fixedSpacing, leadSpacing: leadSpacing, tailSpacing: tailSpacing)
//        } else {
//            bottomButtons.snp.makeConstraints { (make) in
//                make?.bottom.equalTo(-bottomInterval)
//                make?.height.equalTo(actionButtonHeight)
//                make?.left.equalTo(self).offset(leadSpacing)
//                make?.right.equalTo(self).offset(-tailSpacing)
//            }
//        }
    }
    
    
    
    ///只添加一个按钮
    func addOnlyOneBottomButton(_ bottomButton: UIButton,
                                withHeight actionButtonHeight: CGFloat,
                                bottomInterval: CGFloat,
                                leftOffset: CGFloat,
                                rightOffset: CGFloat)
    {
        _bottomPartHeight = 0 + actionButtonHeight + bottomInterval
    
        self.addSubview(bottomButton)
        bottomButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(-bottomInterval);
            make.height.equalTo(actionButtonHeight);
            make.left.equalTo(self).offset(leftOffset);
            make.right.equalTo(self).offset(-rightOffset);
        }
    }
    
    
    func addBottomButtons(actionButtonHeight: CGFloat,
                          cancelButtonTitle: String,
                          okButtonTitle: String,
                          cancelHandle: (()->())?,
                          okHandle: (()->())?)
    {
        let lineColor: UIColor = UIColor(red: 229/255.0, green: 229/255.0, blue: 229/255.0, alpha: 1)
        //#e5e5e5
        let cancelTitleColor: UIColor = UIColor(red: 136/255.0, green: 136/255.0, blue: 136/255.0, alpha: 1)
        //#888888
        let okTitleColor: UIColor = UIColor(red: 66/255.0, green: 135/255.0, blue: 255/255.0, alpha: 1)
        //#4287ff
        self.cancelHandle = cancelHandle
        self.okHandle = okHandle
        let existCancelButton: Bool = cancelButtonTitle.count > 0
        let existOKButton: Bool = okButtonTitle.count > 0
        if existCancelButton == false && existOKButton == false {
            return
        }
        var cancelButton: UIButton?
        if existCancelButton {
            cancelButton = UIButton(type: .custom)
            cancelButton!.backgroundColor = UIColor.clear
            cancelButton!.setTitle(cancelButtonTitle, for: .normal)
            cancelButton!.setTitleColor(cancelTitleColor, for: .normal)
            cancelButton!.titleLabel!.font = UIFont.systemFont(ofSize: 14)
            cancelButton!.addTarget(self, action: #selector(cancelButtonAction(button:)), for: .touchUpInside)
            self.cancelButton = cancelButton
        }
        var okButton: UIButton?
        if existOKButton {
            okButton = UIButton(type: .custom)
            okButton!.backgroundColor = UIColor.clear
            okButton!.setTitle(okButtonTitle, for: .normal)
            okButton!.setTitleColor(okTitleColor, for: .normal)
            okButton!.titleLabel!.font = UIFont.systemFont(ofSize: 14)
            okButton!.addTarget(self, action: #selector(okButtonAction(button:)), for: .touchUpInside)
            self.okButton = okButton
        }
        let lineView: UIView = UIView()
        lineView.backgroundColor = lineColor
        self.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.bottom.equalTo(self).offset(-actionButtonHeight-1)
            make.height.equalTo(1)
        }
        _bottomPartHeight = actionButtonHeight+1
    
        if (existCancelButton == true && existOKButton == true) {
            self.addSubview(cancelButton!)
            cancelButton!.snp.makeConstraints { (make) in
                make.left.equalTo(self)
                make.width.equalTo(self).multipliedBy(0.5)
                make.bottom.equalTo(self)
                make.height.equalTo(actionButtonHeight)
            }
    
            let actionSeprateLineView: UIView = UIView.init()
            actionSeprateLineView.backgroundColor = lineColor
            self.addSubview(actionSeprateLineView)
            actionSeprateLineView.snp.makeConstraints { (make) in
                make.left.equalTo(cancelButton!.snp_right)
                make.width.equalTo(1)
                make.top.bottom.equalTo(cancelButton!)
            }
    
            self.addSubview(okButton!)
            okButton!.snp.makeConstraints { (make) in
                make.left.equalTo(actionSeprateLineView.snp_right)
                make.right.equalTo(self)
                make.bottom.equalTo(self)
                make.height.equalTo(actionButtonHeight)
            }
            
        } else if (existCancelButton == true) {
            self.addSubview(cancelButton!)
            cancelButton!.snp.makeConstraints { (make) in
                make.left.equalTo(self)
                make.width.equalTo(self).multipliedBy(1)
                make.bottom.equalTo(self)
                make.height.equalTo(actionButtonHeight)
            }
    
        } else if (existOKButton == true) {
            self.addSubview(okButton!)
            okButton!.snp.makeConstraints { (make) in
                make.right.equalTo(self)
                make.width.equalTo(self).multipliedBy(1)
                make.bottom.equalTo(self)
                make.height.equalTo(actionButtonHeight)
            }
        }
    }
    
    
    // MARK: - 文字颜色等Option
    ///更改 Title 文字颜色
    func updateTitleTextColor(_ textColor: UIColor) {
        self.titleLabel?.textColor = textColor
    }
    
    ///更改 Message 文字颜色
    func updateMessageTextColor(_ textColor: UIColor) {
        self.messageLabel?.textColor = textColor
    }
    
    ///更改底部 Cancel 按钮的文字颜色
    func updateCancelButtonTitleColor(normalTitleColor: UIColor, highlightedTitleColor: UIColor) {
        self.cancelButton?.setTitleColor(normalTitleColor, for: .normal)
        self.cancelButton?.setTitleColor(highlightedTitleColor, for: .highlighted)
    }
    
    ///更改底部 OK 按钮的文字颜色
    func updateOKButtonTitleColor(normalTitleColor: UIColor, highlightedTitleColor: UIColor) {
        self.okButton?.setTitleColor(normalTitleColor, for: .normal)
        self.okButton?.setTitleColor(highlightedTitleColor, for: .highlighted)
    }
    
    // MARK: - Event
    /**
     *  显示 alert 弹窗
     *
     *  @param shouldFitHeight  是否需要自动适应高度(否:会以之前指定的size的height来显示)
     *  @param blankBGColor     空白区域的背景颜色
     */
    func showWithShouldFitHeight(_ shouldFitHeight: Bool, blankBGColor: UIColor) {
        self.checkAndUpdateVerticalInterval()

        var fixHeight: CGFloat = 0
        if (shouldFitHeight == true) {
            let minHeight: CGFloat = self.getMinHeight()
            fixHeight = minHeight
        } else {
            fixHeight = self.size.height
        }
        
        self.showWithFixHeight(&fixHeight, blankBGColor: blankBGColor)
    }
    
    /**
     *  显示弹窗并且是以指定高度显示的
     *
     *  @param fixHeight        高度
     *  @param blankBGColor     空白区域的背景颜色
     */
    func showWithFixHeight(_ fixHeight: inout CGFloat, blankBGColor: UIColor) {
        self.checkAndUpdateVerticalInterval()
    
        let minHeight: CGFloat = self.getMinHeight()
        
        if fixHeight < minHeight {
            let warningString: String = String(format: "CJ警告：您设置的size高度小于视图本身的最小高度%.2lf，会导致视图显示不全，请检查", minHeight)
            print("\(warningString)")
        }
        let maxHeight: CGFloat = UIScreen.main.bounds.height-60
        if fixHeight > maxHeight {
            fixHeight = maxHeight
    
            //NSString *warningString = [NSString stringWithFormat:@"CJ警告：您设置的size高度超过视图本身的最大高度%.2lf，会导致视图显示不全，已自动缩小", maxHeight];
            //NSLog(@"%@", warningString);
            if self.messageScrollView != nil {
                let minHeightWithoutMessageLabel: CGFloat = self.firstVerticalInterval + _flagImageViewHeight + self.secondVerticalInterval + _titleLabelHeight + self.thirdVerticalInterval + self.bottomMinVerticalInterval + _bottomPartHeight;
    
                _messageLabelHeight = fixHeight - minHeightWithoutMessageLabel
                self.messageScrollView?.snp.updateConstraints({ (make) in
                    make.height.equalTo(_messageLabelHeight)
                })
            }
    
        }
    
        let popupViewSize: CGSize = CGSize(width: self.size.width, height: fixHeight)
        self.cj_popupInCenterWindow(animationType: .normal, popupViewSize: popupViewSize, blankBGColor: blankBGColor, showPopupViewCompleteBlock: nil, tapBlankViewCompleteBlock: nil)
    }
    
    
    
    ///获取当前alertView最小应有的高度值
    func getMinHeight() -> CGFloat {
        var minHeightWithMessageLabel: CGFloat = self.firstVerticalInterval + _flagImageViewHeight + self.secondVerticalInterval + _titleLabelHeight + self.thirdVerticalInterval + _messageLabelHeight + self.bottomMinVerticalInterval + _bottomPartHeight
        minHeightWithMessageLabel = ceil(minHeightWithMessageLabel);
    
        return minHeightWithMessageLabel;
    }
    
    /**
     *  通过检查位于bottomButtons上view的个数来判断并修正之前设置的VerticalInterval(防止比如有时候只设置两个view，thirdVerticalInterval却不为0)
     *  @brief 问题来源：比如少于三个视图,thirdVerticalInterval却没设为0,此时如果不通过此方法检查并修正，则容易出现高度计算错误的问题
     */
    func checkAndUpdateVerticalInterval() {
        var upViewCount: Int = 0
        if self.flagImageView != nil {
            upViewCount += 1
        }
        if self.titleLabel != nil {
            upViewCount += 1
        }
        if self.messageScrollView != nil {
            upViewCount += 1
        }
        if upViewCount == 2 {
            self.thirdVerticalInterval = 0
        } else if upViewCount == 1 {
            self.secondVerticalInterval = 0
        }
    }
    

    
    
    // MARK: - Private
    @objc func cancelButtonAction(button: UIButton) {
        self.dismiss(0)
        
        self.cancelHandle?()
    }
    
    @objc func okButtonAction(button: UIButton) {
        self.dismiss(0)
        
        self.okHandle?()
    }
    
    func dismiss(_ delay: CGFloat) {
        let time = DispatchTime.now() + 1.5
        DispatchQueue.main.asyncAfter(deadline: time) {
            self.cj_hidePopupView(.normal)
        }
    }
}


//
//@implementation CJAlertView
//
//
//
//
///* //已拆解成以下几个方法
//- (void)setupFlagImage:(UIImage *)flagImage
//                 title:(NSString *)title
//               message:(NSString *)message
//{
//    if (CGSizeEqualToSize(self.size, CGSizeZero)) {
//        return;
//    }
//
//    UIColor *messageTextColor = [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1]; //#888888
//
//
//    if (flagImage) {
//        UIImageView *flagImageView = [[UIImageView alloc] init];
//        flagImageView.image = flagImage;
//        [self addSubview:flagImageView];
//        [flagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(self);
//            make.width.equalTo(38);
//            make.top.equalTo(self).offset(25);
//            make.height.equalTo(38);
//        }];
//        _flagImageView = flagImageView;
//    }
//
//
//    // titleLabel
//    CGFloat titleLabelLeftOffset = 20;
//    UIFont *titleLabelFont = [UIFont systemFontOfSize:18.0];
//    CGFloat titleLabelMaxWidth = self.size.width - 2*titleLabelLeftOffset;
//    CGSize titleLabelMaxSize = CGSizeMake(titleLabelMaxWidth, CGFLOAT_MAX);
//    CGSize titleTextSize = [CJAlertView getTextSizeFromString:title withFont:titleLabelFont maxSize:titleLabelMaxSize mode:NSLineBreakByCharWrapping];
//    CGFloat titleTextHeight = titleTextSize.height;
//
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//    //titleLabel.backgroundColor = [UIColor clearColor];
//    titleLabel.numberOfLines = 0;
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.font = titleLabelFont;
//    titleLabel.textColor = [UIColor blackColor];
//    titleLabel.text = title;
//    [self addSubview:titleLabel];
//    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self);
//        make.left.equalTo(self).offset(titleLabelLeftOffset);
//        if (self.flagImageView) {
//            make.top.equalTo(self.flagImageView.mas_bottom).offset(10);
//        } else {
//            make.top.equalTo(self).offset(25);
//        }
//        make.height.equalTo(titleTextHeight);
//    }];
//    _titleLabel = titleLabel;
//
//
//    // messageLabel
//    CGFloat messageLabelLeftOffset = 20;
//    UIFont *messageLabelFont = [UIFont systemFontOfSize:15.0];
//    CGFloat messageLabelMaxWidth = self.size.width - 2*messageLabelLeftOffset;
//    CGSize messageLabelMaxSize = CGSizeMake(messageLabelMaxWidth, CGFLOAT_MAX);
//    CGSize messageTextSize = [CJAlertView getTextSizeFromString:message withFont:messageLabelFont maxSize:messageLabelMaxSize mode:NSLineBreakByCharWrapping];
//    CGFloat messageTextHeight = messageTextSize.height;
//
//    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//    //messageLabel.backgroundColor = [UIColor clearColor];
//    messageLabel.numberOfLines = 0;
//    messageLabel.textAlignment = NSTextAlignmentCenter;
//    messageLabel.font = messageLabelFont;
//    messageLabel.textColor = messageTextColor;
//    messageLabel.text = message;
//    [self addSubview:messageLabel];
//    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self);
//        make.left.equalTo(self).offset(messageLabelLeftOffset);
//        make.top.equalTo(titleLabel.mas_bottom).offset(10);
//        make.height.equalTo(messageTextHeight);
//    }];
//    _messageLabel = messageLabel;
//}
//*/
//





//
//
//@end
