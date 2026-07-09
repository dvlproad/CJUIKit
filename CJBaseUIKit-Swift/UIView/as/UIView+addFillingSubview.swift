//
//  UIView+addFillingSubview.swift
//  CJUIKitDemo
//
//  Created by ciyouzen on 2024/8/9.
//  Copyright © 2024 dvlproad. All rights reserved.
//
// ============================================================
// 核心扩展：约束辅助工具（简化Auto Layout代码）
//  @discardableResult 是一个属性修饰符，用于告诉编译器：这个函数的返回值可以被忽略，不需要警告。
// ============================================================

// MARK: 添加 UIKit 子视图
import UIKit
extension UIView {
    /// 添加子视图，并将子视图填满到整个区域
    @discardableResult
    func addFillingUIKitSubview(
        _ view: UIView,
        insets: UIEdgeInsets = .zero
    ) -> UIView {
        addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor, constant: insets.top),
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -insets.bottom),
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left),
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -insets.right)
        ])
        return view
    }
}

// MARK: 添加 SwiftUI 子视图
import SwiftUI
private var cjHostingControllerKey: UInt8 = 0
@available(iOS 13.0, *)
extension UIView {
    /// View 关联的 UIHostingController
    var cj_hostingController: UIHostingController<AnyView>? {
        get { objc_getAssociatedObject(self, &cjHostingControllerKey) as? UIHostingController<AnyView> }
        set { objc_setAssociatedObject(self, &cjHostingControllerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    /// 自身添加 swiftui 作为其子视图
    @discardableResult
    func addFillingSwiftUISubview<TContent: View>(
        _ content: TContent,
        insets: UIEdgeInsets = .zero
    ) -> UIView {
        let hostingController = UIHostingController(rootView: AnyView(content))
        self.cj_hostingController = hostingController
        
        let view: UIView = hostingController.view
        self.addFillingUIKitSubview(view, insets: insets)
        return view
    }
}
