//
//  Register.swift
//  Tickets
//
//  Created by Mohammed Iskandar on 27/10/2020.
//

import UIKit
import Alamofire

class RegisterController: UIViewController, UITextViewDelegate {
    @IBOutlet var nameField: CustomTextFieldwIcon!
    @IBOutlet var emailField: CustomTextFieldwIcon!
    @IBOutlet var passwordField: CustomTextFieldwIcon!
    @IBOutlet var submitButton: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        submitButton.layer.cornerRadius = submitButton.frame.height / 2
//
//        nameField.layer.cornerRadius = nameField.frame.height / 2
//        nameField.setLeftPaddingPoints(10)
//        nameField.setRightPaddingPoints(10)
//        nameField.layer.masksToBounds = true
//        nameField.backgroundColor = .systemGray6
//
//        emailField.layer.cornerRadius = emailField.frame.height / 2
////        emailField.setLeftPaddingPoints(10)
////        emailField.setRightPaddingPoints(10)
//        emailField.layer.masksToBounds = true
//        emailField.backgroundColor = .systemGray6
//
//        passwordField.layer.cornerRadius = passwordField.frame.height / 2
//        passwordField.setLeftPaddingPoints(10)
//        passwordField.setRightPaddingPoints(10)
//        passwordField.layer.masksToBounds = true
//        passwordField.backgroundColor = .systemGray6
    }
    
    @IBAction func handleTappedRegisterButton(_ sender: UIButton) {
        AF.responseWithData(UserRouter.create(name: nameField.text, email: emailField.text, password: passwordField.text), type: SuccessResponse.self) {
            data, error in
            guard let data = data else {
                if let error = error as? ErrorResponse {
                    print(error.name)
                }
                
                return
            }
            
            UserDefaults.standard.setValue(data.token, forKey: "__token")
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = mainStoryboard.instantiateInitialViewController()
            UIApplication.shared.windows.first?.rootViewController = viewController
            
        }
    }
    
    @IBAction func dissmissME(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
