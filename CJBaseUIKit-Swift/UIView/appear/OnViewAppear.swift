//
//  OnViewAppear.swift
//  CJUIKitDemo
//
//  Created by qian on 2022/1/19.
//  Copyright © 2022年 dvlproad. All rights reserved.
//

import SwiftUI
 
@available(iOS 13.0, *)
public extension View {
    func cj_onFirstAppear(perform action: @escaping (() -> Void)) -> some View {
        return cj_onAppear(viewDidLoad: action)
    }
    
    func cj_onAppear(viewDidLoad: @escaping (() -> Void),
                     viewDidAppear: (() -> Void)? = nil
    ) -> some View {
        modifier(CJOnAppear(viewDidLoad: viewDidLoad, viewDidAppear: viewDidAppear))
    }
}

@available(iOS 13.0, *)
private struct CJOnAppear: ViewModifier {
    let viewDidLoad: (() -> Void)
    let viewDidAppear: (() -> Void)?
    
    @State private var hasAppeared = false
    
    func body(content: Content) -> some View {
        content.onAppear {
            if !hasAppeared {
                hasAppeared = true
                viewDidLoad()
            } else {
                viewDidAppear?()
            }
        }
    }
}
