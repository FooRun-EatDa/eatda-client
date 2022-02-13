//
//  RestaurantDetailTVC.swift
//  EatDa
//
//  Created by 김희진 on 2022/02/01.
//

import Foundation
import UIKit

class RestaurantDetailTVC: UITableViewCell {
            
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
          super.setSelected(selected, animated: animated)
          // Configure the view for the selected state
    }
             
}
