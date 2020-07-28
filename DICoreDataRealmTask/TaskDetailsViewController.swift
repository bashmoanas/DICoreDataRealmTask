//
//  TaskDetailsViewController.swift
//  DICoreDataRealmTask
//
//  Created by Anas Bashandy on 26/7/20.
//  Copyright © 2020 Anas Bashandy. All rights reserved.
//

import UIKit

class TaskDetailsViewController: UITableViewController {
    
    @IBOutlet var taskNameTextField: UITextField!
    @IBOutlet var saveButton: UIBarButtonItem!
    
//    var task: Task!
    
    var taskStore = TaskStore(taskStore: CDTaskRepository())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        if let task = task {
//            taskNameTextField.text = task.name
//        }
        
        updateSaveButtonState()
    }
    
    // MARK: - Helper Methods
    
    private func updateSaveButtonState() {
        let taskName = taskNameTextField.text ?? ""
        saveButton.isEnabled = !taskName.isEmpty
    }
    
    private func unwindToAllTasksViewController() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - Actions
    
    @IBAction func textEditingChanged(_sender: UITextField) {
        updateSaveButtonState()
    }
    
    @IBAction func saveTask(_ sender: UIBarButtonItem) {
        guard let taskName = taskNameTextField.text else { return }
        
        let task = Task(name: taskName)
        taskStore.createTask(task)

        unwindToAllTasksViewController()
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        unwindToAllTasksViewController()
    }
}




//@IBAction func goBackToFirstVC(sender: UIButton) {
//    guard let controllers = navigationController?.viewControllers else { return }
//    let count = controllers.count
//    if count > 2 {
//        // Third from the last is the viewController we want
//        if let firstVC = controllers[count - 3] as? FirstViewController {
//            // pass back some data
//            firstVC.someProperty = someData
//            firstVC.someOtherProperty = moreData
//
//            navigationController?.popToViewController(firstVC, animated: true)
//        }
//    }
//}
