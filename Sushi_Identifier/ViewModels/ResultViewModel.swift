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
//        self.api()
    }
    
    func api()
    {
        let url = "http://49.212.133.185:8899/hi"
        let data = self.image!.jpegData(compressionQuality: 1)
        let headers: HTTPHeaders = [
            "Authorization": "Bearer QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
            "Accept": "application/json"
        ];

        //デフォルトでpost通信になっている
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(data!, withName: "image", fileName: self.fileName, mimeType: "image/jpeg")
            },
            to: url,
            method: .post,
            headers: headers,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                    case .success(let upload, _, _):
                        print("success_img")
                        self.uploaldMultipartProcess(upload: upload)
                        upload.responseJSON { response in
                            print("なぜ")
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
    func uploaldMultipartProcess(upload: UploadRequest) {
        upload
            .uploadProgress(closure: { (progress) in
                print("Upload Progress: \(progress.fractionCompleted)")
            })
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { (response: DataResponse<Any>) in
                let statusCode = response.response?.statusCode
                print("Success: \(response.result.isSuccess)")
                print("Status code: \(String(describing: statusCode))")
        }
    }
    
      func api2()
      {
        let url = "http://49.212.133.185:8899/" // simulatorの場合
        Alamofire.request(url, method: .get, parameters: nil)
          .validate(statusCode: 200..<300)
          .validate(contentType: ["application/json"])
          .responseJSON { response in
            switch response.result {
            case .success:
              print("success!")
              guard let data = response.data else {
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
            case .failure:
              print("Failure!")
            }
        }
      }

}
