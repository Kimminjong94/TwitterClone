//
//  MainTabController.swift
//  TwitterClone
//
//  Created by 김민종 on 2023/02/17.
//

import UIKit

class MainTabController: UITabBarController {

    //MARK: - Properties
    
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: "icTabHomeAbled"), for: .normal)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()
    
  
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewcontrollers()
        configureUI()
    }
    
    //MARK: - Selectors
    
    @objc func actionButtonTapped() {
        print(123)
    }
    
    
    //MARK: - Helpers
    
    func configureUI() {
        view.addSubview(actionButton)
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
        actionButton.layer.cornerRadius = 56 / 2
    }
    
    func configureViewcontrollers() {
        let feed = FeedController()
        let nav1 = templateNavigaitionController(image: UIImage(named: "icTabHomeAbled"), rootViewController: feed)
        
        let explore = ExploreController()
        let nav2 = templateNavigaitionController(image: UIImage(named: "icHearingControlGameAbled"), rootViewController: explore)

        let notifications = NotificationController()
        let nav3 = templateNavigaitionController(image: UIImage(named: "icSystemSettingAbled"), rootViewController: notifications)

        let conversations = ConversationController()
        let nav4 = templateNavigaitionController(image: UIImage(named: "icHearingControlCareAbled"), rootViewController: conversations)


        viewControllers = [nav1, nav2, nav3, nav4]
    }
    
    func templateNavigaitionController(image: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = .red
        return nav
        
    }

    

}
