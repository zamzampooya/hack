//
//  HistoryViewController.swift
//  EQMM
//
//  Created by Zamzam Farzamipooya on 07/05/2019.
//  Copyright © 2019 Zamzam Farzamipooya. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet weak var customer: UILabel!
    @IBOutlet weak var quoteNumber: UILabel!
    @IBOutlet weak var historyTableView: UITableView! {
        didSet {
            self.historyTableView.delegate = self
            self.historyTableView.dataSource = self
        }
    }
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()

    var document = Document()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.historyTableView.reloadData()
        self.historyTableView.addSubview(self.refreshControl)

    }
    

    
    @IBAction func close(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        if self.document.history!.contains(where: { (history) -> Bool in
            return history.state == .orderSent
        }) {
            self.historyTableView.reloadData()
            refreshControl.endRefreshing()
            return
        } else if self.document.history!.contains(where: { (history) -> Bool in
           return history.state == .quoteAccepted
        }) {
            self.document.history?.append(History(date: "08.05.2019", comment: "", state: .orderSent))

        } else if self.document.history!.contains(where: { (history) -> Bool in
            return history.state == .quoteSeen
        }) {
            self.document.history?.append(History(date: "08.05.2019", comment: "", state: .quoteAccepted))

        } else if self.document.history!.contains(where: { (history) -> Bool in
            return history.state == .quoteSent
        }) {
            self.document.history?.append(History(date: "08.05.2019", comment: "", state: .quoteSeen))
        }
        self.historyTableView.reloadData()
        refreshControl.endRefreshing()
    }

}



extension HistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // go to the history
    }
}

extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.document.history?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as! HistoryTableViewCell
        cell.setContent(history: self.document.history![indexPath.row])
        return cell
        
    }
}
