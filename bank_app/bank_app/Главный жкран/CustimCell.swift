//
//  CustimCell.swift
//  bank_app
//
//  Created by Roman on 4/16/20.
//  Copyright © 2020 Roman. All rights reserved.
//

import UIKit

class CustimCell: UITableViewCell {

    let imgUser = UIImageView()
    let labUserName = UILabel()
    let labMessage = UILabel()
    let labTime = UILabel()

    required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
       }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        imgUser.backgroundColor = .red

        labUserName.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        labUserName.textColor = .red
        labUserName.text = "HI"
        contentView.addSubview(labUserName)
    }

}
