//
//  MyUIKitView.swift
//  CJUIKitDemo
//
//  Created by ciyouzen on 2024/8/9.
//  Copyright © 2024 dvlproad. All rights reserved.
//

import UIKit

public class MyUIKitView: UIView {
    
    // MARK: - UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 34, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        label.textColor = .white.withAlphaComponent(0.9)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("点击", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Properties
    var title: String {
        didSet {
            titleLabel.text = title
        }
    }
    
    var subTitle: String? {
        didSet {
            subTitleLabel.text = subTitle
            subTitleLabel.isHidden = subTitle == nil
        }
    }
    
    var buttonAction: (() -> Void)?
    
    // MARK: - Initialization
    public init(title: String, subTitle: String? = nil) {
        self.title = title
        self.subTitle = subTitle
        super.init(frame: .zero)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        backgroundColor = .systemBlue
        
        titleLabel.text = title
        subTitleLabel.text = subTitle
        subTitleLabel.isHidden = subTitle == nil
        
        actionButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(actionButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Title Label
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -40),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -20),
            
            // SubTitle Label
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            subTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            subTitleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 20),
            subTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -20),
            
            // Button
            actionButton.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 20),
            actionButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            actionButton.widthAnchor.constraint(equalToConstant: 120),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    // MARK: - Actions
    @objc private func buttonTapped() {
        if let subTitle = subTitle {
            print("按钮被点击！: \(title)--\(subTitle)")
        } else {
            print("按钮被点击！: \(title)")
        }
        buttonAction?()
    }
    
    // MARK: - Public Methods
    func update(title: String, subTitle: String? = nil) {
        self.title = title
        self.subTitle = subTitle
    }
}



// MARK: - 使用示例
class MyUIKitViewController: UIViewController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addFillingUIKitSubview(
            MyUIKitView(title: "title", subTitle: "subTitle")
        )
    }
}


// ✅ iOS 17+ 预览
#if DEBUG
@available(iOS 17.0, *)
#Preview {
    MyUIKitViewController()
}
#endif
