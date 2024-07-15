//
//  HomeViewController.swift
//  WelcomePatternMVC
//
//  Created by Левиафан on 2024-06-15.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var welcomeLbl: UILabel!
    var user: ModelUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user = Network.shared.getLoggedInUser()
        welcomeUser()

    }
    
    private func welcomeUser() {
        guard let user = user else { return }
        welcomeLbl.text = "Hello, \(user.firstName) \(user.lastName)! "
    }

}


