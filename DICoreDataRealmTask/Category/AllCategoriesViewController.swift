//
//  CategoriesViewController.swift
//  DICoreDataRealmTask
//
//  Created by Anas Bashandy on 28/7/20.
//  Copyright © 2020 Anas Bashandy. All rights reserved.
//

import UIKit

//class AllCategoriesViewController: UITableViewController {
//    
//    // MARK: - Variables
//    
//    var categoryStore = CategoryStore()
//    
//    // MARK: - View Life Cycle
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        categoryStore.allCategories = categoryStore.fetchCategories() ?? [Category]()
//    }
//    
//    // MARK: - Table View Data Source Methods
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return categoryStore.allCategories.count
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
//        let category = categoryStore.allCategories[indexPath.row]
//        configure(cell, withCategory: category)
//        
//        return cell
//    }
//    
//    // MARK: - Table View Delegate Methods
//    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            let categoryToDelete = categoryStore.allCategories[indexPath.row]
//            categoryStore.deleteCategory(categoryToDelete)
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//        }
//    }
//    
//    // MARK: - Helper Methods
//    
//    private func configure(_ cell: UITableViewCell, withCategory category: Category) {
//        cell.textLabel?.text = category.name
//    }
//    
//    private func promptForCategory() {
//        let alertController = UIAlertController(title: "Add Category", message: nil, preferredStyle: .alert)
//        alertController.addTextField()
//        let addAction = UIAlertAction(title: "Add", style: .default) { (action) in
//            let userInput = alertController.textFields![0]
//            let text = userInput.text ?? ""
//            let category = Category(id: UUID(), name: text, isExpanded: true, tasks: [Task]())
//            self.categoryStore.createCategory(category)
//            self.tableView.reloadData()
//        }
//        alertController.addAction(addAction)
//        
//        present(alertController, animated: true, completion: nil)
//    }
//    
//    
//    // MARK: Actions
//    
//    @IBAction func addCategory(_ sender: UIButton) {
//        promptForCategory()
//    }
//    
//}
