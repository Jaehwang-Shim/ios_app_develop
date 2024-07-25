//
//  BaseViewController.swift
//  Spatial_touch_demo2_for_ios
//
//  Created by Jaehwang on 7/23/24.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension BaseViewController {
    func showAlert(
        title: String?,
        message: String?,
        confirmHandler: (() -> Void)? = nil,
        completion: (() -> Void)? = nil)
    {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { _ in
            if let handler = confirmHandler {
                handler()
            }
        }
        alertView.addAction(confirmAction)
        present(alertView, animated: true, completion: completion)
    }

}
