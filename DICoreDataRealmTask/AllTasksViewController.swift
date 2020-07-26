//
//  AllTasksViewController.swift
//  DICoreDataRealmTask
//
//  Created by Anas Bashandy on 26/7/20.
//  Copyright © 2020 Anas Bashandy. All rights reserved.
//

import UIKit

class AllTasksViewController: UITableViewController {
        
    var taskStore: TaskStore!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskStore.taskCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        let task = taskStore.getTaskAt(index: indexPath.row)
        cell.textLabel?.text = task.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = taskStore.getTaskAt(index: indexPath.row)
            taskStore.removeTask(task)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "EditTask" {
            let indexPath = tableView.indexPathForSelectedRow!
            let task = taskStore.getTaskAt(index: indexPath.row)
            let taskDetailsViewController = segue.destination as! TaskDetailsViewController
            taskDetailsViewController.task = task
        }
    }
    
    @IBAction func unwindToAllTaskViewController(_ segue: UIStoryboardSegue) {
        guard segue.identifier == "SaveUnwind",
            let taskDetailsViewController = segue.source as? TaskDetailsViewController,
            let task = taskDetailsViewController.task else { return }
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            taskStore.allTasks[selectedIndexPath.row] = task
        } else {
            let newIndexPath = IndexPath(row: taskStore.allTasks.count, section: 0)
            taskStore.allTasks.append(task)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
}
