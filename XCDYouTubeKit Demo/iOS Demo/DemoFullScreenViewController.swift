//
//  DemoFullScreenViewController.swift
//  XCDYouTubeKit iOS Demo
//
//  Created by Soneé John on 10/17/19.
//  Copyright © 2019 Cédric Luthi. All rights reserved.
//

import UIKit
import AVKit
import XCDYouTubeKit

extension DemoFullScreenViewController: VideoPickerControllerDelegate {
	func videoPickerController(_ videoPickerController: VideoPickerController!, didSelectVideoWithIdentifier videoIdentifier: String!) {
		self.videoIdentifierTextField.text = videoIdentifier
		UserDefaults.standard.set(videoIdentifier, forKey: "VideoIdentifier")
	}
}

extension DemoFullScreenViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		self.play(textField)
		return true
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		UserDefaults.standard.set(self.videoIdentifierTextField.text, forKey: "VideoIdentifier")
	}
}

class DemoFullScreenViewController: UIViewController {
	
    @IBOutlet weak open var lowQualitySwitch: UISwitch!
    @IBOutlet weak open var videoIdentifierTextField: UITextField!
	var ob: NSKeyValueObservation?
	private var timeObserverToken: Any?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.videoIdentifierTextField.text = UserDefaults.standard.string(forKey: "VideoIdentifier")
	}
    
	@IBAction open func endEditing(_ sender: Any!) {
		self.view.endEditing(true)
	}
	
	@IBAction open func play(_ sender: Any!) {
		XCDYouTubeClient.default().getVideoWithIdentifier(self.videoIdentifierTextField.text) { (video, error) in
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
