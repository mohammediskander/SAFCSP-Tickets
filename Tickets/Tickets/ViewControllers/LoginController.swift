//
//  LoginController.swift
//  Tickets
//
//  Created by Mohammed Iskandar on 27/10/2020.
//

import UIKit
import Alamofire

class LoginController: UIViewController, UITextViewDelegate {
    
    
    @IBOutlet var emailField: CustomTextFieldwIcon!
    
//    var imageView = UIImageView()
//    var image = UIImage(named: "user.png")

    @IBOutlet var passwordField: CustomTextFieldwIcon!
    @IBOutlet var submitButton: CustomButton!
//    @IBOutlet var userLogo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
//        emailField.leftViewMode = UITextField.ViewMode.always
//        emailField.leftViewMode = .always
        
        
        submitButton.layer.cornerRadius = submitButton.frame.height / 2
        
        emailField.layer.cornerRadius = emailField.frame.height / 2
//        emailField.setLeftPaddingPoints(10)
//        emailField.setRightPaddingPoints(10)
        emailField.layer.masksToBounds = true
//        emailField.borderStyle = .none
//
//        emailField.useUnderline()
        
        passwordField.layer.cornerRadius = passwordField.frame.height / 2
//        passwordField.backgroundColor = .systemGray6
//        passwordField.borderStyle = .none
//        passwordField.useUnderline()
        passwordField.layer.masksToBounds = true
//        passwordField.setLeftPaddingPoints(10)
//        passwordField.setRightPaddingPoints(10)
        
    }
    
    @IBAction func handleTappedLoginButton(_ sender: UIButton) {
//        print("email: \(String(describing: emailField.text ?? ""))")
//        print("password: \(String(describing: passwordField.text ?? ""))")
        
        AF.responseWithData(AuthenticationRouter.create(email: emailField.text, password: passwordField.text), type: SuccessResponse.self) {
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


extension UITextField {

    func useUnderline() {
        let border = CALayer()
        let borderWidth = CGFloat(1.0)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(origin: CGPoint(x: 0,y :self.frame.size.height - borderWidth), size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

extension UITextField{

    func setLeftImage(imageName:String) {

        let imageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 1, height: 1))
        imageView.image = UIImage(named: imageName)
        self.leftView = imageView;
        self.leftViewMode = .always
    }
}

extension UIImageView{
    func useUnderline() {
        let border = CALayer()
        let borderWidth = CGFloat(1.0)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(origin: CGPoint(x: 0,y :self.frame.size.height - borderWidth), size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
