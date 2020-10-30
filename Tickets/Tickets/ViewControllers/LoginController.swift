//
//  LoginController.swift
//  Tickets
//
//  Created by Mohammed Iskandar on 27/10/2020.
//

import UIKit
import Alamofire

class LoginController: UIViewController, UITextViewDelegate {
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        submitButton.layer.cornerRadius = submitButton.frame.height / 2
        
        emailField.layer.cornerRadius = emailField.frame.height / 2
        emailField.setLeftPaddingPoints(10)
        emailField.setRightPaddingPoints(10)
        emailField.layer.masksToBounds = true
        emailField.backgroundColor = .systemGray6
        
        passwordField.layer.cornerRadius = passwordField.frame.height / 2
        passwordField.backgroundColor = .systemGray6
        passwordField.layer.masksToBounds = true
        passwordField.setLeftPaddingPoints(10)
        passwordField.setRightPaddingPoints(10)
        
    }
    
    @IBAction func handleTappedLoginButton(_ sender: UIButton) {
        print("email: \(String(describing: emailField.text ?? ""))")
        print("password: \(String(describing: passwordField.text ?? ""))")
        
        AF.responseWithData(AuthenticationRouter.create(email: emailField.text ?? "", password: passwordField.text ?? ""), type: SuccessResponse.self) {
            data, error in
            
            guard let data = data else {
                if let error = error as? ErrorResponse {
                    print(error.name)
                }
                
                return
            }
            
            UserDefaults.standard.setValue(data.token, forKey: "__token")
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = mainStoryboard.instantiateInitialViewController()
            UIApplication.shared.windows.first?.rootViewController = viewController
        }
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
