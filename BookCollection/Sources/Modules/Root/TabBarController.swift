//
//  TabBarController.swift
//  BookCollection
//
//  Created by zjy on 2025/3/19.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension TabBarController {
    
    private func setUpView() {
        let home = HomeViewController()
        home.title = "书架"
        addViewController(home, title: "", imageName: "icon-book")
        let discover = UIViewController()
        discover.title = "发现"
        addViewController(discover, title: "", imageName: "icon-search")
        let me = UIViewController()
        me.title = "我的"
        addViewController(me, title: "", imageName: "icon-profile")
    }
    
    private func addViewController(_ controller: UIViewController, title: String, imageName: String) {
        let nav = BasicNavigationViewController(rootViewController: controller)
        addChild(nav)
        controller.tabBarItem = UITabBarItem(title: title, image: UIImage(named: imageName), tag: 1)
        controller.tabBarItem.tag = children.count - 1
        print(children.count - 1)
    }
}
