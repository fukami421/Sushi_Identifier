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
    self.imageView.frame = CGRect(x: 0, y: !Frame.isNavBarHidden(nav: self.navigationController!) ? Frame.statusBarHeight(view: self.view) + Frame.navBarHeight(nav: self.navigationController!) : Frame.statusBarHeight(view: self.view), width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width)
  }
}
