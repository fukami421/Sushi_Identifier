//
//  ResultViewController.swift
//  Sushi_Identifier
//
//  Created by 深見龍一 on 2019/11/06.
//  Copyright © 2019 Asukalab. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ResultViewController: UIViewController {
  private let disposeBag = DisposeBag()
  var image:UIImage?
  var str:String?
  @IBOutlet weak var imageView: UIImageView!
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupUI()
  }

  private func setupUI()
  {
    self.title = "Result"
//    self.navigationController?.navigationBar.barTintColor = UIColor.cyan
    let udf = UserDefaults.standard
    //todo
    // 1. data型の値が存在するかチェック
    image = UIImage(data: udf.data(forKey: "imageData")!)
    self.imageView.image = image
    self.imageView.frame = CGRect(x: 0, y: !isNavBarHidden() ? statusBarHeight() + navBarHeight() : statusBarHeight(), width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width)
  }
  //    func viewWidth() -> CGFloat { return self.view.frame.width }
  //    func viewHeight(includeNavBarHeight: Bool = true, includeStatBarHeight: Bool = true) -> CGFloat {
  //        return self.view.frame.height - (includeStatBarHeight ? statBarHeight() : 0) - (includeNavBarHeight ? navBarHeight() : 0)
  //    }
  //
  //    func navBarWidth() -> CGFloat { return self.navigationController?.navigationBar.frame.size.width ?? 0 }
      func navBarHeight() -> CGFloat { return self.navigationController?.navigationBar.frame.size.height ?? 0 }

  //    func statBarWidth() -> CGFloat { return UIApplication.shared.statusBarFrame.width }
      func statusBarHeight() -> CGFloat { return view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0 }

      func isNavBarHidden() -> Bool { return self.navigationController?.isNavigationBarHidden ?? true }

}

//  private extension UIViewController{
//    @IBAction func backToStoryboard(_ sender: Any) {
//      self.dismiss(animated: true, completion: nil)
//    }
//  }
