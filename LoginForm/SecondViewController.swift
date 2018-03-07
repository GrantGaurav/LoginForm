//
//  SecondViewController.swift
//  LoginForm
//
//  Created by Grant Gaurav on 2/13/18.
//  Copyright © 2018 Grant Gaurav. All rights reserved.
//

import UIKit
import CoreData
class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var textBox: UITableView!
    var userName: [Users] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        userName = CoreDataHandler.fetchObject()!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let name = userName[indexPath.row]
        cell.textLabel!.text = name.firstname! + " " + name.lastname!
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let user = userName[indexPath.row]
            userName.remove(at: indexPath.row)
            let _ = CoreDataHandler.deleteObject(user: user)
            textBox.reloadData()
        }
    }
    func sortList(filter: String? = nil) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: filter, ascending: true)]
        do {
            userName = try context.fetch(fetchRequest) as! [Users]
        }
        catch {
            print("error")
            
        }
        textBox.reloadData()
    }
    //button tapped
    
    
    @IBAction func selectFilter(_ sender: AnyObject) {
        let sheet = UIAlertController(title: "Filter Option", message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{
            (action)-> Void in
        }))
        sheet.addAction(UIAlertAction(title: "FirstName", style: .default, handler:{
            (action)-> Void in
            self.sortList(filter: "firstname")
        }))
        sheet.addAction(UIAlertAction(title: "LastName", style: .default, handler:{
            (action)-> Void in
            self.sortList(filter: "lastname")
        }))
        sheet.addAction(UIAlertAction(title: "Standard", style: .default, handler:{
            (action)-> Void in
            self.sortList(filter: "standard")
        }))
        sheet.addAction(UIAlertAction(title: "Age", style: .default, handler:{
            (action)-> Void in
            self.sortList(filter: "age")
        }))
        sheet.addAction(UIAlertAction(title: "DateOfBirth", style: .default, handler:{
            (action)-> Void in
            self.sortList(filter: "dateofbirth")
        }))
        present(sheet, animated: true, completion: nil)
    }
    @IBAction func previousView(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
