//
//  ShareViewController.swift
//  FinalProject
//
//  Created by Kevin Baumgartner on 2018-11-11.
//  Copyright © 2018 Kevin Baumgartner. All rights reserved.
//

import UIKit
import MessageUI

class ShareViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var toField: UITextField?
    @IBOutlet weak var ccField: UITextField?
    @IBOutlet weak var subjectField: UITextField?
    @IBOutlet weak var bodyField: UITextView?
    @IBOutlet weak var sendBtn: UIButton?
    
    //Declarations
    var toStr: String?
    var ccStr: String?
    var subjectStr: String?
    var bodyStr: String?
    
    //On Initial Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //When the final submit button is pressed
    @IBAction func emailBtnPressed(_ sender: Any) {
        parseEmail()
    }
    
    //Parse the form fields into an auto-generated email using the local default email client
    func parseEmail(){
        guard let toTemp = toField?.text, !toTemp.isEmpty else{
            let shareController = UIAlertController(title: "Error", message: "Email requires a recipient!", preferredStyle: .alert)
            shareController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            }))
            self.present(shareController, animated: true, completion: nil)
            return
        }
        toStr = toTemp
        
        guard let ccTemp = ccField?.text else{
            return
        }
        ccStr = ccTemp
        
        guard let subjectTemp = subjectField?.text, !subjectTemp.isEmpty else{
            let shareController = UIAlertController(title: "Error", message: "Email requires a subject!", preferredStyle: .alert)
            shareController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            }))
            self.present(shareController, animated: true, completion: nil)
            return
        }
        subjectStr = subjectTemp
        
        guard let bodyTemp = bodyField?.text, !bodyTemp.isEmpty else{
            let shareController = UIAlertController(title: "Error", message: "Email requires a body!", preferredStyle: .alert)
            shareController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            }))
            self.present(shareController, animated: true, completion: nil)
            return
        }
        bodyStr = bodyTemp
        sendEmail()
    }
    
    //Composes the Email and preps for sending
    func sendEmail(){
        if MFMailComposeViewController.canSendMail(){
            let shareMail = MFMailComposeViewController()
            shareMail.mailComposeDelegate = self as? MFMailComposeViewControllerDelegate
            
            if let toStr = self.toStr, let ccStr = self.ccStr, let subjectStr = self.subjectStr, let bodyStr = self.bodyStr{
                shareMail.setToRecipients([toStr])
                shareMail.setCcRecipients([ccStr])
                shareMail.setSubject(subjectStr)
                shareMail.setMessageBody(bodyStr, isHTML: true)
            }
            
            self.present(shareMail, animated: true, completion: nil)
        }
    }
    
    //Opens the default mail client
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
