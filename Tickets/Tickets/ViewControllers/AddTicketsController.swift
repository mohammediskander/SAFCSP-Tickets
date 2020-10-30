//
//  AddTicketsViewController.swift
//  Tickets
//
//  Created by Abdullah Alhomaidhi on 30/10/2020.
//

import UIKit

class AddTicketsController: UIViewController {
    
    
    let letters = "A"..."z"
//    let arabicLetters = "ا"..."ي"

    
    @IBOutlet var ticketNameField: UITextField!
    @IBOutlet var driversNameTextField: UITextField!
    @IBOutlet var carsModelTextField: UITextField!
    
    @IBOutlet var carsLicensePlateNumbersTextField1: UITextField!
    @IBOutlet var carsLicensePlateNumbersTextField2: UITextField!
    @IBOutlet var carsLicensePlateNumbersTextField3: UITextField!
    @IBOutlet var carsLicensePlateNumbersTextField4: UITextField!

    @IBOutlet var carsLicensePlateLettersTextField1: UITextField!
    @IBOutlet var carsLicensePlateLettersTextField2: UITextField!
    @IBOutlet var carsLicensePlateLettersTextField3: UITextField!

    @IBOutlet var carsColorTextField: UITextField!
    
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var ticketType: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}


extension AddTicketsController: UITextFieldDelegate {
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard textField != carsLicensePlateNumbersTextField1,
              textField != carsLicensePlateNumbersTextField2,
              textField != carsLicensePlateNumbersTextField3,
              textField != carsLicensePlateNumbersTextField4 else {
            guard let count = textField.text?.count, count <= 1 else {
                return false
            }
            
            guard repl else {
                <#statements#>
            }
            
            return true
        }
        
        
        guard textField != carsLicensePlateLettersTextField1,
              textField != carsLicensePlateLettersTextField2,
              textField != carsLicensePlateLettersTextField3 else {
            
            guard let count = textField.text?.count else {
                return false
            }
            
            
            return true
        }
        
        
        
        return true
    }
    
    
}
