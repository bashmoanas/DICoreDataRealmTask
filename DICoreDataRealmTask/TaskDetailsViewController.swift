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
    var selectedTask: Task? { didSet { taskStore.updateTask(selectedTask!) } }
    weak var delegate: TaskCreationProtocol?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTask))
        
        updateSaveButtonState()
        
        guard let task = task else { return }
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
}
