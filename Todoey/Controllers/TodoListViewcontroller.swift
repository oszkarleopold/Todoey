//
//  ViewController.swift
//  Todoey
//
//  Created by Leopold Oszkár on 2018. 02. 08..
//  Copyright © 2018. Leopold Oszkár. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Find Mike"
        
        itemArray.append(newItem)
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Items] {
            itemArray = items
        }
        
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    //MARK - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        
                                                                                                        //        if item.done == true {
                                                                                                        //            cell.accessoryType = .checkmark
                                                                                                        //        }
                                                                                                        //        else {
                                                                                                        //            cell.accessoryType = .none
                                                                                                        //        }
        
        return cell
    }
    
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  print (itemArray[indexPath.row])

        itemArray[indexPath.row].done = !(itemArray[indexPath.row].done)
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)

    
    }
    
    //MARK - Add new items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField() //Placeholder variable, hogy az alerthez adott textfieldből ki tudjuk nyerni a user által beírt adatot
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction (title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the add item button on our UIAlert
            
            let newItem = Item()
            
            newItem.title = textField.text!
            
            self.itemArray.append(newItem) // Hozzáadjuk az arrayhez az újonnan beírt stringet
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData() //De reloadolni kell a datát, hogy megjelenjen a tableviewban
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    


    


}

