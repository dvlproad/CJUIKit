//
//  CJUIKitBaseScrollViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

import SnapKit

class CJUIKitBaseScrollViewController: CJUIKitBaseViewController {
    fileprivate var scrollView: UIScrollView!
    fileprivate var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let scrollView: UIScrollView = UIScrollView()
        scrollView.backgroundColor = CJColorFromHexString("#f2f2f2")
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.scrollView = scrollView
        
        
        
        let containerView: UIView = UIView()
        containerView.backgroundColor = UIColor.green;
        scrollView.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.left.right.equalTo(scrollView)
            make.top.bottom.equalTo(scrollView)
            make.width.equalTo(scrollView.snp_width)
            make.height.equalTo(scrollView.snp_height).offset(1)
        }
        self.containerView = containerView
    }
    
    
    /**
     *  更新ScrollView的高
     *  @brief  ①如果没有lastBottomView来确认scrollView的高，那么高为根据父视图设置；
     ②如果有lastBottomView，则通过设置scrollView的containerView与lastBottomView的底部间隔来更新ScrollView的高
     *
     *  @param bottomInterval bottomInterval
     *  @param lastBottomView lastBottomView(可为nil)
     */
    func updateScrollHeight(bottomInterval:CGFloat, lastBottomView:UIView?) {
        assert(bottomInterval >= 0, "Error:scrollView与lastBottomView的底部间隔不能小于0");
        
        if lastBottomView == nil {
            self.containerView.snp.remakeConstraints { (make) in
                make.left.right.equalTo(self.scrollView);
                make.top.bottom.equalTo(self.scrollView);
                make.width.equalTo(self.scrollView.snp_width);
                make.height.equalTo(self.scrollView.snp_height).offset(bottomInterval);
            }
        } else {
            self.containerView.snp.remakeConstraints { (make) in
                make.left.right.equalTo(self.scrollView);
                make.top.bottom.equalTo(self.scrollView);
                make.width.equalTo(self.scrollView.snp_width);
                make.bottom.equalTo(lastBottomView!.snp_bottom).offset(bottomInterval);
            }
        }
    }
    
}
