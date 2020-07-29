//
//  NavigationFlow.swift
//  DICoreDataRealmTask
//
//  Created by Anas Bashandy on 29/7/20.
//  Copyright © 2020 Anas Bashandy. All rights reserved.
//

import UIKit

enum StoryboardName: String {
    case main = "Main"

    var instance: UIStoryboard? {
        switch self {
        case .main:
            return UIStoryboard(name: self.rawValue, bundle: nil)
        }
    }

    func loadViewController<T:UIViewController>(_ viewControllerClass: T.Type) -> T {
        let storyboardID = String(describing: T.self)

        guard let viewControllerToLoad = instance?.instantiateViewController(identifier: storyboardID) as? T else { fatalError("Error") }

        return viewControllerToLoad
    }
}

extension UIViewController {
    static func instantiateViewController(fromStoryboard storyboard: StoryboardName) -> Self {
        return storyboard.loadViewController(self)
    }
}
