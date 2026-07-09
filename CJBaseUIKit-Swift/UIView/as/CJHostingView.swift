//
//  CJHostingView.swift
//  CJUIKitDemo
//
//  Created by qian on 2025/1/14.
//  Copyright © 2025 dvlproad. All rights reserved.
//

import UIKit
import SwiftUI

@available(iOS 13.0, *)
public class CJHostingView<Content: View>: UIView {
    private var hostingController: UIHostingController<Content>?

    override public init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    /// 配置 SwiftUI View 并添加到 Cell 中
    public func configure(with content: Content) {
        // 移除之前的 HostingController
        hostingController?.view.removeFromSuperview()

        // 创建新的 HostingController
        let hostingController = UIHostingController(rootView: content)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false

        // 添加到 contentView
        self.addSubview(hostingController.view)

        // 设置约束
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: self.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

        self.hostingController = hostingController
    }
}
