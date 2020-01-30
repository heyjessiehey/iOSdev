//
//  CourseList.swift
//  MyCourses
//
//  Created by Jessie Gayeon Ko on 2020-01-25.
//  Copyright © 2020 Jessie Gayeon Ko. All rights reserved.
//

import UIKit

struct Courses: Codable {
    var id: Int
    var courseCode: String
    var courseName: String
}
   
struct PackageCourses: Codable {
    var student: String
    var timestamp: Date
    var count: Int
    var version: String
    var data: [Courses] = []
}

class CourseList: UITableViewController {
    
    var myPackage: PackageCourses?
    var checkedRow: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
           
        let url  = URL(string: "https://raw.githubusercontent.com/heyjessiehey/map523data/master/map523data.json")
           
        if let newData = doRequest(url: url!) {
            myPackage = newData
            tableView.reloadData()
        }
        
        if let name = myPackage?.student {
            title = "\(name) Courses"
        }
    }
    
    func doRequest(url: URL) -> PackageCourses? {
        // A do-catch statement handles errors
        // For the following, if there is an error, "catch" returns nil
        do {
            
            
            // Attempt to get the data from the web API
            let data = try Data(contentsOf: url)
            
            // Create and configure a JSON decoder
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            // Attempt to decode the data into a "PackageCourses" object
            let result = try decoder.decode(PackageCourses.self, from: data)
            
            // If it gets this far, it has been successful
            return result
        }
        catch {
            // Uh oh, error
            print("Request error: \(error.localizedDescription)")
            return nil
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let available = myPackage?.data.count{
            return available
        } else {
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "default", for: indexPath)

        if let coursecode = myPackage?.data[indexPath.row].courseCode {
            cell.textLabel?.text = coursecode
        }
        
        if let coursename = myPackage?.data[indexPath.row].courseName {
            cell.detailTextLabel?.text = coursename
        }

        return cell
    }
    
    // The iOS runtime calls this whenever the user taps on a row
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
       // First, if a previous row was check-marked, clear it
       // Swift "if let" is a good way to prevent null/nil reference errors
       if let previouslyChecked = checkedRow {
         tableView.cellForRow(at: previouslyChecked)?.accessoryType = .none
       }

       // Then, check-mark the row, deselect the row, and remember it
       tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
       tableView.deselectRow(at: indexPath, animated: true)
       checkedRow = indexPath
   }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
