//
//  HistoryViewController.swift
//  WiseChat GPT
//
//  Created by Md Murad Hossain on 5/3/23.
//

import UIKit

var selectHistoryItemIndex = 0

class HistoryViewController: UIViewController {

    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    @IBOutlet weak var historyBGView: UIView!
    @IBOutlet weak var historyTableView: UITableView!
    @IBOutlet weak var historyEmtyLabel: UILabel!
    
    var historyArray = [MessageItemList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTableViewCellSetup()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coreDataSaveMessage()
        historyIsEmty()
    }

    // MARK: Private methods
    
    /// Stausbar color change
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent //.default for black style
    }
    
    func coreDataSaveMessage() {
        if let data = try? context?.fetch(MessageItemList.fetchRequest()) {
            historyArray = data
            historyArray.sort{$0.createdAt! > $1.createdAt! }
            
            DispatchQueue.main.async {
                self.historyTableView.reloadData()
            }
        }
    }
    
    private func historyIsEmty() {
        historyEmtyLabel.isHidden = true
        if historyArray.count > 0 {
            historyEmtyLabel.isHidden = true
        } else {
            historyEmtyLabel.isHidden = false
        }
    }

    @IBAction func historyBackActionButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    private func historyTableViewCellSetup() {
        let nib = UINib(nibName: "HistoryTableViewCell", bundle: nil)
        historyTableView.register(nib, forCellReuseIdentifier: "cell")
        historyTableView.delegate = self
        historyTableView.dataSource = self
    }
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historyTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HistoryTableViewCell
        let historyQuestion = historyArray[indexPath.row]
        let historyDate = "\(historyArray[indexPath.row].createdAt!)"
//        let dateFormatterGet = DateFormatter()
//        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//        let dateFormatterPrint = DateFormatter()
//        dateFormatterPrint.dateFormat = "EE, dd MMMM yyyy   h:mm:ss a"
//        historyDate = dateFormatterGet.string(from: "\(historyDate)")
//        historyDate =  dateFormatterPrint.string(from: datee ?? Date())
        cell.historyLabel.text = historyQuestion.question
        cell.historylabelBGView.layer.cornerRadius = 15
        cell.timeLabelAdd.text = historyDate
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Details", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HistoryDetailsViewController") as! HistoryDetailsViewController
        selectHistoryItemIndex = indexPath.row
        answerDetails = historyArray[selectHistoryItemIndex].answer!
        questionDetails = historyArray[selectHistoryItemIndex].question!
        vc.transitioningDelegate = self
        vc.modalPresentationStyle = .custom
        self.present(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let index = 0

        let identifier = "\(index)" as NSString
        return UIContextMenuConfiguration(
            identifier: identifier,
            previewProvider: nil) { [self] _ in
                let done = UIAction(
                    title: "Done",
                    image: UIImage(systemName: "trash")) { [self] _ in
                        
                        let index = [IndexPath(row: indexPath.row, section: 0)]

                        DatabaseHelper.shareInstance.deleteItem(item: historyArray[indexPath.row])
                        try? DatabaseHelper.shareInstance.context?.save()
                        
                        historyArray.remove(at: indexPath.row)
                        historyTableView.deleteRows(at: index, with: .automatic)
                    }
                let cancle = UIAction(
                    title: "Cancle",
                    image: UIImage(systemName: "clear")) { _ in
                    }
                return UIMenu(title: "Are you sure that this message delete!", image: nil, children: [done,cancle])
            }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let index = [IndexPath(row: indexPath.row, section: 0)]
            DatabaseHelper.shareInstance.deleteItem(item: historyArray[indexPath.row])
            try? DatabaseHelper.shareInstance.context?.save()
            historyArray.remove(at: indexPath.row)
            historyTableView.deleteRows(at: index, with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let anim = CATransform3DTranslate(CATransform3DIdentity, -400, -100, 0)
        cell.layer.transform = anim
        cell.alpha = 0.3
        
        UIView.animate(withDuration: 0.3){
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1
        }
    }
}

// MARK: Custom push and pop back transition animation
extension HistoryViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentTransition()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissTransition()
    }
}
