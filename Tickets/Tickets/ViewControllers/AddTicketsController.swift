//
//  AddTicketsViewController.swift
//  Tickets
//
//  Created by Abdullah Alhomaidhi on 30/10/2020.
//

import UIKit
import Alamofire

class AddTicketsController: UIViewController {
    
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
        setUpTextField()
    }
    
    func setUpTextField() {
        ticketNameField.layer.cornerRadius = 5
        driversNameTextField.layer.cornerRadius = 5
        carsModelTextField.layer.cornerRadius = 5
        carsLicensePlateNumbersTextField1.layer.cornerRadius = 5
        carsLicensePlateNumbersTextField2.layer.cornerRadius = 5
        carsLicensePlateNumbersTextField3.layer.cornerRadius = 5
        carsLicensePlateNumbersTextField4.layer.cornerRadius = 5
        carsLicensePlateLettersTextField1.layer.cornerRadius = 5
        carsLicensePlateLettersTextField2.layer.cornerRadius = 5
        carsLicensePlateLettersTextField3.layer.cornerRadius = 5
        carsColorTextField.layer.cornerRadius = 5
    }
    
    
    @IBAction func addTicketButtonPressed(_ sender: UIButton) {
        
        validateFields()
        
        guard let ticketName = ticketNameField.text, !ticketName.isEmpty,
              let ticketType = TicketType(id: ticketType.selectedRow(inComponent: 0)),
              let driversName = driversNameTextField.text, !driversName.isEmpty,
              let carsModel = carsModelTextField.text, !carsModel.isEmpty,
              let carsColor = carsColorTextField.text,  !carsColor.isEmpty else {
            return
        }
        
        guard let letter1 = carsLicensePlateLettersTextField1.text, !letter1.isEmpty,
        let letter2 = carsLicensePlateLettersTextField2.text, !letter2.isEmpty,
        let letter3 = carsLicensePlateLettersTextField3.text, !letter3.isEmpty,
        let number1 = carsLicensePlateNumbersTextField1.text, !number1.isEmpty,
        let number2 = carsLicensePlateNumbersTextField2.text, !number2.isEmpty,
        let number3 = carsLicensePlateNumbersTextField3.text, !number3.isEmpty,
        let number4 = carsLicensePlateNumbersTextField4.text, !number4.isEmpty else {
            return
        }
        
        let date = datePicker.date.timeIntervalSince1970
        let licencePlate = "\(letter1)\(letter2)\(letter3) \(number1)\(number2)\(number3)\(number4)"
        
        let ticket = Ticket(ticketName: ticketName, ticketType: ticketType, expectedDeliveryDate: date, driversName: driversName, carsModel: carsModel, licencePlate: licencePlate, carsColor: carsColor)
        
        print("Succes making ticket \(ticket)")
        
            AF.responseWithData(TicketRouter.create(ticket: ticket), type: Ticket.self) {
                data, error in
                
                guard let data = data else {
                    guard let error = error else{
                        return
                    }
                    
                    if let error = error as? ErrorResponse {
                        print(error.name)
                    } else {
                        print("Unexpected error \(error)")
                    }
                    
                    return
                }
                
                print(data)
                
            }

        
    }
    
    func validateFields(){
        
        
        if let text = ticketNameField.text , text.isEmpty {
            showError(forTextField: ticketNameField)
        }
        
        if let text = driversNameTextField.text , text.isEmpty {
            showError(forTextField: driversNameTextField)
        }
        
        if let text = carsModelTextField.text , text.isEmpty {
            showError(forTextField: carsModelTextField)
        }
        
        if let text = carsColorTextField.text , text.isEmpty {
            showError(forTextField: carsColorTextField)
        }
        
        if let text = carsLicensePlateLettersTextField1.text , text.isEmpty {
            showError(forTextField: carsLicensePlateLettersTextField1)
        }
        
        if let text = carsLicensePlateLettersTextField2.text , text.isEmpty {
            showError(forTextField: carsLicensePlateLettersTextField2)
        }
        
        if let text = carsLicensePlateLettersTextField3.text , text.isEmpty {
            showError(forTextField: carsLicensePlateLettersTextField3)
        }
        
        if let text = carsLicensePlateNumbersTextField1.text , text.isEmpty {
            showError(forTextField: carsLicensePlateNumbersTextField1)
        }
        
        if let text = carsLicensePlateNumbersTextField2.text , text.isEmpty {
            showError(forTextField: carsLicensePlateNumbersTextField2)
        }
        
        if let text = carsLicensePlateNumbersTextField3.text , text.isEmpty {
            showError(forTextField: carsLicensePlateNumbersTextField3)
        }
        
        if let text = carsLicensePlateNumbersTextField4.text , text.isEmpty {
            showError(forTextField: carsLicensePlateNumbersTextField4)
        }
        
    }
    
    func showError(forTextField textField: UITextField){
        textField.layer.borderWidth = 0.5
        textField.layer.masksToBounds = true
        textField.layer.borderColor = UIColor.red.cgColor
    }
    
}


extension AddTicketsController: UITextFieldDelegate, UITextPasteDelegate {
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == ticketNameField ||
              textField == driversNameTextField ||
              textField == carsModelTextField ||
              textField == carsColorTextField {
            return true
        }
        
        
        
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 0

//        #warning("Update to actual border color")
        textField.layer.borderColor = UIColor.gray.cgColor
    }
}

extension AddTicketsController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return TicketType.types.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return TicketType.types[row].rawValue
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
    let expectedDeliveryDate: TimeInterval
    let driversName: String
    let carsModel: String
    let licencePlate: String
    let carsColor: String
}
