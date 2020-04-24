//
//  CourseController.swift
//  bank_app
//
//  Created by Roman on 4/15/20.
//  Copyright © 2020 Roman. All rights reserved.
//

import UIKit

class CourseController: UIViewController {

   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Курсы валют"
        self.view.backgroundColor = .systemGray6
        
        create_labels(y: 100, str_one: "Валюта", str_two: "Покупка", str_three: "Продажа")
        create_labels(y: 150, str_one: "USD", str_two: "2.45", str_three: "2.46")
        create_labels(y: 200, str_one: "EUR", str_two: "2.67", str_three: "2.68")
        create_labels(y: 250, str_one: "100 RUB", str_two: "3.302", str_three: "3.307")
        
    }
    
    func create_labels(y: Int, str_one: String, str_two: String, str_three: String) {
        let course_Label = UILabel()
        let buy_label = UILabel()
        let sell_Label = UILabel()
        
        course_Label.frame = CGRect(x: 30, y: y, width: Int(self.view.frame.width / 3 ) - 20, height: 50)
        buy_label.frame = CGRect(x: 30 + Int(self.view.frame.width / 3 ) - 20, y: y, width: Int(self.view.frame.width / 3 ) - 20, height: 50)
        sell_Label.frame = CGRect(x: 30 + Int(self.view.frame.width / 3 ) - 20 + Int(self.view.frame.width / 3 ) - 20, y: y, width: Int(self.view.frame.width / 3 ) - 20, height: 50)
        course_Label.text = str_one
        buy_label.text = str_two
        sell_Label.text = str_three
        
        
        self.view.addSubview(course_Label)
        self.view.addSubview(buy_label)
        self.view.addSubview(sell_Label)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
