//
//  ViewController.swift
//  LoginForm
//
//  Created by Grant Gaurav on 2/13/18.
//  Copyright © 2018 Grant Gaurav. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        submit.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        /*firstName.text = ""
        lastName.text = ""
        standard.text = ""
        age.text = ""
        dateOfBirth.text = ""
        submit.isHidden = true*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveData(_ sender: Any) {
        if firstName.text != "" && lastName.text != "" && standard.text != "" && age.text != "" && dateOfBirth.text != "" {
            let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
            newUser.setValue(firstName.text, forKey: "firstname")
            newUser.setValue(lastName.text, forKey: "lastname")
            newUser.setValue(standard.text, forKey: "standard")
            newUser.setValue(age.text, forKey: "age")
            newUser.setValue(dateOfBirth.text, forKey: "dateofbirth")
            do {
                try context.save()
                print("Saved")
                submit.isHidden = false
                
            }
            catch {
                print("Error")
            }
        }
    }
    
    @IBAction func nextView(_ sender: Any) {
        performSegue(withIdentifier: "nextView", sender: self)
    }
}

