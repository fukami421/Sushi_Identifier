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
        print(self.api())
      })
      .disposed(by: self.disposeBag)
  }
  
  func api() -> [[Test]]
  {
//    let params: [String: AnyObject]? = [:]
    let url = "https://todo-practice-app.herokuapp.com/items"
    Alamofire.request(url, method: .get, parameters: nil)
      .validate(statusCode: 200..<300)
      .validate(contentType: ["application/json"])
      .responseJSON { response in
        switch response.result {
        case .success:
          guard let data = response.data else {
            return
          }
          let decoder = JSONDecoder()
          do {
            let task: [Test] = try decoder.decode([Test].self, from: data)
            self.articles.append(task)
            print(task)
            self.a.append(String(task[0].id))
            print(self.a)
            self.list.accept(self.a)
          } catch {
            print("error:")
            print(error)
          }
        case .failure:
          print("Failure!")
        }
    }
    return self.articles
  }
}
