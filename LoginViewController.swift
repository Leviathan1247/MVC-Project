//
//  LoginViewController.swift
//  WelcomePatternMVC
//
//  Created by Левиафан on 2024-06-15.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.addTarget(self, action: #selector(self.validateFields), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(self.validateFields), for: .editingChanged)
        validateFields()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func validateFields() {
        let email = emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        _ = email?.isValidEmail() ?? false
        _ = password?.count ?? 0 >= 6
        
        loginBtn.isEnabled = (emailField != nil) && (passwordField != nil)
    }
    
    
    
    @IBAction func loginBtnClicked(_ sender: UIButton) {
        guard let email = emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let password = passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        else {
            return
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        Network.shared.login(email: email, password: password) { success in
            if success {
                self.goToHomePage()
            } else {
                self.showLoginError()
            }
        }
        
    }
    
    private func goToHomePage() {
        let controller = storyboard!.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        present(controller, animated: true,completion: nil)
    }
    
    private func showLoginError() {
        let alert = UIAlertController(title: "Incorrect login or password", message: "Check your data and try again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func dismissKeyboard () {
        view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        dismissKeyboard()
    }
}

    extension String {
        func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}

