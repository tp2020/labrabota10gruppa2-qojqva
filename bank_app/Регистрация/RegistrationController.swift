//
//  RegistrationController.swift
//  bank_app
//
//  Created by Roman on 4/14/20.
//  Copyright © 2020 Roman. All rights reserved.
//

import UIKit
import Firebase

class RegistrationController: UIViewController {
    
    var email_textField = UITextField()
    var password_textFiled = UITextField()
    var re_password_textField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 55))
        view.addSubview(navBar)
        email_textField = create_textField(placeholder: "  Почта", y: 94, security: false)
        password_textFiled = create_textField(placeholder: "  Пароль", y: 144, security: true)
        re_password_textField = create_textField(placeholder: "  Повторите пароль", y: 194, security: true)
        createButton(frame: CGRect(x: 0, y: 274, width: 200, height: 50), corner_radius: 25, title: "Продолжить", method: #selector(button_func))
    }
    
    
    
    @objc func button_func() {
        if (email_textField.text!.isEmpty || password_textFiled.text!.isEmpty || re_password_textField.text!.isEmpty) {
            print("Empty field")
        } else if (password_textFiled.text != re_password_textField.text) {
            print("Not the same passwords")
        } else {
            Auth.auth().createUser(withEmail: email_textField.text!, password: password_textFiled.text!) { authResult, error in
                if error == nil {
                    let uid = Auth.auth().currentUser?.uid
                    Database.database().reference().child("users").child(uid!).child("email").setValue(self.email_textField.text!)
                    Database.database().reference().child("users").child(uid!).child("password").setValue(self.password_textFiled.text!)
                    self.performSegue(withIdentifier: "move_two_two", sender: self)
                } else {
                    print("Error!")
                }
            }
        }
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

extension UIViewController {
    func create_textField(placeholder: String, y: Int, security: Bool) -> UITextField {
           let textField = UITextField()
           textField.frame = CGRect(x: 0, y: y, width: 300, height: 34)
           textField.center.x = self.view.center.x
           textField.placeholder = placeholder
           textField.layer.cornerRadius = 10
           textField.layer.borderColor = UIColor.black.cgColor
           textField.layer.borderWidth = 1
           textField.isSecureTextEntry = security
           textField.autocapitalizationType = .none
           self.view.addSubview(textField)
           return textField
       }
}
