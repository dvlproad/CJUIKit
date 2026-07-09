//
//  MySwiftUIView.swift
//  CJUIKitDemo
//
//  Created by ciyouzen on 2024/8/9.
//  Copyright © 2024 dvlproad. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public struct MySwiftUIView: View {
    var title: String
    var subTitle: String?
    
    public init(title: String, subTitle: String? = nil) {
        self.title = title
        self.subTitle = subTitle
    }
    
    public var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text("\(title)")
                .font(.largeTitle)
            
            if let subTitle = subTitle {
                Text("\(subTitle)")
                    .font(.system(size: 18))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
            }
            
//            Button("点击") {
//                if let subTitle = subTitle {
//                    print("按钮被点击！: \(title)--\(subTitle)")
//                } else {
//                    print("按钮被点击！: \(title)")
//                }
//
//            }
//            .buttonStyle(.borderedProminent)
        }
    }
}


// MARK: - Preview
#if DEBUG
@available(iOS 13.0, *)
struct MySwiftUIView_Preview: PreviewProvider {
    static var previews: some View {
        MySwiftUIView(
            title: "title",
            subTitle: "subTitle"
        )
    }
}
#endif
