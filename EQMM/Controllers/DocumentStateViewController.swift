//
//  DocumentStateViewController.swift
//  EQMM
//
//  Created by Zamzam Farzamipooya on 07/05/2019.
//  Copyright © 2019 Zamzam Farzamipooya. All rights reserved.
//

import UIKit

class DocumentStateViewController: UIViewController {

    @IBOutlet weak var quoteButton: UIButton!
    @IBOutlet weak var ordersButton: UIButton!
    @IBOutlet weak var invoicesButton: UIButton!
    @IBOutlet weak var docsTableView: UITableView! {
        didSet {
            self.docsTableView.delegate = self
            self.docsTableView.dataSource = self
        }
    }
    var documents = [Document]() {
        didSet {
            self.docsTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getDocuments()
    }
    
    @IBAction func goToAddPage(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        controller.delegate = self
        self.present(controller, animated: true, completion: nil)

    }
    
    @IBAction func quoteAction(_ sender: UIButton) {
    }
    
    @IBAction func orders(_ sender: UIButton) {
    }
    @IBAction func invoices(_ sender: UIButton) {
    }
    
}

extension DocumentStateViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 69
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "HistoryViewController") as! HistoryViewController
        controller.document = MockData.shared.documents.last!
        self.present(controller, animated: true, completion: nil)

    }
}

extension DocumentStateViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.documents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SalesTableViewCell", for: indexPath) as! SalesTableViewCell
        cell.setContent(document: documents[indexPath.row])
        return cell
        
    }
}

extension DocumentStateViewController {
    
    func getDocuments() {
        self.documents = MockData.shared.documents
    }
}

extension DocumentStateViewController: DetailViewControllerDelegate {
    func didSetNewData(document: Document) {
        MockData.shared.documents.append(document)
        getDocuments()
        self.docsTableView.reloadData()
    }
}
