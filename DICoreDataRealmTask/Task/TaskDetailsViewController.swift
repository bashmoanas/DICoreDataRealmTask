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

enum ViewControllers {
    case addNew
    case update
}

class TaskDetailsViewController: UITableViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var taskNameTextField: UITextField!
    
    // MARK: - Variables

    
    var taskStore = TaskStore(taskStore: CDTaskRepository())
    var task: Task!
    var commingFrom = ViewControllers.addNew
    weak var delegate: TaskCreationProtocol?
//    let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTask))
//    let saveItem =
    let updateButton = UIBarButtonItem(title: "Update", style: .done, target: self, action: #selector(didPressUpdateTask))
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch commingFrom {
        case .addNew:
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTask))
//            print("Add new task")
        case .update:
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Update", style: .plain, target: self, action: #selector(didPressUpdateTask))
            taskNameTextField.text = task.name
//            print("updating")
        }
        
//        updateSaveButtonState()
        
//        guard let task = task else {
//
//            return
//        }
        
//        navigationItem.rightBarButtonItem = updateButton
//
    }
    
    // MARK: - Helper Methods
    
//    private func updateSaveButtonState() {
//        let taskName = taskNameTextField.text ?? ""
//        navigationItem.leftBarButtonItem?.isEnabled = taskName.isEmpty
//    }
    
    private func dismissViewController() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
//    private func popViewController() {
//        let allTasksViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "allTasksViewController") as! TaskDetailsViewController
//        navigationController?.popToViewController(allTasksViewController, animated: true)
//
//    }
    
    // MARK: - Actions
    
    @IBAction func textEditingChanged(_sender: UITextField) {
//        updateSaveButtonState()
    }
    
    @objc func saveTask() {
        guard let taskName = taskNameTextField.text, !taskName.isEmpty else { return }
        
        let task = Task(id: UUID(), name: taskName)
        taskStore.createTask(task)
        delegate?.userCreated(task)
        
        dismissViewController()
    }
    
    @objc func didPressUpdateTask() {
        guard let taskName = taskNameTextField.text, !taskName.isEmpty else { return }
        
        let updatedTask = Task(id: task.id, name: taskName)
        taskStore.updateTask(updatedTask)
        delegate?.userUpdated(task)
        
        navigationController?.popViewController(animated: true)
    }
    
}
