//
//  CJUIKitBaseHomeViewController.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

import SnapKit
//#import <CJBaseUtil/CJSectionDataModel.h>   //在CJDataUtil中
//#import <CJBaseUtil/CJModuleModel.h>        //在CJDataUtil中

class CJUIKitBaseHomeViewController: CJUIKitBaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView!
    var sectionDataModels: NSMutableArray!
    
    override func viewDidLoad() {
        self.navigationItem.title = NSLocalizedString("XXX首页", comment: "XXX首页") //知识点:使得tabBar中的title可以和显示在顶部的title保持各自
        
        let tableView: UITableView = UITableView.init(frame: CGRect.zero, style: .grouped)
        //[tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        tableView.dataSource = self;
        tableView.delegate = self;
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.tableView = tableView
        
        let sectionDataModels: NSMutableArray = NSMutableArray()
        self.sectionDataModels = sectionDataModels;
    }
    
    // MARK: - UITableViewDataSource & UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionDataModels.count;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionDataModel: CJSectionDataModel = self.sectionDataModels.object(at: section) as! CJSectionDataModel
        let dataModels: NSArray = sectionDataModel.values;
        
        return dataModels.count;
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionDataModel: CJSectionDataModel = self.sectionDataModels.object(at: section) as! CJSectionDataModel
        let indexTitle: String = sectionDataModel.theme
        return indexTitle
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionDataModel: CJSectionDataModel = self.sectionDataModels.object(at: indexPath.section) as! CJSectionDataModel
        let dataModels: NSArray = sectionDataModel.values;
        let moduleModel: CJModuleModel = dataModels.object(at: indexPath.row) as! CJModuleModel
        
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel!.text = moduleModel.title
        cell.detailTextLabel!.text = moduleModel.content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //NSLog(@"didSelectRowAtIndexPath = %zd %zd", indexPath.section, indexPath.row);
        tableView.deselectRow(at: indexPath, animated: true)
        
        let sectionDataModel: CJSectionDataModel = self.sectionDataModels.object(at: indexPath.section) as! CJSectionDataModel
        let dataModels: NSArray = sectionDataModel.values;
        let moduleModel: CJModuleModel = dataModels.object(at: indexPath.row) as! CJModuleModel
        
        self.execModuleModel(moduleModel: moduleModel)
    }
    
    func execModuleModel(moduleModel: CJModuleModel) {
        if (moduleModel.actionBlock != nil) {
            moduleModel.actionBlock()
            
        } else if (moduleModel.selector != nil) {
            self.performSelector(onMainThread: moduleModel.selector, with: nil, waitUntilDone: false)
            
        } else {
            var viewController: UIViewController? = nil
            let classEntry: AnyClass = moduleModel.classEntry
            let viewControllerClass: UIViewController.Type = classEntry as! UIViewController.Type
            
            let clsString: String = NSStringFromClass(moduleModel.classEntry)
            if clsString.isEqual(NSStringFromClass(UIViewController.self)) {
                viewController = viewControllerClass.init()
                viewController!.view.backgroundColor = UIColor.white
            } else {
                if moduleModel.isCreateByXib {
                    viewController = viewControllerClass.init(nibName: clsString, bundle: nil)
                } else {
                    viewController = viewControllerClass.init()
                    
                }
            }
            viewController!.title = NSLocalizedString(moduleModel.title, comment: moduleModel.title)
            viewController!.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(viewController!, animated: true)

        }

    }
}
