//
//  AlertManager.swift
//  KasimAdalanProject
//
//  Created by Elif Tüm on 2.06.2024.
//

import Foundation
import UIKit

class AlertManager {
    static func showAlert(title: String?, message: String?, actions: [AlertAction] = [], preferredStyle: UIAlertController.Style = .alert, presentingViewController: UIViewController? = nil, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        if actions.isEmpty {
            let defaultAction = AlertAction(title: "OK", style: .default)
            alertController.addAction(defaultAction.alertAction)
        } else {
            for action in actions {
                alertController.addAction(action.alertAction)
            }
        }
        
        let viewController = presentingViewController ?? UIApplication.shared.keyWindowPresentedController
        
        DispatchQueue.main.async {
            viewController?.present(alertController, animated: true, completion: completion)
        }
    }
}

struct AlertAction {
    let title: String
    let style: UIAlertAction.Style
    let handler: (() -> Void)?
    
    init(title: String, style: UIAlertAction.Style = .default, handler: (() -> Void)? = nil) {
        self.title = title
        self.style = style
        self.handler = handler
    }
    
    var alertAction: UIAlertAction {
        return UIAlertAction(title: title, style: style) { _ in
            self.handler?()
        }
    }
}
