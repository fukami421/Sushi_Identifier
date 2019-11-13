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
    let udf = UserDefaults.standard
    let resultViewModel = ResultViewModel()
    
    var image:UIImage?
    var resultLbl = UILabel()
    var str:String!
    var ryu:Int?
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Result"
        self.bind()
        self.setupUI()
    }

    func bind()
    {
        self.resultViewModel.result
            .bind(to: self.resultLbl.rx.text)
            .disposed(by: self.disposeBag)
    }

    private func setupUI()
    {
        //todo
        // 1. data型の値が存在するかチェック
        image = UIImage(data: self.udf.data(forKey: "imageData")!)
        self.imageView.image = image
        self.imageView.frame = CGRect(x: 0, y: !Frame.isNavBarHidden(nav: self.navigationController!) ? Frame.statusBarHeight(view: self.view) + Frame.navBarHeight(nav: self.navigationController!) : Frame.statusBarHeight(view: self.view), width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width)
        
        // 結果を表示するlabelの設定
        self.resultLbl.frame = CGRect(x: 20, y: self.imageView.frame.maxY + 5, width: UIScreen.main.bounds.size.width - 40, height: 30)
        self.resultLbl.backgroundColor = .cyan
        self.resultLbl.textAlignment = NSTextAlignment.center
        self.view.addSubview(self.resultLbl)
    }
}
