//
//  CameraViewModel.swift
//  Sushi_Identifier
//
//  Created by 深見龍一 on 2019/11/13.
//  Copyright © 2019 深見龍一. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class ResultViewModel {
    private let disposeBag = DisposeBag()
    let udf = UserDefaults.standard
    var image:UIImage?
    var result = BehaviorRelay<String>(value: "100%の確率でウニだよ!!")
    let fileName: String = "testName.jpeg" //test用のfileName

    init(){
        self.image = UIImage(data: udf.data(forKey: "imageData")!)
        print(self.image!)
        self.api()
    }
    
    func api()
    {
        let url = "https://qiita.com/api/v2/items"
        let data = self.image!.jpegData(compressionQuality: 1)
        //デフォルトでpost通信になっている
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(data!, withName: "image", fileName: self.fileName, mimeType: "image/jpeg")
            },
            to: url,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                    case .success(let upload, _, _):
                        print("success_img")
                        upload.responseJSON { response in
                            guard let jsonResponse = response.result.value as? [String: Any] else{
                                return
                            }
                            print(jsonResponse)
                        }
                case .failure(let encodingError):
                    // 失敗
                    print("fail_image")
                    print(encodingError)
            }}
        )
    }
}
