//
//  NotificationController.swift
//  TwitterClone
//
//  Created by 김민종 on 2023/02/17.
//

import UIKit

class NotificationController: UIViewController {
    
    //MARK: - Properties
    
    //MARK: - Lifecycle
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    //MARK: - Helpers
    private func configureUI() {
        view.backgroundColor = .white
        
        let imageView = UIImageView(image: UIImage(named: "icTabHomeAbled"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView

    }

    
}
