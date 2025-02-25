//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    var messages: [Message] = []
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Constant.appTitle
        
        navigationItem.hidesBackButton = true
        
        tableView.register(UINib.init(nibName: Constant.cellNibName, bundle: nil), forCellReuseIdentifier: Constant.cellIdentifier)
        
        tableView.dataSource = self
        
        messageTextfield.delegate = self
        
        loadMessages()
        
        listenForNewMessages()
    }
    
    func safeParam() -> Message? {
        guard let sender = Auth.auth().currentUser?.email, let body = messageTextfield.text else { return nil }
        
        return Message(sender: sender, body: body)
    }
    
    
    @IBAction func sendPressed(_ sender: UIButton) {
        messageTextfield.endEditing(true)
        
        if let message = safeParam() {
            sendMessage(sender: message.sender, body: message.body)
        }
    }
    
    func sendMessage(sender: String, body: String) {
        Task { @MainActor in
            do {
                let ref = try await firestoreDb?.collection(Constant.FStore.collectionName).addDocument(data: [
                    Constant.FStore.senderField: sender,
                    Constant.FStore.bodyField: body,
                    Constant.FStore.dateField: Date()
                ])
                print("Document added with ID: \(String(describing: ref?.documentID))")
            } catch {
                print("Error adding document: \(error)")
            }
            
            
        }
    }
    
    func loadMessages() {
        Task { @MainActor in
            guard let snapshot = try await firestoreDb?.collection(Constant.FStore.collectionName).order(by: Constant.FStore.dateField).getDocuments() else {
                return
            }
            
            messages = snapshot.documents.compactMap({Message.fromSnapshot($0.data())})
            
            tableView.reloadData()
            
            scrollToEndOfMessages()
        }
    }
    
    func listenForNewMessages() {
        Task { @MainActor in
            firestoreDb?.collection(Constant.FStore.collectionName).order(by: Constant.FStore.dateField).addSnapshotListener { [self] snapshot, error in
                guard let snapshot = snapshot else {
                    print("Error listening for new messages: \(String(describing: error))")
                    
                    return
                }
                
                messages = snapshot.documents.compactMap({Message.fromSnapshot($0.data())})
                
                tableView.reloadData()
                
                scrollToEndOfMessages()
            }
        }
    }
    
    func scrollToEndOfMessages() {
        if self.messages.count > 0 {
            let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
            
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.cellIdentifier, for: indexPath) as! MessageCell
        
        let message = messages[indexPath.row]
        
        if (message.sender == Auth.auth().currentUser?.email) {
            cell.leftAvatar.isHidden = true
            cell.rightAvatar.isHidden = false
            
            cell.messageLabel.textColor = .white
            cell.messageBuble.backgroundColor = UIColor(named: Constant.BrandColors.purple)
            
            
        } else {
            cell.leftAvatar.isHidden = false
            cell.rightAvatar.isHidden = true
            
            cell.messageBuble.backgroundColor = UIColor(named: Constant.BrandColors.lightPurple)
            cell.messageLabel.textColor = UIColor(named: Constant.BrandColors.purple)
        }
        
        cell.messageLabel?.text = message.body
        
        return cell
    }
}

extension ChatViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let message = safeParam() {
            sendMessage(sender: message.sender, body: message.body)
        }
        
        textField.endEditing(true)
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = ""
    }
}
