//
//  CJSwiftUIAsUIView.swift
//  CQDemoKit-Swift
//
//  Created by ciyouzen on 2020/2/14.
//  Copyright © 2020 dvlproad. All rights reserved.
//
//  public 允许类在其他模块中访问，但是不能被继承。如果你希望在其他模块中继承 CJUIKitBaseViewController，你需要将它声明为 open。
//
/*  使用方式：
import CQDemoKit_Swift

@available(iOS 14.0, *)
@objc public class MyUIView: CJSwiftUIAsUIView {
    public init() {
        super.init(swiftUIView: MySwiftUIView())
    }
}

@available(iOS 14.0, *)
@objc public class MyViewController: CJSwiftUIAsUIViewController {
    public init() {
        super.init(swiftUIView: MySwiftUIView())
    }
}
*/
//
/*  不推荐的方式：原因是这么定义的话，外部继承时候需要指定 Content ， 从而因为有泛型，继而继续导致无法转为 @objc 。也就失去了意义
open class CJSwiftUIAsUIViewController<Content: View>: UIViewController {
    private var swiftUIView: Content
    
    // 默认值 MySwiftUIView
    public init(swiftUIView: Content) {
        self.swiftUIView = swiftUIView
        super.init(nibName: nil, bundle: nil)
    }
}
*/

import SwiftUI

// 即使你为本类加了 @objc，在 Objective-C 中也无法直接使用，因为 SwiftUI 的 View 类型无法在 Objective-C 中表示。还有初始化方法中的泛型方法也无法暴露给 Objective-C。
@available(iOS 13.0, *)
open class CJSwiftUIAsUIView: UIView {
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var hostingController: UIViewController?
    // 通过构造器传入外部的 SwiftUI 视图
    public init<Content: View>(swiftUIView: Content) {
        super.init(frame: .zero)
        setupViews(with: swiftUIView)
    }
    
    // 从外部传入的 SwiftUI 视图生成 UIHostingController
    private func setupViews<Content: View>(with swiftUIView: Content) {
        let hostingController = UIHostingController(rootView: swiftUIView)
        self.hostingController = hostingController
        
        // 获取 UIHostingController 的视图并添加到当前视图
        let uiView: UIView = hostingController.view
        self.showUIView(uiView)
    }
    
    // 添加到 UIView，并设置约束
    private func showUIView(_ uiView: UIView) {
        self.addSubview(uiView)
        uiView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            uiView.topAnchor.constraint(equalTo: self.topAnchor),
            uiView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            uiView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            uiView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
