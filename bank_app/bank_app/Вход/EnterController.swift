//
//  EnterController.swift
//  bank_app
//
//  Created by Roman on 4/14/20.
//  Copyright © 2020 Roman. All rights reserved.
//

import UIKit
import Firebase

class EnterController: UIViewController {
    
    var email_textField = UITextField()
    var password_textFiled = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 55))
        view.addSubview(navBar)
        email_textField = create_textField(placeholder: "  Почта", y: 94, security: false)
        password_textFiled = create_textField(placeholder: "  Пароль", y: 144, security: true)
        createButton(frame: CGRect(x: 0, y: 200, width: 200, height: 50), corner_radius: 25, title: "Продолжить", method: #selector(button_func))
    }
    
    @objc func button_func() {
        if (email_textField.text!.isEmpty || password_textFiled.text!.isEmpty) {
            print("Some field empty")
        } else {
            Auth.auth().signIn(withEmail: email_textField.text!, password: password_textFiled.text!) { (authResult, error) in
                if (error == nil) {
                    self.performSegue(withIdentifier: "move_two", sender: self)
                        /*
                    let navController = NavigationController()
                    navController.modalPresentationStyle = .fullScreen
                    let vc = MainController()
                    navController.setViewControllers([vc], animated: false)
                    self.present(navController, animated: true, completion: nil)
 */
                } else {
                    print("Error")
                }
            }
        }
    }
    
}
