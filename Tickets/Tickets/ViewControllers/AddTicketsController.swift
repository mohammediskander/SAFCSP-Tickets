//
//  AddTicketsViewController.swift
//  Tickets
//
//  Created by Abdullah Alhomaidhi on 30/10/2020.
//

import UIKit

class AddTicketsController: UIViewController {
    
    
    let ticketTypes = [
        "Food",
        "Gift",
        "Other",
        "Personal Product",
        "Supermarket"
    ]

    
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
        datePicker.minimumDate = Date()
    }
    
    
    @IBAction func addTicketButtonPressed(_ sender: UIButton) {
        
        
        
        
    }
}


extension AddTicketsController: UITextFieldDelegate, UITextPasteDelegate {
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let letters = "A"..."z"
        let numbers = 0...9
        
        guard string != "" else {
            return true
        }
        
        guard string.count <= 1 else {
            return false
        }
        
        
        guard textField != carsLicensePlateNumbersTextField1,
              textField != carsLicensePlateNumbersTextField2,
              textField != carsLicensePlateNumbersTextField3,
              textField != carsLicensePlateNumbersTextField4 else {
            
            guard let count = textField.text?.count, count < 1 else {
                return false
            }
            
            guard let char = string.first else {
                return false
            }
            guard let numb = Int("\(char)") else {
                return false

            }
            
            guard numbers.contains(numb) else {
                return false

            }
            moveCursor(textField,withText: string)
            return true
        }
        
        
        guard textField != carsLicensePlateLettersTextField1,
              textField != carsLicensePlateLettersTextField2,
              textField != carsLicensePlateLettersTextField3 else {
            
            guard let count = textField.text?.count, count < 1 else {
                return false
            }
            
            guard letters.contains(string) else {
                return false
            }
            
            moveCursor(textField,withText: string)
            return true
        }
        
        moveCursor(textField,withText: string)
        return true
    }
    
    func moveCursor(_ textField: UITextField,withText text: String) {
        
        if textField == carsLicensePlateLettersTextField1{
            carsLicensePlateLettersTextField2.becomeFirstResponder()
        }
        if textField == carsLicensePlateLettersTextField2{
            carsLicensePlateLettersTextField3.becomeFirstResponder()
        }
        if textField == carsLicensePlateLettersTextField3{
            carsLicensePlateNumbersTextField1.becomeFirstResponder()
        }
        if textField == carsLicensePlateNumbersTextField1{
            carsLicensePlateNumbersTextField2.becomeFirstResponder()
        }
        if textField == carsLicensePlateNumbersTextField2{
            carsLicensePlateNumbersTextField3.becomeFirstResponder()
        }
        if textField == carsLicensePlateNumbersTextField3{
            carsLicensePlateNumbersTextField4.becomeFirstResponder()
        }
        if textField == carsLicensePlateNumbersTextField4{
            textField.resignFirstResponder()
        }
        
        textField.text = text.uppercased()
        
    }
}

extension AddTicketsController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ticketTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ticketTypes[row]
    }
}

enum TicketType: String, Codable {
    case food            = "Food"
    case gift            = "Gift"
    case other           = "Other"
    case personalProduct = "Personal Product"
    case supermarket     = "Supermarket"
    
    static let types = [food,gift, other, personalProduct, supermarket]
    
    init?(id : Int) {
            switch id {
            case 0:
                self = .food
            case 1:
                self = .gift
            case 2:
                self = .other
            case 3:
                self = .personalProduct
            case 4:
                self = .supermarket
            default:
                return nil
            }
        }
}


struct Ticket: Codable {
    let ticketName: String
    let ticketType: TicketType
    let expectedDeliveryDate: Date
    let DriversName: String
    let CarsModel: String
    let licencePlate: String
    let carscolor: String


}
