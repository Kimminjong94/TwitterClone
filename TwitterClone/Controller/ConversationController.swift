//
//  ConversationController.swift
//  TwitterClone
//
//  Created by 김민종 on 2023/02/17.
//

import UIKit

class ConversationController: UIViewController {
    
    //MARK: - Properties
    
    //MARK: - Lifecycle
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    
    //MARK: - Helpers
    private func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "Messages"

    }

    
}

