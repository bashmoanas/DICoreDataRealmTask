//
//  AlertPresenter.swift
//  DICoreDataRealmTask
//
//  Created by Anas Bashandy on 15/8/20.
//  Copyright © 2020 Anas Bashandy. All rights reserved.
//

import UIKit

enum Outcome {
    case confirmed
    case cancelled
}

struct AlertPresenter {
    let title: String
    let confirmTitle: String
    let cancelTitle: String
    let handler: (Outcome) -> Void
    
    func addTextField(toAlert alert: UIAlertController) -> String? {
        alert.addTextField()
        
        guard
            let userInput = alert.textFields?[0],
            let text = userInput.text else { return nil }
        
        return text
    }
    
    func present(in viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { (_) in
            self.handler(.cancelled)
        }
        let confirmAction = UIAlertAction(title: confirmTitle, style: .default) { (_) in
            self.handler(.confirmed)
        }
        
        alert.addTextField()
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        viewController.present(alert, animated: true, completion: nil)
    }
}
