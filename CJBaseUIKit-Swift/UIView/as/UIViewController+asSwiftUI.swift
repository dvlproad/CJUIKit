//
//  UIViewController+asSwiftUI.swift
//  CJUIKitDemo
//
//  Created by ciyouzen on 2024/8/9.
//  Copyright © 2024 dvlproad. All rights reserved.
//
// ============================================================
// 核心扩展：让所有 UIKit 的 UIViewController 都可以转成 SwiftUI View
// ============================================================

import UIKit
import SwiftUI

// MARK: - UIViewController 扩展：转换为 SwiftUI View
@available(iOS 13.0, *)
extension UIViewController {
    /// 将 UIViewController 转换为 SwiftUI View，并支持动态更新
    public func asSwiftUI(
        update: @escaping (UIViewController) -> Void = { _ in }
    ) -> some View {
        UIViewControllerCJRepresentable(
            makeViewController: { self },
            updateViewController: { viewController, _ in
                update(viewController)
            }
        )
    }
}

// MARK: - 通用的 UIViewControllerRepresentable 包装器
struct UIViewControllerCJRepresentable<ViewControllerType: UIViewController>: UIViewControllerRepresentable {
    let makeViewController: () -> ViewControllerType
    let updateViewController: (ViewControllerType, Context) -> Void
    
    init(
        makeViewController: @escaping () -> ViewControllerType,
        updateViewController: @escaping (ViewControllerType, Context) -> Void = { _, _ in }
    ) {
        self.makeViewController = makeViewController
        self.updateViewController = updateViewController
    }
    
    func makeUIViewController(context: Context) -> ViewControllerType {
        return makeViewController()
    }
    
    func updateUIViewController(_ uiViewController: ViewControllerType, context: Context) {
        updateViewController(uiViewController, context)
    }
}









// MARK: - 使用示例
@available(iOS 13.0, *)
struct TSUIViewControllerAsSwiftUIView: View {
    
    
    var body: some View {
        let viewController = UIViewController.init()
        
        VStack(spacing: 0) {
            // Container 1 - 使用 asUIKit()
            Text("UIViewController.init().asSwiftUI()")
                .font(.system(size: 26.0))
                .foregroundColor(.white)
                .overlay(
                    
                    UIViewController.init()
                    .asSwiftUI()
                )
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
                .background(Color.red)
            
            // Container 2 - 使用 embedInUIView()
            Color.orange
                .frame(height: UIScreen.main.bounds.height / 2)
        }
    }
}


// MARK: - Preview
@available(iOS 13.0, *)
#Preview {
    TSUIViewControllerAsSwiftUIView()
}
