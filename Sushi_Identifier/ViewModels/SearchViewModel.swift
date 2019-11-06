//
//  SearchViewController.swift
//  Sushi_Identifier
//
//  Created by 深見龍一 on 2019/11/02.
//  Copyright © 2019 Asukalab. All rights reserved.
//

import RxSwift
import RxCocoa
import Alamofire

class SearchViewModel {
  private let disposeBag = DisposeBag()
  let list = BehaviorRelay<Array>(value: ["1", "2", "3", "4", "5", "6", "7", "8"])
  let searchWord = BehaviorRelay<String?>(value: nil)
  var articles: [[Test]] = []
  var a: [String] = []
  
  init(){
    self.searchWord.asObservable()
      .subscribe(onNext: { value in
        print(value ?? "value")
        self.api()
      })
      .disposed(by: self.disposeBag)
  }
  
//  func api() -> [[Test]]
  func api()
  {
//    let params: [String: AnyObject]? = [:]
    self.articles.removeAll()
    let url = "https://qiita.com/api/v2/items"
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
            let tasks: [Qiita] = try decoder.decode([Qiita].self, from: data)
//            self.articles.append(tasks)
            for task in tasks
            {
//              var test = Test()
              self.a.append(String(task.title))
//            print("taskのidはこちら!: " + String(task.id))
            }
//            print(tasks)
//            self.a.append(String(tasks[0].id))
//            print(self.a)
            self.list.accept(self.a)
            self.a.removeAll()
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
