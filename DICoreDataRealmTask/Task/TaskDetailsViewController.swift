//
//  TaskDetailsViewController.swift
//  DICoreDataRealmTask
//
//  Created by Anas Bashandy on 26/7/20.
//  Copyright © 2020 Anas Bashandy. All rights reserved.
//

import UIKit

protocol TaskCreationProtocol: class {
    func userCreated(_ task: Task)
    func userUpdated(_ task: Task)
}

class TaskDetailsViewController: UITableViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var taskNameTextField: UITextField!
    
    // MARK: - Variables
    
    var taskStore = TaskStore(taskStore: CDTaskRepository())
    var task: Task!
    weak var delegate: TaskCreationProtocol?
    let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTask))
    let updateButton = UIBarButtonItem(title: "Update", style: .done, target: self, action: #selector(updateTask))
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateSaveButtonState()
        
        guard let task = task else {
            navigationItem.rightBarButtonItem = saveButton
            return
        }
        
        navigationItem.rightBarButtonItem = updateButton
        taskNameTextField.text = task.name
    }
    
    // MARK: - Helper Methods
    
    private func updateSaveButtonState() {
        let taskName = taskNameTextField.text ?? ""
        navigationItem.leftBarButtonItem?.isEnabled = taskName.isEmpty
    }
    
    private func dismissViewController() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    private func popViewController() {
        let allTasksViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "allTasksViewController") as! TaskDetailsViewController
        navigationController?.popToViewController(allTasksViewController, animated: true)
        
    }
    
    // MARK: - Actions
    
    @IBAction func textEditingChanged(_sender: UITextField) {
        updateSaveButtonState()
    }
    
    @objc func saveTask() {
        guard let taskName = taskNameTextField.text else { return }
        let task = Task(name: taskName)
        taskStore.createTask(task)
        delegate?.userCreated(task)
        
        dismissViewController()
    }
    
    @objc func updateTask() {
        guard let taskName = taskNameTextField.text else { return }
        let task = Task(name: taskName)
        guard taskStore.updateTask(task) else { return }
        delegate?.userUpdated(task)
    }
    
}
