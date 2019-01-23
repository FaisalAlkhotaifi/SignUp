//
//  ViewController.swift
//  Signup
//
//  Created by TechCampus on 1/10/19.
//  Copyright © 2019 TechCampus. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {
    
    //MARK: - IBOutlets
    @IBOutlet weak var txtFieldUserName: UITextField!
    @IBOutlet weak var txtFieldEmail: UITextField!
    @IBOutlet weak var txtFieldCreatePassword: UITextField!
    @IBOutlet weak var txtFieldConfirmPassword: UITextField!
    @IBOutlet weak var textViewTerms: UITextView!
    @IBOutlet weak var lblLogo: UILabel!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting textfields layout
        textFieldLayout(placeHolder: "Username", imageName: "user", txtField: txtFieldUserName)
        textFieldLayout(placeHolder: "Email", imageName: "email", txtField: txtFieldEmail)
        txtFieldEmail.keyboardType = .emailAddress
        textFieldLayout(placeHolder: "Create Password", imageName: "password", txtField: txtFieldCreatePassword)
        textFieldLayout(placeHolder: "Confirm Password", imageName: "", txtField: txtFieldConfirmPassword)
        
        let attributedLogo = NSMutableAttributedString()
        attributedLogo.append(NSAttributedString(string: "Tech", attributes: [NSAttributedString.Key.font: UIFont(name: "Noteworthy", size: 17) as Any]))
        attributedLogo.append(NSAttributedString(string: "Campus", attributes: [NSAttributedString.Key.font: UIFont(name: "Helvetica Neue", size: 14) as Any]))
        
        lblLogo.attributedText = attributedLogo
        
        let attributedTermsTitle = NSMutableAttributedString()
        attributedTermsTitle.append(NSAttributedString(string: "By clicking the Sign Up button, you agree to our ", attributes: [NSAttributedString.Key.font:UIFont(name: "Helvetica Neue", size: 12)!]))
        attributedTermsTitle.append(NSAttributedString(string: "Terms & Conditions ", attributes: [NSAttributedString.Key.font:UIFont(name: "Helvetica Neue", size: 12)!, NSAttributedString.Key.link: "terms"]))
        attributedTermsTitle.append(NSAttributedString(string: "and Privacy Policy.", attributes: [NSAttributedString.Key.font: UIFont(name: "Helvetica Neue", size: 12)!]))
        
        textViewTerms.linkTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 25.0/255.0, green: 170.0/255.0, blue: 141.0/255.0, alpha: 1.0)]
        textViewTerms.attributedText = attributedTermsTitle
        
        textViewTerms.delegate = self
        textViewTerms.isSelectable = true
        textViewTerms.textAlignment = .center
        textViewTerms.isUserInteractionEnabled = true
        textViewTerms.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(termsAndConditionsTapped)))
    }
    
    //MARK: - Helpers
    private func textFieldLayout(placeHolder: String, imageName: String, txtField: UITextField) {
        txtField.delegate = self
        txtField.placeholder = placeHolder
        txtField.leftView = UIImageView(image: UIImage(named: imageName))
        txtField.leftViewMode = .always
        
        /* To add label instead of image
         let label = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
         label.text = "hi"
         txtField.leftView = label
         */
    }
    
    //check if email address is valid
    func isEmailAddressValid(emailTestString: String) -> Bool {
        //techcampus%2018+2019_Lectures@gmail.com
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailTestString)
    }
    
    @objc func termsAndConditionsTapped() {
        self.performSegue(withIdentifier: "GO_TO_TERMSCONDITIONS_PAGE", sender: nil)
    }
    
    func showAlert(title: String, msg: String, actionTitle: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        if (segue.identifier == "GO_TO_WELCOME_PAGE") {
            let welcomeVC = segue.destination as! WelcomeViewController
            // Pass the selected object to the new view controller.
            welcomeVC.userName = txtFieldUserName.text!
        }
        else if (segue.identifier == "GO_TO_TERMSCONDITIONS_PAGE") {
            _ = segue.destination as! TermsViewController
        }
    }
    
    //MARK: - IBAction
    @IBAction func btnSignupTapped(_ sender: Any) {
        //check if text fields are empty
        if (txtFieldUserName.text == "" || txtFieldEmail.text == "" || txtFieldCreatePassword.text == "" || txtFieldConfirmPassword.text == "") {
            
            showAlert(title: "Error", msg: "Empty fields not allowed", actionTitle: "Ok")
        }
        else if (txtFieldCreatePassword.text != txtFieldConfirmPassword.text) {
            showAlert(title: "Error", msg: "Passwords doesn't match", actionTitle: "Ok")
        } else {
            //locally stored data to say that user has loged in
            UserDefaults.standard.set(true, forKey: "userLogin")
            self.performSegue(withIdentifier: "GO_TO_WELCOME_PAGE", sender: nil)
        }
    }
}

//MARK: - extension UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField == txtFieldEmail && txtFieldEmail.text != ""){
            if (!isEmailAddressValid(emailTestString: txtFieldEmail.text!)) {
               
                showAlert(title: "Error", msg: "email address is not valid", actionTitle: "Ok")
            }
        }
    }
    //on return button skip to second text field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == txtFieldUserName) {
            txtFieldEmail.becomeFirstResponder()
        } else if(textField == txtFieldEmail) {
            txtFieldCreatePassword.becomeFirstResponder()
        } else if(textField == txtFieldCreatePassword) {
            txtFieldConfirmPassword.becomeFirstResponder()
        }
        else if(textField == txtFieldConfirmPassword) {
            textField.resignFirstResponder()
        }
        return true
    }
}

