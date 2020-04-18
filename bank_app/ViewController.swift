//
//  ViewController.swift
//  bank_app
//
//  Created by Roman on 4/14/20.
//  Copyright © 2020 Roman. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    let logo_imageView = UIImageView()
    let company_name_label = UILabel()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createButton(frame: CGRect(x: 0, y: self.view.frame.maxY - 170, width: 120, height: 46), corner_radius: 23, title: "Вход", method: #selector(enter_button_func))
        createButton(frame: CGRect(x: 0, y: self.view.frame.maxY - 110, width: 200, height: 46), corner_radius: 23, title: "Регистрация", method: #selector(register_button_func))
        
        logo_imageView.frame = CGRect(x: 0, y: 30, width: 200, height: 200)
               logo_imageView.center.x = self.view.center.x
               logo_imageView.contentMode = .scaleAspectFill
               logo_imageView.image = UIImage(named: "logo.jpg")
               self.view.addSubview(logo_imageView)
        
        
        company_name_label.frame = CGRect(x: 0, y: 200, width: 200, height: 50)
        company_name_label.center.x = self.view.center.x
        company_name_label.textColor = .black
        company_name_label.font = UIFont.boldSystemFont(ofSize: 30.0)
        company_name_label.text = "BANK APP"
        company_name_label.textAlignment = .center
        self.view.addSubview(company_name_label)
    }
    
    
    
    @objc func register_button_func() {
        self.performSegue(withIdentifier: "move_one_one", sender: self)
       
        /*let vc = RegistrationController()
        vc.modalPresentationStyle = .fullScreen
       self.present(vc, animated: true, completion: nil)
 */
    }
    
    @objc func enter_button_func() {
        self.performSegue(withIdentifier: "move_one", sender: self)
       /*let vc = EnterController()
        vc.modalPresentationStyle = .fullScreen
       self.present(vc, animated: true, completion: nil)
 */
    }


}


extension UIViewController {
    func createButton(frame:CGRect, corner_radius:CGFloat, title:String, method:Selector ) {
        let button = UIButton()
        button.frame = frame
        button.center.x = self.view.center.x
        button.setTitle(title, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = corner_radius
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.addTarget(self, action: method, for: .touchUpInside)
        self.view.addSubview(button)
    }
}
