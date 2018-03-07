//
//  MainViewController.swift
//  LoginForm
//
//  Created by Grant Gaurav on 2/13/18.
//  Copyright © 2018 Grant Gaurav. All rights reserved.
//

import UIKit
import CoreData
class MainViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var standard: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var dateOfBirth: UITextField!
    
    var activeTextField: UITextField!
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        standard.delegate = self
        age.delegate = self
        firstName.delegate = self
        lastName.delegate = self
        dateOfBirth.delegate = self
        let tooBar: UIToolbar = UIToolbar()
        tooBar.barStyle = UIBarStyle.blackTranslucent
        tooBar.items=[
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(MainViewController.donePressed))]
        tooBar.sizeToFit()
        standard.inputAccessoryView = tooBar
        age.inputAccessoryView = tooBar
        dateOfBirth.inputAccessoryView = tooBar
    }
    
    @objc func donePressed ()  {
        if activeTextField == standard{
            standard.resignFirstResponder()
            age.becomeFirstResponder()
        }
        else if activeTextField == age {
            age.resignFirstResponder()
            dateOfBirth.becomeFirstResponder()
        }
        else {
            dateOfBirth.resignFirstResponder()
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
         firstName.text = ""
         lastName.text = ""
         standard.text = ""
         age.text = ""
         dateOfBirth.text = ""
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 5 {
        if var number = textField.text, string != "" {
            if number.count == 2 || number.count == 5 {
                number += "-"
                textField.text = number
            }
            if number.count == 10 {
                return false
            }
            textField.text = number
        }
            return true
        }
        return true
    }
    
    @IBAction func saveData(_ sender: Any) {
        if firstName.text == "" || lastName.text == "" || standard.text == "" || age.text == "" || dateOfBirth.text == "" {
            showAlert(string: "Fill all the detailss")
        }
        else if isValidInput(Input: firstName.text!) == false || isValidInput(Input: lastName.text!) == false {
            showAlert(string: "Name field only accept alphabet")
        }
        else if isValidDate(dateString: dateOfBirth.text!) == false{
            showAlert(string: "Date should be in proper format")
        }
        else {
            let save = CoreDataHandler.saveObject(firstname: firstName.text!, lastname: lastName.text!, standard: standard.text!, age: age.text!, dateofbirth: dateOfBirth.text!)
            if save == true {
                performSegue(withIdentifier: "nextView", sender: self)
            }
        }
    }
    
    func showAlert(string:String) {
        let alert = UIAlertController(title: "", message: string, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
