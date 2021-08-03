//
//  ClassListTableViewController.swift
//  Langdacity
//
//  Created by Paul Willis on 30/07/2021.
//

import UIKit

class ClassListTableViewController: UITableViewController {
    
    //TODO: Extract this from user defaults?
    var user: Teacher?
    var classes: [Class]?

    
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user!.classes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Class", for: indexPath)
        cell.textLabel?.text = classes![indexPath.row].name
                
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ClassViewSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextViewController = segue.destination as! ClassViewController
        guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
        
        nextViewController.title = classes![indexPath.row].name
        nextViewController.classObj = classes![indexPath.row]
    }




}
