//
//  RoomViewController.swift
//  ChatApp
//
//  Created by Gwinyai Nyatsoka on 6/8/2023.
//

import UIKit
import FirebaseDatabase

class RoomViewController: UIViewController {
    
    @IBOutlet weak var bottomInputViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    var user: UserModel?
    var room: RoomModel?
    var messages: [MessageModel] = [
        MessageModel(senderId: "user1", username: "TestUser", text: "Hello World!", createdAt: Date()),
        MessageModel(senderId: "user2", username: "TestUser2", text: "nwejkbf lweflwe lewfwe lkewlf lewbfew lbewfjl lkwehfliwe lkwelf ewlkewf lhwelf elw ewfwekfbwl", createdAt: Date())
    
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 83
        tableView.separatorStyle = .none
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardNotifications()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        messageTextView.layer.cornerRadius = 6
    }
    
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let keyboardOffset = view.convert(keyboardFrame.cgRectValue, from: nil).size.height
        bottomInputViewConstraint.constant -= keyboardOffset
        view.layoutIfNeeded()
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        bottomInputViewConstraint.constant = 0
        view.layoutIfNeeded()
    }
    
    @IBAction func sendMessageButtonTapped(_ sender: Any) {
        
        guard let user = user,
            let room = room else {
            presentErrorAlert(title: "Cannot Send Message", message: "Sending messages is not possible right now.")
            return
        }
        
        guard let message = messageTextView.text,
              message.count >= 1 else {
            presentErrorAlert(title: "Cannot Send Message", message: "Please ensure that you have entered at least one character")
            return
        }
        var messageData: [String: Any] = [
            "text": message,
            "senderId": user.id,
            "createdAt": Date().timeIntervalSince1970,
            "username": user.username
        ]
        
        if let avatarURL = user.avatarURL {
            messageData["avatarURL"] = avatarURL.absoluteString
        }
        
        Database.database().reference().child("messages").child(room.title).childByAutoId().setValue(messageData)
        
        messageTextView.text = nil
        view.endEditing(true)
    }
    

}

extension RoomViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        if message.senderId == "user1" {
            let cell = tableView.dequeueReusableCell(withIdentifier: SentTableViewCell.identifier) as! SentTableViewCell
            cell.configure(message: message)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ReceivedTableViewCell.identifier) as! ReceivedTableViewCell
            cell.configure(message: message)
            return cell
        }
    }
    
    
}
