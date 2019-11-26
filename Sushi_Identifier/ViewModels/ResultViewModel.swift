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
        let url = "http://127.0.0.1:5000/hello"
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
                            guard let data = response.data else{
                                return
                            }
                            let decoder = JSONDecoder()
                            do {
                                let tasks = try decoder.decode(Test.self, from: data)
                                print(tasks.message)
                            } catch {
                                print("error:")
                                print(error)
                            }

                            print(data)
                        }
                case .failure(let encodingError):
                    // 失敗
                    print("fail_image")
                    print(encodingError)
            }}
        )
    }
}
