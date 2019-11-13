//
//  Frame.swift
//  Sushi_Identifier
//
//  Created by 深見龍一 on 2019/11/06.
//  Copyright © 2019 Asukalab. All rights reserved.
//

import Foundation
import UIKit

class Frame
{
  
  static func viewWidth(view: UIView) -> CGFloat { return view.frame.width }

  static func viewHeight(includeNavBarHeight: Bool = true, includeStatBarHeight: Bool = true, view: UIView, nav: UINavigationController) -> CGFloat {
    return view.frame.height - (includeStatBarHeight ? Frame.statusBarHeight(view: view) : 0) - (includeNavBarHeight ? navBarHeight(nav: nav) : 0)
  }

  static func navBarWidth(nav: UINavigationController) -> CGFloat { return nav.navigationBar.frame.size.width }
  
  static func navBarHeight(nav: UINavigationController) -> CGFloat { return nav.navigationBar.frame.size.height }

  static func statusBarWidth(view: UIView) -> CGFloat { return view.window?.windowScene?.statusBarManager?.statusBarFrame.width ?? 0 }
  
  static func statusBarHeight(view: UIView) -> CGFloat { return view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0 }

  static func isNavBarHidden(nav: UINavigationController) -> Bool { return nav.isNavigationBarHidden }
}
