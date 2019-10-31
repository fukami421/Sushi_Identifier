//
//  SearchViewController.swift
//  Sushi_Identifier
//
//  Created by 深見龍一 on 2019/10/31.
//  Copyright © 2019 Asukalab. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
  @IBOutlet weak var searchBar: UISearchBar!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Search"
    self.searchBarSetUp()
  }
  
  func searchBarSetUp()
  {
    self.searchBar.delegate = self
    searchBar.showsCancelButton = false
    //プレースホルダの指定
    searchBar.placeholder = "検索文字列を入力してください"
    //検索スコープを指定するボタン
    searchBar.scopeButtonTitles  = ["寿司屋", "寿司ネタ"]
    searchBar.showsScopeBar = true
  }
  
  func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
    searchBar.showsCancelButton = true
    return true
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.showsCancelButton = false
    searchBar.resignFirstResponder()
  }
}
