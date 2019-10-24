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
       
	override func viewDidLoad() {
		super.viewDidLoad()
		self.videoIdentifierTextField.text = UserDefaults.standard.string(forKey: "VideoIdentifier")
	}
    
	@IBAction open func endEditing(_ sender: Any!) {
		self.view.endEditing(true)
	}
	
    @IBAction open func play(_ sender: Any!) {
		let playerViewController = AVPlayerViewController()
		self.present(playerViewController, animated: true, completion: nil)
		
		XCDYouTubeClient.default().getVideoWithIdentifier(self.videoIdentifierTextField.text) { (video, error) in
			guard error == nil else {
				Utilities.shared.displayError(error! as NSError, originViewController: self)
				return
			}
			
			let streamURL = self.lowQualitySwitch.isOn ? video?.streamURLs[XCDYouTubeVideoQualityHTTPLiveStreaming] ?? video?.streamURLs[XCDYouTubeVideoQuality.medium360.rawValue] ?? video?.streamURLs[XCDYouTubeVideoQuality.small240.rawValue] : video?.streamURL
			
			playerViewController.player = AVPlayer(url: streamURL!)
			playerViewController.player?.play()
		}
    }
}
