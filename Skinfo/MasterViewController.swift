//
//  MasterViewController.swift
//  Skinfo
//
//  Created by Liam Hogan on 2/18/20.
//  Copyright © 2020 Liam Hogan. All rights reserved.
//

import UIKit

//====================================================================================================

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [Any]()
    
    //Array of all SkiArea objects: storage.allSkiAreas (See Storage.swift field value)
    var storage = Storage()
    
    //----------------------------------------------------------------------------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }
    
    //----------------------------------------------------------------------------------------------------

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }
    
    //----------------------------------------------------------------------------------------------------

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let skiArea = storage.allSkiAreas[indexPath.row]
                let detailViewController = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                detailViewController.skiArea = skiArea
            }
        }
    }
    
    //----------------------------------------------------------------------------------------------------

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //----------------------------------------------------------------------------------------------------

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storage.allSkiAreas.count
    }
    
    //----------------------------------------------------------------------------------------------------

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SkiAreaCell", for: indexPath) as! SkiAreaCell
        let skiArea = storage.allSkiAreas[indexPath.row]
        //cell.textLabel!.text = skiArea.name
        cell.skiAreaImageView.image = UIImage(named: skiArea.name);
    
        return cell
    }
    
    //----------------------------------------------------------------------------------------------------

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    //----------------------------------------------------------------------------------------------------

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

    //----------------------------------------------------------------------------------------------------

}

