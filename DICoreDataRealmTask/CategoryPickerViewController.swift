//
//  CategoryPickerViewController.swift
//  DICoreDataRealmTask
//
//  Created by Anas Bashandy on 29/7/20.
//  Copyright © 2020 Anas Bashandy. All rights reserved.
//

import UIKit

//class CategoryPickerViewController: UITableViewController {
//    
//    // MARK: - Variables
//    
//    var categoryStore = CategoryStore()
//    var selectedCategory: Category?
//    
//    var isSectionHidden = true {
//        didSet {
//            tableView.beginUpdates()
//            tableView.endUpdates()
//        }
//        
//    }
//    
//    // MARK: - View Life Cycle
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        categoryStore.allCategories = categoryStore.fetchCategories() ?? [
//            Category]()
//        //        tableView.sectionHeaderHeight = 70
//    }
//    
//    // MARK: - Table View Data Source Methods
//    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch section {
//        case 0:
//            return 0
//        default:
//            return categoryStore.categoryCount
//        }
//        
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
//        let category = categoryStore.getCategoryAt(index: indexPath.row)
//        cell.textLabel?.text = category.name
//        cell.accessoryType = selectedCategory == category ? .checkmark : .none
//        
//        return cell
//    }
//    
//    // MARK: - Table View Delegate Methods
//    
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return createHeaderView()
//    }
//    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return isSectionHidden ? 0 : UITableView.automaticDimension
//    }
//    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        
//        selectedCategory = categoryStore.allCategories[indexPath.row]
//        tableView.reloadData()
//    }
//    
//    // MARK: - Helper Methods
//    
//    private func createHeaderView() -> UIView {
//        let pickACategoryButton = UIButton(type: .system)
//        pickACategoryButton.setTitle("Pick a category", for: .normal)
//        pickACategoryButton.addTarget(self, action: #selector(self.hideSection(sender:)), for: .touchUpInside)
//        
//        return pickACategoryButton
//    }
//    
//    @objc func hideSection(sender: UIButton) {
//        isSectionHidden.toggle()
//    }
//}
