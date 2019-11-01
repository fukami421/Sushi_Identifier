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
      let searchVC = UINavigationController(rootViewController: SearchViewController.init(nibName: nil, bundle: nil))
      // タブのFooter部分を設定
      searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)

      let cameraVC = UINavigationController(rootViewController: CameraViewController.init(nibName: nil, bundle: nil))
      // タブのFooter部分を設定
      cameraVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)

      let mapVC = UINavigationController(rootViewController: MapViewController.init(nibName: nil, bundle: nil))
      // タブのFooter部分を設定
      mapVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
      
      self.viewControllers = [searchVC,cameraVC, mapVC]
        // Do any additional setup after loading the view.
    }
}
