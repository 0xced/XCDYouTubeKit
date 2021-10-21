//
//  DemoFullScreenViewController.swift
//  XCDYouTubeKit iOS Demo
//
//  Created by Soneé John on 10/17/19.
//  Copyright © 2019 Cédric Luthi. All rights reserved.
//

import AVKit
import UIKit
import XCDYouTubeKit

extension DemoFullScreenViewController: VideoPickerControllerDelegate {
	func videoPickerController(_ videoPickerController: VideoPickerController!, didSelectVideoWithIdentifier videoIdentifier: String!) {
		videoIdentifierTextField.text = videoIdentifier
		UserDefaults.standard.set(videoIdentifier, forKey: "VideoIdentifier")
	}
}

extension DemoFullScreenViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		play(textField)
		return true
	}

	func textFieldDidEndEditing(_ textField: UITextField) {
		UserDefaults.standard.set(videoIdentifierTextField.text, forKey: "VideoIdentifier")
	}
}

class DemoFullScreenViewController: UIViewController {
	@IBOutlet open var lowQualitySwitch: UISwitch!
	@IBOutlet open var videoIdentifierTextField: UITextField!
	var ob: NSKeyValueObservation?
	private var timeObserverToken: Any?

	override func viewDidLoad() {
		super.viewDidLoad()
		videoIdentifierTextField.text = UserDefaults.standard.string(forKey: "VideoIdentifier")
	}

	@IBAction open func endEditing(_ sender: Any!) {
		view.endEditing(true)
	}

	@IBAction open func play(_ sender: Any!) {
		XCDYouTubeClient.default().getVideoWithIdentifier(videoIdentifierTextField.text) { video, error in
			guard error == nil else {
				Utilities.shared.displayError(error! as NSError, originViewController: self)
				return
			}
			AVPlayerViewControllerManager.shared.lowQualityMode = self.lowQualitySwitch.isOn
			AVPlayerViewControllerManager.shared.video = video
			self.present(AVPlayerViewControllerManager.shared.controller, animated: true) {
				AVPlayerViewControllerManager.shared.controller.player?.play()
			}
		}
	}
}
