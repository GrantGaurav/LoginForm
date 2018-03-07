//
//  HelperFunctions.swift
//  LoginForm
//
//  Created by Grant Gaurav on 2/27/18.
//  Copyright © 2018 Grant Gaurav. All rights reserved.
//

import Foundation
import UIKit

func isValidDate(dateString: String) -> Bool {
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "dd-MM-yyyy"
    if let _ = dateFormatterGet.date(from: dateString) {
        return true
    } else {
        return false
    }
}

func isValidInput(Input:String) -> Bool {
    let myCharSet=CharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
    let output: String = Input.trimmingCharacters(in: myCharSet.inverted)
    let isValid: Bool = (Input == output)
    return isValid
}

//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
//            nextField.becomeFirstResponder()
//        }
//        else {
//            textField.resignFirstResponder()
//            return true;
//        }
//        return false
//    }



