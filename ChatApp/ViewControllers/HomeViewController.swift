//
//  HomeViewController.swift
//  ChatApp
//
//

import UIKit
import SDWebImage
import FirebaseDatabase
import FirebaseAuth

class HomeViewController: UIViewController {
    
    @IBOutlet weak var profileBarButtonItem: UIBarButtonItem!
    var rooms: [RoomModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        observeUserProfile()
        observeRooms()
    }
    
    func observeRooms() {
        RoomModel.reference.observe(.value) { [weak self] snapshot in
            guard let strongSelf = self else { return }
            guard let rooms = snapshot.value as? [String: Any] else { return }
            strongSelf.rooms = rooms.compactMap { RoomModel(data: $0) }
        }
    }
    
    func observeUserProfile() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("users").child(userId).observe(.value) { snapshot in
            if let data = snapshot.value as? [String: Any] {
                if let avatarURL = data["avatarURL"] as? String {
                    self.createLeftBarButtonItem(avatarURL: avatarURL)
                }
            }
        }
    }
    
    func createLeftBarButtonItem(avatarURL: String) {
        SDWebImageManager.shared.loadImage(with: URL(string: avatarURL), progress: nil) { image, _, error, _, _, _ in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            let button = UIButton()
            button.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
            button.setImage(image, for: .normal)
            button.addTarget(self, action: #selector(self.goToProfileVC), for: .touchUpInside)
            button.imageView?.contentMode = .scaleAspectFill
            button.clipsToBounds = true
            button.layer.cornerRadius = 17
            let customView = UIView(frame: CGRect(x: 0, y: 0, width: 34, height: 34))
            let barButton = UIBarButtonItem(customView: customView)
            barButton.customView?.addSubview(button)
            self.navigationItem.leftBarButtonItem = barButton
        }
    }
    
    @objc func goToProfileVC() {
        performSegue(withIdentifier: "ProfileSegue", sender: nil)
    }
    
    @IBAction func profileButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "ProfileSegue", sender: nil)
    }
    
    @IBAction func createRoomButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "CreateRoomSegue", sender: nil)
    }
    

}


