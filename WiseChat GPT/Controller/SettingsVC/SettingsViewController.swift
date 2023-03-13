//
//  SettingsViewController.swift
//  WiseChat GPT
//
//  Created by Md Murad Hossain on 28/2/23.
//

import UIKit
import MessageUI

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var settingRobotGifView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingRobotGifPlay()
    }
    
    /// Stausbar color change
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent //.default for black style
    }
    
    /// Send a message phone number
    func displayMessageComposer(contact: String) {
        if MFMessageComposeViewController.canSendText() {
            let messageComposeVC = MFMessageComposeViewController()
            messageComposeVC.body = "Please email me at your earliest convenience."
            messageComposeVC.recipients = [contact]
            messageComposeVC.messageComposeDelegate = self
            present(messageComposeVC, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Error", message: "Your device can't send messages. Please your divice check sim card!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }

    /// Send a message gamil contact
    func displayMailComposer() {
        if MFMailComposeViewController.canSendMail() {
            let mailComposeVC = MFMailComposeViewController()
            mailComposeVC.mailComposeDelegate = self
            mailComposeVC.setToRecipients(["muradhossainm01@gmail.com"])
            mailComposeVC.setSubject("Contact")
            mailComposeVC.setMessageBody("Please contact me at your earliest convenience.", isHTML: false)
            present(mailComposeVC, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Error", message: "Your device can't send email. Please Sign-in or login gmail.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    @IBAction func crossButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func contactActionButton(_ sender: UIButton) {
//        displayMailComposer()
        displayMessageComposer(contact: "01792889014")

    }
    
    @IBAction func writeAReviewActionButton(_ sender: UIButton) {
        guard let writeReviewURL = URL(string: "https://apps.apple.com/app/id=com.murad.www.WiseChat-GPT?action=write-review")
            else { fatalError("Expected a valid URL") }
        UIApplication.shared.open(writeReviewURL, options: [:], completionHandler: nil)
    }
    
    @IBAction func privactyPolicyActionButton(_ sender: UIButton) {
        guard let writeReviewURL = URL(string: "https://developer.apple.com/app-store/app-privacy-details/")
            else { fatalError("Expected a valid URL") }
        UIApplication.shared.open(writeReviewURL, options: [:], completionHandler: nil)
    }
    
    @IBAction func shareAppActionButton(_ sender: UIButton) {
        let vc = UIActivityViewController(activityItems: ["https://apps.apple.com/us/app/WiseChat-GPT/id1480981107"], applicationActivities: nil)
        vc.popoverPresentationController?.sourceView = self.view
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func TermsOfUseActionButton(_ sender: UIButton) {
        let st = UIStoryboard(name: "Term", bundle: nil)
        let vc = st.instantiateViewController(withIdentifier: "TermViewController") as! TermViewController
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        self.present(vc, animated: true)
    }
    
    private func settingRobotGifPlay() {
        let imageName = UIImage.gifImageWithName("robot gif")
        settingRobotGifView.image = imageName
    }
}


extension SettingsViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentTransition()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissTransition()
    }
}



extension SettingsViewController: MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        dismiss(animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
}
