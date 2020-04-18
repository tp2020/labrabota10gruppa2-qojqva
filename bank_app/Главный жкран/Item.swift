//
//  Item.swift
//  bank_app
//
//  Created by Roman on 4/16/20.
//  Copyright © 2020 Roman. All rights reserved.
//

import Foundation
import UIKit
struct Item {
    var image:UIImage = UIImage()
    var text:String = ""
    var detailText:String = ""
    var rightText:String = ""
    
    init(image: UIImage, text:String, detailText:String, rightText:String) {
        self.image = image
        self.text = text
        self.detailText = detailText
        self.rightText = rightText
    }
}

