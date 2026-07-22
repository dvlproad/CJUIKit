//
//  CJSwiftUIAsUIViewController.swift
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
open class CJSwiftUIAsUIViewController: UIViewController {
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 默认初始化方式，接受一个视图类型
    private var swiftUIView: AnyView
    public init<Content: View>(swiftUIView: Content) {
        self.swiftUIView = AnyView(swiftUIView)
        super.init(nibName: nil, bundle: nil)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 105/255.0, green: 193/255.0, blue: 243/255.0, alpha: 1)

        // 创建 SwiftUI 视图，并用 UIHostingController 来包装 SwiftUI 视图
        let hostingController = UIHostingController(rootView: swiftUIView)

        // 添加到当前视图控制器的视图中，并设置 Auto Layout 约束
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            hostingController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])

        // 完成添加子视图控制器
        hostingController.didMove(toParent: self)
    }
}
