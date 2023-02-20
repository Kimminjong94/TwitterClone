//
//  LoginController.swift
//  TwitterClone
//
//  Created by 김민종 on 2023/02/20.
//

import UIKit


class LoginController: UIViewController {
    //MARK: - Properties
    
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = UIImage(named: "icTabHomeAbled")
        return iv
    }()
    
    private lazy var emailContainerView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.backgroundColor = .red
        
        let iv = UIImageView()
        iv.image = UIImage(named: "icTabHomeAbled")
        view.addSubview(iv)
        iv.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, paddingLeft: 8, paddingBottom: 8)
        iv.setDimensions(width: 24, height: 24)
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.backgroundColor = .systemBlue
        
        let iv = UIImageView()
        iv.image = UIImage(named: "icHearingControlGameAbled")
        view.addSubview(iv)
        iv.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, paddingLeft: 8, paddingBottom: 8)
        iv.setDimensions(width: 24, height: 24)
        return view
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Seclector
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        logoImageView.setDimensions(width: 150, height: 150)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView])
        stack.axis = .vertical
        stack.spacing = 8
        
        view.addSubview(stack)
        stack.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor)
    }
}
