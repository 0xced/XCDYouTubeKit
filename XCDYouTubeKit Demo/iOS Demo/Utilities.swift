//
//  Utilities.swift
//  XCDYouTubeKit iOS Demo
//
//  Created by Soneé John on 10/24/19.
//  Copyright © 2019 Cédric Luthi. All rights reserved.
//

import UIKit

@objcMembers class Utilities: NSObject {
	static let shared = Utilities()
	
	func displayError(_ error: NSError, originViewController: UIViewController) {
		OperationQueue.main.addOperation {
			originViewController.dismiss(animated: true) {
				let alert = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: error.localizedDescription, preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
				originViewController.present(alert, animated: true, completion: nil)
			}
		}
	}
}
