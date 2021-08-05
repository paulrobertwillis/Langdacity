//
//  TeacherClassListTableViewController.swift
//  Langdacity
//
//  Created by Paul Willis on 30/07/2021.
//

import UIKit

class TeacherClassListTableViewController: UITableViewController {
    
    //TODO: Extract this from user defaults?
    var user: Teacher?
    var classes: [Class]?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editClassList))
        
    }
    
    @objc func editClassList() {
        
//        updateClassList()
    }
    
    func updateClassList() {
        guard let dataToSend = JsonInterface.encodeToJsonAsData(stringArray: user!.classes) else { return }
        guard let dataFetched = Server.fetchClasses(data: dataToSend) else { return }
        guard let fetchedClasses = JsonInterface.decodeClassArrayFromJsonData(data: dataFetched) else { return }
        self.classes = fetchedClasses
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
        let nextViewController = segue.destination as! TeacherClassViewController
        guard let indexPath = self.tableView.indexPathForSelectedRow else { return }
        
        nextViewController.title = classes![indexPath.row].name
        nextViewController.classObj = classes![indexPath.row]
        nextViewController.delegate = self
    }




}
