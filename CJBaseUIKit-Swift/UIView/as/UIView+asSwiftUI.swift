//
//  UIView+asSwiftUI.swift
//  CJUIKitDemo
//
//  Created by ciyouzen on 2024/8/9.
//  Copyright © 2024 dvlproad. All rights reserved.
//
// ============================================================
// 核心扩展：让所有 UIKit 的 UIView 都可以转成 SwiftUI View
// ============================================================

import UIKit
import SwiftUI

// MARK: - UIView 扩展：转换为 SwiftUI View
@available(iOS 13.0, *)
extension UIView {
    /// 将 UIView 转换为 SwiftUI View，并支持动态更新
    public func asSwiftUI(
        update: @escaping (UIView) -> Void = { _ in }
    ) -> some View {
        UIViewCJRepresentable(
            makeView: { self },
            updateView: { view, _ in
                update(view)
            }
        )
    }
}

// MARK: - 通用的 UIViewRepresentable 包装器
struct UIViewCJRepresentable<ViewType: UIView>: UIViewRepresentable {
    let makeView: () -> ViewType
    let updateView: (ViewType, Context) -> Void
    
    init(
        makeView: @escaping () -> ViewType,
        updateView: @escaping (ViewType, Context) -> Void = { _, _ in }
    ) {
        self.makeView = makeView
        self.updateView = updateView
    }
    
    func makeUIView(context: Context) -> ViewType {
        return makeView()
    }
    
    func updateUIView(_ uiView: ViewType, context: Context) {
        updateView(uiView, context)
    }
}









// MARK: - 使用示例
@available(iOS 13.0, *)
struct TSUIViewAsSwiftUIView: View {
    var body: some View {
        VStack(spacing: 0) {
            // Container 1 - 使用 asUIKit()
            Color.red
                .overlay(
                    MyUIKitView(
                        title: "View",
                        subTitle: "MyUIKitView().asSwiftUI()"
                    )
                    .asSwiftUI()
                )
                .frame(height: UIScreen.main.bounds.height / 2)
            
            // Container 2 - 使用 embedInUIView()
            Color.orange
                .overlay(
                    MyUIKitView(
                        title: "View",
                        subTitle: "MyUIKitView()\n.asSwiftUI(\n        update: { _ in \n\n         }\n  )"
                    )
                    .asSwiftUI(
                        update: { _ in
                            
                        }
                    )
                )
                .frame(height: UIScreen.main.bounds.height / 2)
        }
    }
}


// MARK: - Preview
@available(iOS 13.0, *)
#Preview {
    TSUIViewAsSwiftUIView()
}
