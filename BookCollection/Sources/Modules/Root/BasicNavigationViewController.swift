//
//  BasicNavigationViewController.swift
//  BookCollection
//
//  Created by zjy on 2025/3/19.
//

import UIKit

class BasicNavigationViewController: UINavigationController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 11.0, *) {
            self.navigationBar.prefersLargeTitles = true
        }
        
        self.navigationController?.interactivePopGestureRecognizer!.delegate = self
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if children.count > 0 {
//            viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
//            viewController.navigationItem.leftBarButtonItems = backButtonItem // 自定义返回按钮
            viewController.hidesBottomBarWhenPushed = true
            interactivePopGestureRecognizer?.delegate = self
        }
        super.pushViewController(viewController, animated: animated)
        
    }
}
