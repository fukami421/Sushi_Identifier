//
//  TabBarViewController.swift
//  Sushi_Identifier
//
//  Created by 深見龍一 on 2019/10/31.
//  Copyright © 2019 Asukalab. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
      super.viewDidLoad()
      // FirstViewControllerをタブのRootViewControllerに設定
      let firstVC = UINavigationController(rootViewController: SearchViewController.init(nibName: nil, bundle: nil))
      // タブのFooter部分を設定
      firstVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)

      // SecondViewControllerをタブのRootViewControllerに設定
      let secondVC = UINavigationController(rootViewController: MapViewController.init(nibName: nil, bundle: nil))
      // タブのFooter部分を設定
      secondVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
      
      self.viewControllers = [firstVC,secondVC]
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
