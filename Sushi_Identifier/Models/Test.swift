//
//  Test.swift
//  Sushi_Identifier
//
//  Created by 深見龍一 on 2019/11/02.
//  Copyright © 2019 Asukalab. All rights reserved.
//

import Foundation
struct Test: Codable {
    let id: Int
    let first: String
    let last: String

    enum CodingKeys: String, CodingKey {
        case id
        case first = "first_name"
        case last = "last_name"
    }
}
//class Test: Codable {
////  var title: String
////  var publicTime: String
////  var forecasts: String
////  var location: String
////  var description: String
//
//  var id: String
//  var first: String
//  var last: String
//
//  init()
//  {
//    self.id = ""
//    self.first = ""
//    self.last = ""
////    self.title = ""
////    self.publicTime = ""
////    self.forecasts = ""
////    self.location = ""
////    self.description = ""
//  }
//}
