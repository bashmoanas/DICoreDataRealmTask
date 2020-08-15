//
//  CategoryHeader.swift
//  DICoreDataRealmTask
//
//  Created by Anas Bashandy on 10/8/20.
//  Copyright © 2020 Anas Bashandy. All rights reserved.
//

import UIKit

protocol CategoryHeaderDelegate {
    func didTapCategoryHeader(_ categoryHeader: CategoryHeader, atSection section: Int)
    func didDeleteCategoryHeader(_ categoryHeader: CategoryHeader, atSection section: Int)
    func didEditCategoryHeader(_ categoryHeader: CategoryHeader, atSection section: Int, toNewTitle: String?)
}

class CategoryHeader: UITableViewHeaderFooterView {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var chevronImageView: UIImageView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var editCategoryButton: UIButton!
    @IBOutlet weak var editCategoryTextField: UITextField!
    
    
    var delegate: CategoryHeaderDelegate?
    
    var currentSection: Int!
        
    func configure(withCategory category: Category) {
        nameLabel.text = category.name
        chevronImageView.image = category.isExpanded ? UIImage(systemName: "chevron.down") : UIImage(systemName: "chevron.right")
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(categoryHeaderTapped(_:)))
        contentView.addGestureRecognizer(tapGesture)
        
        editCategoryTextField.isHidden = true
        contentView.backgroundColor = .systemYellow
    }
    
    @objc func categoryHeaderTapped(_ sender: UITapGestureRecognizer) {
        delegate?.didTapCategoryHeader(self, atSection: currentSection)
    }
    
    @objc private func doneEditingCategory() {
        let newTitle = editCategoryTextField.text
        delegate?.didEditCategoryHeader(self, atSection: currentSection, toNewTitle: newTitle)
        
        endEditing(true)
        editCategoryTextField.text = ""
        editCategoryTextField.isHidden = true
    }
    
    private func deleteCategory(_ category: Category) {
        CategoryStore().deleteCategory(category)
    }
        
    @IBAction func deleteSections(_ sender: UIButton) {
        delegate?.didDeleteCategoryHeader(self, atSection: currentSection)
    }
    
    @IBAction func editCategoryTitle(_ sender: UIButton) {
        let toolbar = UIToolbar()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneEditingCategory))
        toolbar.items = [doneButton]
        toolbar.sizeToFit()
        editCategoryTextField.inputAccessoryView = toolbar
        
        editCategoryTextField.isHidden = false
    }
}
