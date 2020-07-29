//
//  AllTasksViewController.swift
//  DICoreDataRealmTask
//
//  Created by Anas Bashandy on 26/7/20.
//  Copyright © 2020 Anas Bashandy. All rights reserved.
//

import UIKit

class AllTasksViewController: UITableViewController, TaskCreationProtocol {
    
    // MARK: - Variables
    
    var taskStore = TaskStore(taskStore: CDTaskRepository())
    
    // MARK: - View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        taskStore.allTasks = taskStore.fetchTasks() ?? [Task]()
    }
    
    // MARK: - Table View Data Source Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskStore.taskCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        let task = taskStore.getTaskAt(index: indexPath.row)
        configure(cell, withTask: task)
        
        return cell
    }
    
    // MARK: - Table View Delegates Methods
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = taskStore.getTaskAt(index: indexPath.row)
            taskStore.deleteTask(task)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTask = taskStore.getTaskAt(index: indexPath.row)
        pushToTaskDetailsViewController(withTask: selectedTask)
    }
    
    // MARK: - Data Passing
    
    func userCreated(_ task: Task) {
        let newIndexPath = IndexPath(row: taskStore.allTasks.count, section: 0)
        taskStore.allTasks.append(task)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
    
    func userUpdated(_ task: Task) {
        taskStore.allTasks = taskStore.allTasks
        tableView.reloadData()
    }
    
    // MARK: - Helper Methods
    
    private func presentTaskDetailsViewController() {
        let taskDetailsViewController = TaskDetailsViewController.instantiateViewController(fromStoryboard: .main)
        taskDetailsViewController.commingFrom = .addNew
        let navigationController = UINavigationController(rootViewController: taskDetailsViewController)
        taskDetailsViewController.taskStore = taskStore
        taskDetailsViewController.delegate = self
        present(navigationController, animated: true, completion: nil)
    }
    
    private func presentCategoriesViewController() {
        let cagegoriesViewController = CategoriesViewController.instantiateViewController(fromStoryboard: .main)
        let navigationController = UINavigationController(rootViewController: cagegoriesViewController)
        present(navigationController, animated: true, completion: nil)
    }
    
    private func pushToTaskDetailsViewController(withTask task: Task) {
        let taskDetailsViewController = TaskDetailsViewController.instantiateViewController(fromStoryboard: .main)
        taskDetailsViewController.commingFrom = .update
        taskDetailsViewController.task = task
        taskDetailsViewController.delegate = self
        navigationController?.pushViewController(taskDetailsViewController, animated: true)
    }
    
    private func configure(_ cell: UITableViewCell, withTask task: Task) {
        cell.textLabel?.text = task.name
    }
    
    private func showAlert() {
        let alertConroller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertConroller.addAction(cancelAction)
        
        let addCategoryAction = UIAlertAction(title: "Add a category", style: .default) { (action) in
            self.presentCategoriesViewController()
        }
        alertConroller.addAction(addCategoryAction)
        
        let addTaskAction = UIAlertAction(title: "Add a task", style: .default) { (action) in
            self.presentTaskDetailsViewController()
        }
        alertConroller.addAction(addTaskAction)
        
        present(alertConroller, animated: true, completion: nil)
    }
    
    // MARK: - Actions
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        showAlert()
    }
}
