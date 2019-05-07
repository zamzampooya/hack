//
//  DetailViewController.swift
//  EQMM
//
//  Created by Zamzam Farzamipooya on 07/05/2019.
//  Copyright © 2019 Zamzam Farzamipooya. All rights reserved.
//

import UIKit
import MessageUI
protocol DetailViewControllerDelegate: class {
    func didSetNewData(document: Document)
}
class DetailViewController: UIViewController, MFMailComposeViewControllerDelegate {
    @IBOutlet weak var docTitle: UILabel!
    @IBOutlet weak var quoteNumber: UILabel!
    @IBOutlet weak var itemTableView: UITableView! {
        didSet {
            self.itemTableView.delegate = self
            self.itemTableView.dataSource = self
        }
    }
    @IBOutlet weak var discount: UILabel!
    @IBOutlet weak var subtotalDiscount: UILabel!
    @IBOutlet weak var vat: UILabel!
    @IBOutlet weak var total: UILabel!
    weak var delegate: DetailViewControllerDelegate?
    var document = Document()
    override func viewDidLoad() {
        super.viewDidLoad()
        setContent()
        self.setData(document: self.document)
        self.itemTableView.reloadData()

        
    }
    
    @IBAction func close(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendEmail(_ sender: UIButton) {
        if( MFMailComposeViewController.canSendMail()){
            print("Can send email.")

            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self

            //Set to recipients
            mailComposer.setToRecipients(["tatu.haimila@visma.com"])

            //Set the subject
            mailComposer.setSubject("\(self.document.state!.preferedText()) \(self.document.id!) from Awesome Logo Designs")

            //set mail body
            var pathPDF = ""//"\(NSTemporaryDirectory())contract.pdf"

            if let path2 = Bundle.main.path(forResource: "Quoteno10067Nokia", ofType: "pdf") {
                pathPDF = path2
            }
            if let fileData = NSData(contentsOfFile: pathPDF)
            {
                print("File data loaded.")
                mailComposer.addAttachmentData(fileData as Data, mimeType: "application/pdf", fileName: "\(self.document.state!.preferedText()) \(self.document.id!).pdf")
            }
//            mailComposer.setMessageBody("easyflow://mainscreen", isHTML: true)

            //this will compose and present mail to user
            self.present(mailComposer, animated: true, completion: nil)
        }
        else
        {
            print("email is not supported")
        }
        
//        var filesToShare = [Any]()
//                //set mail body
//                        var pathPDF = ""//"\(NSTemporaryDirectory())contract.pdf"
//
//                       if let path2 = Bundle.main.path(forResource: "Quoteno10067Nokia", ofType: "pdf") {
//                        pathPDF = path2
//                       }
//                    // Add the path of the file to the Array
//        filesToShare.append(pathPDF)
//
//        // Make the activityViewContoller which shows the share-view
//        let activityViewController = UIActivityViewController(activityItems: filesToShare, applicationActivities: nil)
//
//        // Show the share-view
//        self.present(activityViewController, animated: true, completion: nil)
        
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.delegate?.didSetNewData(document: self.document)
        self.dismiss(animated: true) {
            self.dismiss(animated: true, completion: nil)
        }
    }
  
    func setContent() {
        self.document = Document(id: 10067, customer: "Nokia", state: DocumentState(rawValue: "quote"), description: "", total: 1500, discount: 0, orderlines: [OrderLine(name: "Water Bottle", numberOfItems: "100", price: 3), OrderLine(name: "T-shirt", numberOfItems: "100", price: 7), OrderLine(name: "Backpack", numberOfItems: "50", price: 10)], history: [History(date: "01.02.19", comment: "", state: .quoteSent)], date: nil, totalVat: 300)
        
    }
    func setData(document: Document) {
        self.docTitle.text = (document.state?.preferedText() ?? "Quote") + " \(document.id!)"
        self.quoteNumber.text = (self.document.state?.preferedText() ?? "Quote") + " \(self.document.id!)"
        self.discount.text = "\(self.document.discount!)"
        self.subtotalDiscount.text = "EUR " + "\(self.document.total! - self.document.totalVat!)"
        self.vat.text = "EUR " + "\(self.document.totalVat!)"
        self.total.text = "EUR " + "\(self.document.total!)"
        
    }
}

extension DetailViewController :  UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // go to the history
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.document.orderlines?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as! ItemTableViewCell
        cell.setConent(orderLine: self.document.orderlines![indexPath.row])
        return cell
        
    }
}
