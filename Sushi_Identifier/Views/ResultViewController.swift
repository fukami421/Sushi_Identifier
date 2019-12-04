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
import CoreML

class ResultViewController: UIViewController {
    private let disposeBag = DisposeBag()
    let udf = UserDefaults.standard
    let resultViewModel = ResultViewModel()
    
    var image:UIImage?
    var result = BehaviorRelay<String>(value: "寿司ネタを判定中です")
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
        self.result
            .bind(to: self.resultLbl.rx.text)
            .disposed(by: self.disposeBag)
        
//        self.resultViewModel.result
//            .bind(to: self.resultLbl.rx.text)
//            .disposed(by: self.disposeBag)
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
        self.executeModel()
    }
}

extension ResultViewController
{
    func executeModel()
    {
        let model = CreateML_1()
        let imgSize: Int = 229
        let imageShape: CGSize = CGSize(width: imgSize, height: imgSize)
        
        // CVPixelBufferへの変換
        let pixelBuffer = image?.resize(to: imageShape).pixelBuffer()
        
        // 画像解析
        guard let pb = pixelBuffer, let output = try? model.prediction(image: pb) else {
            print("error")
            return
        }
        
        // 結果を表示
        let classLbl = output.classLabel
        let percentage = floor(output.classLabelProbs[classLbl]! * 1000) / 10
        self.result.accept(String(percentage) + "%の確率で" + classLbl + "です")
        print("label: " + output.classLabel)
    }
}

extension UIImage {
    func resize(to newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: newSize.width, height: newSize.height), true, 1.0)
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resizedImage
    }
 
    func pixelBuffer() -> CVPixelBuffer? {
        let width = self.size.width
        let height = self.size.height
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue,
                     kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
        var pixelBuffer: CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault,
                                         Int(width),
                                         Int(height),
                                         kCVPixelFormatType_32ARGB,
                                         attrs,
                                         &pixelBuffer)
 
        guard let resultPixelBuffer = pixelBuffer, status == kCVReturnSuccess else {
            return nil
        }
 
        CVPixelBufferLockBaseAddress(resultPixelBuffer, CVPixelBufferLockFlags(rawValue: 0))
        let pixelData = CVPixelBufferGetBaseAddress(resultPixelBuffer)
 
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        guard let context = CGContext(data: pixelData,
                                      width: Int(width),
                                      height: Int(height),
                                      bitsPerComponent: 8,
                                      bytesPerRow: CVPixelBufferGetBytesPerRow(resultPixelBuffer),
                                      space: rgbColorSpace,
                                      bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue) else {
                                        return nil
        }
 
        context.translateBy(x: 0, y: height)
        context.scaleBy(x: 1.0, y: -1.0)
 
        UIGraphicsPushContext(context)
        self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        UIGraphicsPopContext()
        CVPixelBufferUnlockBaseAddress(resultPixelBuffer, CVPixelBufferLockFlags(rawValue: 0))
 
        return resultPixelBuffer
    }
}
