//
//  RegistraitionController.swift
//  TwitterClone
//
//  Created by 김민종 on 2023/02/20.
//

import UIKit
import Firebase
import FirebaseAuth



class RegistraitionController: UIViewController {
    //MARK: - Properties
    
    private let imagePicker = UIImagePickerController()
    private var profileImage: UIImage?
    
    
    private lazy var plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "icSystemSettingAbled"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(handleAddProfilePhoto), for: .touchUpInside)
        return button
    }()
    
    private lazy var emailContainerView: UIView = {
        let image = UIImage(named: "icHearingControlGameAbled")
        let view = Utilities().inputContainerView(withImage: image!, textField: emailTextField)
        
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let image = UIImage(named: "icHearingControlGameAbled")
        let view = Utilities().inputContainerView(withImage: image!, textField: passwordTextField)
        
        return view
    }()
    
    private lazy var fullNameContainerView: UIView = {
        let image = UIImage(named: "icHearingControlGameAbled")
        let view = Utilities().inputContainerView(withImage: image!, textField: fullNameTextField)
        
        return view
    }()
    
    private lazy var userNameContainerView: UIView = {
        let image = UIImage(named: "icHearingControlGameAbled")
        let view = Utilities().inputContainerView(withImage: image!, textField: userNameTextField)
        
        return view
    }()
    
    private let emailTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Email")
        return tf
        
    }()
    
    private let passwordTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Password")
        tf.isSecureTextEntry = true
        return tf
        
    }()
    
    private let fullNameTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Full Name")
        return tf
        
    }()
    
    private let userNameTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Username")
        tf.isSecureTextEntry = true
        return tf
        
    }()

    
    private lazy var alreadyHaveAccountButton: UIButton = {
        let button = Utilities().attributtedButton("Alredy have an acoount?", "  Log In")
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    private lazy var registrationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .black
        button.heightAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Seclector
    
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleAddProfilePhoto() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func handleRegistration() {
        guard let profileImage = profileImage else {
            print("Please select profile image")
            return
        }
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        guard let fullname = fullNameTextField.text else {return}
        guard let username = userNameTextField.text else {return}


        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error is \(error.localizedDescription)")
                return
            }

            guard let uid = result?.user.uid else {return}
            let values = ["email": email, "username": username, "fullname": fullname]
            let ref = Database.database().reference().child("users").child(uid)
            
            ref.updateChildValues(values) { (error, ref) in
                print("Debug Successfully updated")
            
        }

    
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .twitterBlue
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true

        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        plusPhotoButton.setDimensions(width: 150, height: 150)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,
                                                   passwordContainerView,
                                                   fullNameContainerView,
                                                   userNameContainerView,
                                                  registrationButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.anchor(top: plusPhotoButton.bottomAnchor,
                     left: view.leftAnchor,
                     right: view.rightAnchor,
                     paddingTop: 32,
                     paddingLeft: 32,
                     paddingRight: 32)
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(left: view.leftAnchor,
                                     bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                     right: view.rightAnchor,
                                     paddingLeft: 40,
                                     paddingRight: 40)
    }
}

//MARK: - UIImagePickerControllerDelegate

extension RegistraitionController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else {return}
        self.profileImage = profileImage
        
        
        plusPhotoButton.layer.cornerRadius = 150 / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.imageView?.contentMode = .scaleAspectFill
        plusPhotoButton.imageView?.clipsToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.black.cgColor
        plusPhotoButton.layer.borderWidth = 3
        
        self.plusPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        dismiss(animated: true, completion: nil)
    }
}
