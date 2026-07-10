//
//  AnimationViewContainer.swift
//  UIKit-Overlay-iOS
//
//  Created by dvlproad on 2021/1/6.
//  Copyright © 2021 ciyouzen. All rights reserved.
//

import Foundation
import UIKit
import Lottie

public class AnimationViewContainer: UIView {
    
    var animationView: LottieAnimationView?

    
    fileprivate var _animationProgress: CGFloat = 0
    @objc public var animationProgress: CGFloat {
        get {
            return _animationProgress
        }
        set {
            _animationProgress = newValue
            
            self.animationView?.play(toProgress: animationProgress)
        }
    }
    
    @objc func updateAnimationProgress(animationProgress: CGFloat) -> Void {
        self.animationView?.play(toProgress: animationProgress)
    }
    
    @objc public func forceDrawingUpdate() -> Void {
        self.animationView?.forceDisplayUpdate()
    }
    
    @objc public func play() -> Void {
        self.animationView?.play(completion: nil)
    }
    
    @objc public func stop() -> Void {
        self.animationView?.stop()
    }
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupViews()
        
        self.animationView?.frame = frame
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() -> Void {
        let animationView:LottieAnimationView = LottieAnimationView()
        addSubview(animationView)
        self.animationView = animationView
    }
    
  
    public override var frame: CGRect {
        didSet {
            animationView?.frame = frame;
            super.frame = frame
        }
    }
    
    @objc open func configAnimation(name: String,
                                    bundle: Bundle = Bundle.main,
                                    subdirectory: String? = nil) {
        let animation = LottieAnimation.named(name, bundle: bundle, subdirectory: subdirectory)
        self.animationView?.animation = animation
    }
}
