//
//  WelcomeViewController.swift
//  Signup
//
//  Created by TechCampus on 1/10/19.
//  Copyright © 2019 TechCampus. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
  
    //MARK: - IBOutlets
    @IBOutlet weak var lblWelcome: UILabel!
    
    //MARK: - Variables
    var userName = String()
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblWelcome.text = "Welcome \(userName)"
    }
    
    @IBAction func btnLogOutTapped(_ sender: Any) {
//        let alert = UIAlertController(title: "Log out", message: "Are you sure?", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (logOut) in
//            UserDefaults.standard.set(false, forKey: "userLogin")
//            self.dismiss(animated: true, completion: nil)
//        }))
//        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
//        present(alert, animated: true, completion: nil)
        
        UserDefaults.standard.set(false, forKey: "userLogin")
        self.dismiss(animated: true, completion: nil)
    }
}
