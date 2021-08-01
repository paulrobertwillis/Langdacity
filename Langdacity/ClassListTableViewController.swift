//
//  ClassListTableViewController.swift
//  Langdacity
//
//  Created by Paul Willis on 30/07/2021.
//

import UIKit

class ClassListTableViewController: UITableViewController {
    
    //TODO: Extract this from user defaults?
    var teacher = JsonInterface.decodeTeacherFromJSON(teacherUUID: "PROF-0001")!

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teacher.classes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Class", for: indexPath)
        cell.textLabel?.text = teacher.classes[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        performSegue(withIdentifier: "ClassViewSegue", sender: self)
        
//        if let vc = storyboard?.instantiateViewController(withIdentifier: "ClassHomepage") {
//
//            vc.title = teacher.classes[indexPath.row].name
//
//            navigationController?.pushViewController(vc, animated: true)
//
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextViewController = segue.destination as! ClassViewController
        guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
        
        nextViewController.title = teacher.classes[indexPath.row].name
        nextViewController.classObj = teacher.classes[indexPath.row]
    }




}
