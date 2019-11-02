//
//  SearchViewController.swift
//  Sushi_Identifier
//
//  Created by 深見龍一 on 2019/11/02.
//  Copyright © 2019 Asukalab. All rights reserved.
//

import RxSwift
import RxCocoa

class SearchViewModel: UIViewController {
  let list = BehaviorRelay<Array>(value: ["1", "2", "3", "4", "5", "6", "7", "8"])
  let searchWord = BehaviorRelay<String?>(value: nil)
}
