//
//  AddTicketsViewController.swift
//  Tickets
//
//  Created by Abdullah Alhomaidhi on 30/10/2020.
//

import UIKit
import Alamofire

class AddTicketsController: UIViewController {
    
    @IBOutlet var ticketNameField: TextField!
    @IBOutlet var driversNameTextField: TextField!
    @IBOutlet var carsModelTextField: TextField!
    
    @IBOutlet var carsLicensePlateNumbersTextField1: TextField!
    @IBOutlet var carsLicensePlateNumbersTextField2: TextField!
    @IBOutlet var carsLicensePlateNumbersTextField3: TextField!
    @IBOutlet var carsLicensePlateNumbersTextField4: TextField!

    @IBOutlet var carsLicensePlateLettersTextField1: TextField!
    @IBOutlet var carsLicensePlateLettersTextField2: TextField!
    @IBOutlet var carsLicensePlateLettersTextField3: TextField!

    @IBOutlet var carsColorTextField: TextField!
    
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var ticketType: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.minimumDate = Date()
    }
    
    @IBAction func addTicketButtonPressed(_ sender: UIButton) {
        
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
    
}


extension AddTicketsController: UITextFieldDelegate, UITextPasteDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let textField = textField as? TextField else {
            return
        }
        
        textField.validate()
    }
    
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
