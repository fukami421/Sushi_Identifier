//
//  TableViewCell.swift
//  Sushi_Identifier
//
//  Created by 深見龍一 on 2019/11/02.
//  Copyright © 2019 Asukalab. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
  @IBOutlet weak var button: UIButton!
  override func awakeFromNib() {
      super.awakeFromNib()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  @IBAction func button(_ sender: Any) {
    print("押したぜ")
  }
}
