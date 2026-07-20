//
//  View+asUIKit.swift
//  CJUIKitDemo
//
//  Created by ciyouzen on 2024/8/9.
//  Copyright © 2024 dvlproad. All rights reserved.
//
// ============================================================
// 核心扩展：让所有 SwiftUI View 都可以转成 UIKit
// ============================================================

import SwiftUI
import UIKit

// MARK: - SwiftUI View 扩展（转换为 UIView）
@available(iOS 13.0, *)
extension View {
    /// 转换为 UIView（其实是将其包装在一个新建的 UIView 中）
    public func asUIKit() -> UIView {
        return embedInUIView()
    }
    
    /// 将 SwiftUI View 包装在一个新建的 UIView 中（自动填满）
    func embedInUIView() -> UIView {
        let view = UIView()
        view.addFillingSwiftUISubview(self)
        return view
    }
}

@available(iOS 13.0, *)
extension UIView {
    // 创建UIView，并添加 SwiftUI View 作为其子视图
    convenience init<TContent: View>(swiftUI content: TContent) {
        self.init(frame: .zero)
        self.addFillingSwiftUISubview(content)
    }
}






// MARK: - 使用示例
@available(iOS 13.0, *)
class MyContainerViewController: UIViewController {
    
    // MARK: - 容器视图（使用更清晰的命名）
    private let container1: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let container2: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let container3: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let container4: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // 添加所有容器
        [container1, container2, container3, container4].forEach {
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            // Container 1 - 顶部
            container1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            container1.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            container1.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            container1.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/4),
            
            // Container 2 - 第二行
            container2.topAnchor.constraint(equalTo: container1.bottomAnchor),
            container2.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            container2.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            container2.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/4),
            
            // Container 3 - 第三行
            container3.topAnchor.constraint(equalTo: container2.bottomAnchor),
            container3.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            container3.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            container3.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/4),
            
            // Container 4 - 底部
            container4.topAnchor.constraint(equalTo: container3.bottomAnchor),
            container4.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            container4.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            container4.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        // 添加 SwiftUI 内容到各个容器
        setupSwiftUIContent()
    }
    
    // MARK: - 配置 SwiftUI 内容
    private func setupSwiftUIContent() {
        // 直接创建方式1：直接创建
        let view11 = MySwiftUIView(
            title: "View",
            subTitle: "let uiview = MySwiftUIView().asUIKit()"
        )
            .asUIKit()
        container1.addFillingUIKitSubview(view11)
        
        let view12 = MySwiftUIView(
            title: "View",
            subTitle: "let uiview = MySwiftUIView().embedInUIView()"
        )
            .embedInUIView()
        container2.addFillingUIKitSubview(view12)
        
        
        // 直接创建方式2：直接创建
        let view1 = UIView(swiftUI: MySwiftUIView(
            title: "UIView",
            subTitle: "let uiview = UIView(swiftUI: MySwiftUIView())"
        ))
        container3.addFillingUIKitSubview(view1)
        
        // 直接添加到父视图：更简洁（直接添加到父视图）
        container4.addFillingSwiftUISubview(
            MySwiftUIView(
                title: "UIView",
                subTitle: "self.view.addFillingSwiftUISubview(\nMySwiftUIView()\n)"
            )
        )
    }
}


// ✅ iOS 17+ 预览
#if DEBUG
@available(iOS 17.0, *)
#Preview {
    MyContainerViewController()
}
#endif
