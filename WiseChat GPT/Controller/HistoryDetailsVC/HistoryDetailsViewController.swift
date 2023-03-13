//
//  HistoryDetailsViewController.swift
//  WiseChat GPT
//
//  Created by Md Murad Hossain on 9/3/23.
//

import UIKit
import AVFAudio

var questionDetails = ""
var answerDetails = ""

class HistoryDetailsViewController: UIViewController {

    @IBOutlet weak var detailsTableView: UITableView!
    @IBOutlet weak var indicatorImageView: UIImageView!
    @IBOutlet weak var copyButton2: UIButton!
    @IBOutlet weak var speakerButton2: UIButton!
    @IBOutlet weak var shareButton2: UIButton!
    @IBOutlet weak var speakerSilentButton: UIButton!
    
    let synthesizer = AVSpeechSynthesizer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicatorImageView.isHidden = true
        speakerSilentButton.isHidden = true
        setupDetailsTableViewCell()
    }

    // MARK: Private methods
    
    /// Stausbar color change
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent //.default for black style
    }

    private func setupDetailsTableViewCell() {
        let nib = UINib(nibName: "HistoryDetailsTableViewCell", bundle: nil)
        detailsTableView.register(nib, forCellReuseIdentifier: "cell")
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
    }
    
    func speak(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-AI")
        synthesizer.speak(utterance)
    }


    @IBAction func detailsBackButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func speakerSilentButtonAction(_ sender: UIButton) {
        synthesizer.stopSpeaking(at: .immediate)
        UIView.animate(withDuration: 0.3){ [self] in
            speakerSilentButton.isHidden = true
            loadViewIfNeeded()
        }
    }
    
    @IBAction func DetailsTextSpeakerButton(_ sender: UIButton) {
        synthesizer.stopSpeaking(at: .immediate)
        UIView.animate(withDuration: 0.3){ [self] in
            speakerSilentButton.isHidden = false
            loadViewIfNeeded()
        }
        let text = "Question text: \(questionDetails)\n\nAnswer text: \(answerDetails)"
        speak(text)
        
        self.indicatorImageView.image = UIImage(named: "SpeakerOn")
        self.indicatorImageView.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.indicatorImageView.isHidden = true
        }
    }
    
    @IBAction func DetailsTextCopyActionbutton(_ sender: UIButton) {
        UIPasteboard.general.string = answerDetails
        self.indicatorImageView.image = UIImage(named: "Copied")
        self.indicatorImageView.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.indicatorImageView.isHidden = true
        }
    }
    
    @IBAction func DetailsTextshareActionbutton(_ sender: UIButton) {
        let questionText = "Question: \(questionDetails)\n\nAnswer: \(answerDetails)"
        let shareAll = [questionText]
        let activityViewController = UIActivityViewController(activityItems: shareAll as [Any], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
}


extension HistoryDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0 {
            let cell = detailsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HistoryDetailsTableViewCell
            cell.selectionStyle = .none
            cell.userView.layer.borderColor = .init(red: 137, green: 207, blue: 240, alpha: 0.1)
            cell.userView.layer.shadowColor = UIColor.blue.cgColor
            cell.userView.layer.shadowOpacity = 1
            cell.userView.layer.shadowOffset = CGSize.zero
            cell.userView.layer.shadowRadius = 3
            cell.userView.layer.borderWidth = 1.5
            cell.userLabel.text = questionDetails
            cell.userView.isHidden = false
            cell.userLabel.isHidden = false
            cell.userImageView2.isHidden = false
            cell.robotTextLabel.isHidden = true
            cell.robotImageView.isHidden = true
            cell.robotView.isHidden = true
            cell.robotTextLabel.text = ""
            return cell
            
        } else {
            
            let cell = detailsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HistoryDetailsTableViewCell
            cell.selectionStyle = .none
            cell.robotTextLabel.text = answerDetails
            cell.robotView.layer.borderColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            cell.robotView.layer.borderWidth = 1.5
            cell.robotView.layer.shadowColor = UIColor.black.cgColor
            cell.robotView.layer.shadowOpacity = 1
            cell.robotView.layer.shadowOffset = CGSize.zero
            cell.robotView.layer.shadowRadius = 3
            cell.userView.isHidden = true
            cell.userLabel.isHidden = true
            cell.userImageView2.isHidden = true
            cell.robotTextLabel.isHidden = false
            cell.robotImageView.isHidden = false
            cell.robotView.isHidden = false
            cell.userLabel.text = ""
            return cell
        }
    }
}
