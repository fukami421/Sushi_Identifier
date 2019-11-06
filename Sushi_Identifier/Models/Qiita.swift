//
//  Qiita.swift
//  Sushi_Identifier
//
//  Created by 深見龍一 on 2019/11/06.
//  Copyright © 2019 Asukalab. All rights reserved.
//

import Foundation

struct Qiita: Codable {
  var title: String
//  let user: String

  enum CodingKeys: String, CodingKey {
      case title
//      case user = "first_name"
  }
  
  init()
  {
    self.title = ""
//    self.user = ""
  }
}
