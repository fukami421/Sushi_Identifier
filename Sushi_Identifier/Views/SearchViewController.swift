//
//  SearchViewController.swift
//  Sushi_Identifier
//
//  Created by 深見龍一 on 2019/10/31.
//  Copyright © 2019 Asukalab. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  private let searchViewModel = SearchViewModel()
  private let disposeBag = DisposeBag()
  fileprivate let refreshCtl = UIRefreshControl()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Search"
    self.navigationController?.navigationBar.barTintColor = .white
    self.searchBarSetUp()
    self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
    self.bindViewModel()
    self.tableView.refreshControl = self.refreshCtl
    refreshCtl.addTarget(self, action: #selector(SearchViewController.refresh(sender:)), for: .valueChanged)
  }
  
  @objc func refresh(sender: UIRefreshControl) {
    print("refresh!")
    refreshCtl.endRefreshing()
  }
  
  private func bindViewModel()
  {
    self.searchBar.rx.text
        .orEmpty
        .subscribe(onNext: {value in
            self.searchViewModel.searchWord.accept(value)
        })
        .disposed(by: self.disposeBag)
        
    self.searchViewModel.list
      .bind(to: tableView.rx.items) { tableView, index, item in
        let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")! as! TableViewCell
        // 選択されたセルの色を変える
        cell.backgroundColor = UIColor.clear
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor.red
        cell.selectedBackgroundView =  selectedView
        cell.textLabel?.text = item
      return cell
    }
    .disposed(by: self.disposeBag)
  }
}

extension SearchViewController: UISearchBarDelegate{
  func searchBarSetUp()
  {
    self.searchBar.delegate = self
    searchBar.showsCancelButton = false
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
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.showsCancelButton = false
    searchBar.resignFirstResponder()
  }
}

extension SearchViewController: UITableViewDelegate{
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("押した")
  }
}
