//
//  StudentClassListTableViewController.swift
//  Langdacity
//
//  Created by Paul Willis on 04/08/2021.
//

import UIKit

class StudentClassListTableViewController: UITableViewController {
    
    //TODO: Extract this from user defaults?
    var user: Student?
    var classes: [Class]?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(user)
        
        do {
            let decoder = JSONDecoder()
            let encoder = JSONEncoder()
            let dataToSend = try encoder.encode(user?.classUUID)
            let dataFetched = Server.fetchClasses(data: dataToSend)
            classes = try decoder.decode([Class].self, from: dataFetched!)
        } catch {
            print("Error in \(self) function \(#function): Unknown error")
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if user != nil {
            return user!.classUUID.count
        }
        
        return 0
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
        let nextViewController = segue.destination as! StudentClassViewController
        guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
        
        nextViewController.title = classes![indexPath.row].name
    }




}
