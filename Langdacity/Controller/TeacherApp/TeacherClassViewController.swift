//
//  ClassViewController.swift
//  Langdacity
//
//  Created by Paul Willis on 31/07/2021.
//

import UIKit

class TeacherClassViewController: UIViewController {
    
    var classObj: Class?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
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
