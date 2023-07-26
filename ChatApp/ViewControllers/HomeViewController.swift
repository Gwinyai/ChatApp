//
//  HomeViewController.swift
//  ChatApp
//
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    @IBAction func profileButtonTapped(_ sender: Any) {
        
        performSegue(withIdentifier: "ProfileSegue", sender: nil)
        

    }

}


