//
//  ClassViewController.swift
//  Langdacity
//
//  Created by Paul Willis on 31/07/2021.
//

import UIKit

class TeacherClassViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaderboard!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClassLeaderboardTableViewCell", for: indexPath)
        
        // create position of two digits as string
        let intPosition = indexPath.row + 1
        var stringPosition = ""
        
        stringPosition = String(intPosition)
        
        // add -st, -nd, -rd, -th to int
        if stringPosition.hasSuffix("1") {
            stringPosition.append("st")
        } else if stringPosition.hasSuffix("2") {
            stringPosition.append("nd")
        } else if stringPosition.hasSuffix("3") {
            stringPosition.append("rd")
        } else {
            stringPosition.append("th")
        }
        
        cell.textLabel?.text = "\(stringPosition): \(leaderboard![indexPath.row].key)"
        cell.detailTextLabel?.text = "\(leaderboard![indexPath.row].value)pts"
        
        if cell.textLabel?.text?.hasPrefix("1st") == true {
            cell.backgroundColor = .systemYellow
        } else if cell.textLabel?.text?.hasPrefix("2nd") == true {
            cell.backgroundColor = .systemGray
        } else if cell.textLabel?.text?.hasPrefix("3rd") == true {
            cell.backgroundColor = .systemOrange
        }
            
        if delegate?.user?.getFullName() == leaderboard![indexPath.row].key {
            cell.textLabel?.font = UIFont.systemFont(ofSize: (cell.textLabel?.font.pointSize)!, weight: .bold)
            cell.detailTextLabel?.font = UIFont.systemFont(ofSize: (cell.textLabel?.font.pointSize)!, weight: .bold)
            
        }
        
        return cell
    }
    
    @IBOutlet var classLeaderboardTableView: UITableView!
    
    @IBOutlet var assignedHomeworkTableView: UITableView!
    
    var leaderboard: [Dictionary<String, Int>.Element]? {
        get {
            updateLeaderboard()
        }
    }
    
    var delegate: TeacherClassListTableViewController?
    var classObj: Class?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        classLeaderboardTableView.delegate = self
        classLeaderboardTableView.dataSource = self
        classLeaderboardTableView.rowHeight = 30
        
        assignedHomeworkTableView.rowHeight = 30
        
    }
    
    func updateLeaderboard() -> [Dictionary<String, Int>.Element]? {
        do {
            let decoder = JSONDecoder()
            let encoder = JSONEncoder()
            let dataToSend = try encoder.encode(classObj?.UUID)
            let dataFetched = Server.fetchClassLeaderboard(data: dataToSend)!
            let leaderboardArray = try decoder.decode([String:Int].self, from: dataFetched)

            let sortedLeaderboard = leaderboardArray.sorted { (first, second) -> Bool in
                if first.value > second.value {
                    return first.value > second.value
                } else {
                    return first.key < second.key
                }
            }
            return sortedLeaderboard
            
        } catch {
            print("Error in \(self) function \(#function): Unknown error")
        }
        return nil
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        enum prepareSegueErrors: Error {
            case cannotEncodeArrayToData
            case cannotFetchStudentsFromServer
            case cannotDecodeStudentArrayFromData
        }
        
        do {
            if segue.identifier == "ShowAllStudents" {
                let nextViewController = segue.destination as! TeacherStudentTableViewController
                
                guard let dataToSend = JsonInterface.encodeToJsonAsData(stringArray: classObj!.students) else {
                    throw prepareSegueErrors.cannotEncodeArrayToData
                }
                guard let dataFetched = Server.fetchStudents(data: dataToSend) else {
                    throw prepareSegueErrors.cannotFetchStudentsFromServer
                }
                guard let students = JsonInterface.decodeStudentArrayFromJsonData(data: dataFetched) else {
                    throw prepareSegueErrors.cannotDecodeStudentArrayFromData
                }
                nextViewController.students = students
            }
        } catch prepareSegueErrors.cannotEncodeArrayToData {
            print("Error in \(self) function \(#function): Cannot encode array to data")
        } catch prepareSegueErrors.cannotFetchStudentsFromServer {
            print("Error in \(self) function \(#function): Cannot fetch student data from server")
        } catch prepareSegueErrors.cannotDecodeStudentArrayFromData {
            print("Error in \(self) function \(#function): Cannot decode data from server")
        } catch {
            print("Error in \(self) function \(#function): Unknown error")
        }
    }
}
