//
//  StudentTableViewController.swift
//  Langdacity
//
//  Created by Paul Willis on 31/07/2021.
//

import UIKit

class TeacherStudentTableViewController: UITableViewController {
    
    var students: [Student]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Invite", style: .plain, target: self, action: #selector(addStudent))

    }
    
    @objc func addStudent() {
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if students != nil {
            return students!.count
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Student", for: indexPath)
        cell.textLabel?.text = students?[indexPath.row].getFullName()

        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let nextViewController = segue.destination
        let senderCell = sender as! UITableViewCell
        nextViewController.title = senderCell.textLabel?.text
    }

}
