//
//  AllTasksViewController.swift
//  DICoreDataRealmTask
//
//  Created by Anas Bashandy on 26/7/20.
//  Copyright © 2020 Anas Bashandy. All rights reserved.
//

import UIKit
import DropDown

class AllTasksViewController: UIViewController {
    
    // MARK: - Variables
    
    @IBOutlet weak var dropDownButton: UIBarButtonItem!
    @IBOutlet weak var addCategoryButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var keyboardHeightLayoutConstraint: NSLayoutConstraint!
    
    var allTasksPresenter: AllTasksPresenter!
    
    var allTasks = TaskStore().fetchTasks() ?? []
    
//    var filteredDataSource = [Category]() {
//        didSet {
//            tableView.reloadData()
//        }
//    }
    
//    var allCategories = [Category]()
    
    var currentSection: Int?
    
    var dropDown = DropDown()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allTasksPresenter = AllTasksPresenterImplementation(view: self)
        
        allTasksPresenter.allCategories = allTasksPresenter.fetchAllCategories()
        allTasksPresenter.filteredCategories = allTasksPresenter.allCategories
        
        tableView.register(UINib(nibName: "CategoryHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "CategoryHeader")
        tableView.register(UINib(nibName: "TaskCell", bundle: nil), forCellReuseIdentifier: "TaskCell")
        
        title = "All Tasks"
        
        registerForKeyboardNotifications()
        setupAddTaskButtonApearance()
        hideTaskTextField()
    }
    
    // MARK: - Helper Methods
    
    private func promptForCategory() {
//        let alertPresenter = AlertPresenter(title: "Add Category", confirmTitle: "Add", cancelTitle: "Cancel", handler: { outcome in
//                switch outcome {
//                case .confirmed:
//                    break
//                case .cancelled:
//                    break
//                }
//            }
//        )
//        alertPresenter.present(in: self)
        
        
                let alertController = UIAlertController(title: "Add Category", message: nil, preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                alertController.addAction(cancelAction)
        
        alertController.addTextField()

        let addAction = UIAlertAction(title: "Add", style: .default) { (action) in
            let userInput = alertController.textFields![0]
            let text = userInput.text ?? ""
            let category = Category(id: UUID(), name: text, isExpanded: true, tasks: nil)
            CategoryStore().createCategory(category)
            self.allTasksPresenter.allCategories = self.allTasksPresenter.fetchAllCategories()
            self.allTasksPresenter.filteredCategories.append(category)
        }
        alertController.addAction(addAction)

        present(alertController, animated: true, completion: nil)
    }
    
    private func setupDropDownMenu() {
        let categoryTitles = allTasksPresenter.allCategories.map { "\($0.name)" }
        let firstCategory = "All Categories"
        dropDown.dataSource = [firstCategory]
        dropDown.dataSource += categoryTitles
        dropDown.anchorView = dropDownButton
        dropDown.width = 200
        dropDown.direction = .bottom
        dropDown.bottomOffset = CGPoint(x: 0, y: (dropDown.anchorView?.plainView.bounds.height)!)
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            if index == 0 {
                self.addCategoryButton.isEnabled = true
                self.currentSection = nil
                self.allTasksPresenter.filteredCategories = self.allTasksPresenter.allCategories
                self.hideTaskTextField()
                self.hideAddTaskButton()
                self.tableView.reloadData()
            } else {
                self.addCategoryButton.isEnabled = false
                self.currentSection = index - 1
                self.allTasksPresenter.filteredCategories = [self.allTasksPresenter.allCategories[self.currentSection ?? 0]]
                self.showTaskTextField()
                self.showAddTaskButton()
                self.tableView.reloadData()
            }
            
        }
    }
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWasShown(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let endFrameY = endFrame?.origin.y ?? 0
            let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
            if endFrameY >= UIScreen.main.bounds.size.height {
                self.keyboardHeightLayoutConstraint?.constant = 0.0
            } else {
                self.keyboardHeightLayoutConstraint?.constant = endFrame?.size.height ?? 0.0
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
    
    @objc func keyboardWillBeHidden(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.view.setNeedsLayout()
        }
    }
    
    private func showTaskTextField() {
        view.bringSubviewToFront(taskTextField)
    }
    
    private func hideTaskTextField() {
        view.sendSubviewToBack(taskTextField)
    }
    
    private func showAddTaskButton() {
        view.bringSubviewToFront(addButton)
    }
    
    private func hideAddTaskButton() {
        view.sendSubviewToBack(addButton)
    }
    
    private func setupAddTaskButtonApearance() {
        guard let text = taskTextField.text, !text.isEmpty else {
            view.sendSubviewToBack(addButton)
            return
        }
        view.bringSubviewToFront(addButton)
    }
    
    // MARK: - Actions
    
    @IBAction func dropDownMenuTapped(_ sender: UIBarButtonItem) {
        setupDropDownMenu()
        dropDown.show()
    }
    
    @IBAction func addCategory(_ sender: UIBarButtonItem) {
        promptForCategory()
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        setupAddTaskButtonApearance()
    }
    
    @IBAction func addTask(_ sender: UIButton) {
        let text = taskTextField.text!
        allTasksPresenter.addTask(withTitle: text)
        tableView.reloadData()
        taskTextField.text = ""
    }
}


extension AllTasksViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return allTasksPresenter.filteredCategories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTasksPresenter.filteredCategories[section].tasks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
        
        guard let task = allTasksPresenter.filteredCategories[indexPath.section].tasks?[indexPath.row] else { fatalError() }
        cell.configure(withTask: task)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let categoryHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CategoryHeader") as! CategoryHeader
        categoryHeader.currentSection = section
        categoryHeader.delegate = self
        
        let category = allTasksPresenter.filteredCategories[section]
        categoryHeader.configure(withCategory: category)
        
        return categoryHeader
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let category = allTasksPresenter.filteredCategories[indexPath.section]
        return category.isExpanded ? UITableView.automaticDimension : 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        tableView.estimatedSectionHeaderHeight = 44.0
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            let task = self.allTasks[indexPath.row]
            TaskStore().deleteTask(task)
            
            let category = self.allTasksPresenter.filteredCategories[indexPath.section]
            category.tasks?.remove(at: indexPath.row)
            CategoryStore().updateCategory(category)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, completionHandler) in
            let alertController = UIAlertController(title: "Edit Task", message: nil, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alertController.addAction(cancelAction)
            
            alertController.addTextField()
            
            let editTaskAction = UIAlertAction(title: "Edit", style: .default) { (action) in
                let userInput = alertController.textFields![0]
                let text = userInput.text ?? ""
                
                self.allTasksPresenter.filteredCategories[indexPath.section].tasks?[indexPath.row].name = text
                CategoryStore().updateCategory(self.allTasksPresenter.filteredCategories[indexPath.section])
                TaskStore().updateTask((self.allTasksPresenter.filteredCategories[indexPath.section].tasks?[indexPath.row])!)
                
                self.allTasksPresenter.allCategories = self.allTasksPresenter.fetchAllCategories()
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            
            alertController.addAction(editTaskAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        editAction.backgroundColor = .systemTeal
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        
        return configuration
    }
}

extension AllTasksViewController: CategoryHeaderDelegate {
    func didTapCategoryHeader(_ categoryHeader: CategoryHeader, atSection section: Int) {
        allTasksPresenter.filteredCategories[section].isExpanded.toggle()
        
        // Update in Storage Layer
        CategoryStore().updateCategory(allTasksPresenter.filteredCategories[section])
        
        tableView.reloadData()
    }
    
    func didDeleteCategoryHeader(_ categoryHeader: CategoryHeader, atSection section: Int) {
        var category: Category
        if allTasksPresenter.filteredCategories.count == 1 {
            category = allTasksPresenter.filteredCategories[0]
        }
        
        category = allTasksPresenter.filteredCategories[section]
        
        if let tasks = category.tasks {
            for task in tasks {
                TaskStore().deleteTask(task)
            }
        }
        CategoryStore().deleteCategory(category)
        if allTasksPresenter.filteredCategories.count == 0 {
            allTasksPresenter.filteredCategories.remove(at: 0)
        } else {
            allTasksPresenter.filteredCategories.remove(at: section)
        }
        allTasksPresenter.allCategories = allTasksPresenter.fetchAllCategories()
    }
    
    func didEditCategoryHeader(_ categoryHeader: CategoryHeader, atSection section: Int, toNewTitle: String?) {
        
        guard let text = toNewTitle, !text.isEmpty else { return }
        
        if allTasksPresenter.filteredCategories.count == 0 {
            allTasksPresenter.filteredCategories[0].name = text
            CategoryStore().updateCategory(allTasksPresenter.filteredCategories[0])
            
        } else {
            allTasksPresenter.filteredCategories[section].name = text
            CategoryStore().updateCategory(allTasksPresenter.filteredCategories[section])
        }
        
        allTasksPresenter.allCategories = allTasksPresenter.fetchAllCategories()
        
        let sections = IndexSet(arrayLiteral: 0, section)
        tableView.reloadSections(sections, with: .automatic)
    }
    
}


extension AllTasksViewController: AllTasksView {
    
}
