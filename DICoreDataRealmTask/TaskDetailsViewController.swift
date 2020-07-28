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
    
    private func updateSaveButtonState() {
        let taskName = taskNameTextField.text ?? ""
        saveButton.isEnabled = !taskName.isEmpty
    }
    
    @IBAction func textEditingChanged(_sender: UITextField) {
        updateSaveButtonState()
    }
    
    @IBAction func saveTask(_ sender: UIBarButtonItem) {
        guard let taskName = taskNameTextField.text else { return }
        
        let task = Task(name: taskName)
        
        taskStore.createTask(task)
        
    }
}
