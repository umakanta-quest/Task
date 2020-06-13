//
//  ViewController.swift
//  Task
//
//  Created by Umakanta Sahoo on 12/06/20.
//  Copyright © 2020 Umakanta Sahoo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    //===============================================================
    //MARK: - ViewController LifeCycles
    //===============================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        loginButton.isEnabled = false
        [usernameTextField, passwordTextField].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
        
        loginButton.backgroundColor = .clear
        loginButton.layer.cornerRadius = 5
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.gray.cgColor
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    @IBAction func loginButtonAction(_ sender: UIButton) {
        view.endEditing(true)
        
        login()
    }

    
    func login() {
        // if isEmptyField() { return }
        showProgressIndicator(view: self.view)
        
        callLoginApi()
    }
    
    func callLoginApi() {
        
        
        let dispatchQueue = DispatchQueue(label:"MyQueue", qos: .background)
        dispatchQueue.async {
            sleep(3)
            DispatchQueue.main.async {
                hideProgressIndicator(view: self.view)
                
                self.performSegue(withIdentifier: "showTasks", sender: nil)
            }
        }
    }
    
    
    
    @objc func editingChanged(_ textField: UITextField) {
        
        textField.text = textField.text?.trimmingCharacters(in: .whitespaces)
        
//        guard
//            let username = usernameTextField.text, !username.isEmpty,
//            let password = passwordTextField.text, !password.isEmpty
//        else {
//            self.loginButton.isEnabled = false
//            return
//        }
        
        guard isValid() else {
            self.loginButton.isEnabled = false
            return
        }
        
        
        loginButton.isEnabled = true
    }
    
    
    //MARK: - Helper Methods
    
    func isEmptyField() -> Bool {
        var isEmpty = false
        if usernameTextField.text == kEmptyString {
            isEmpty = true
        }
        else if passwordTextField.text == kEmptyString {
            isEmpty = true
        }
        
        return isEmpty
    }
    
    
    func isValid() -> Bool {
        var isValid = false
        if usernameTextField.text!.count > 3 && passwordTextField.text!.count > 3 {
            isValid = true
        }
        
        return isValid
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}

