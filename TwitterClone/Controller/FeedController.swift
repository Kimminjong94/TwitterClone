//
//  FeedController.swift
//  TwitterClone
//
//  Created by 김민종 on 2023/02/17.
//

import UIKit
import SDWebImage

class FeedController: UIViewController {
    
    //MARK: - Properties
    
    var user: User? {
        didSet {
            configureLeftBarButton()
        }
    }
    
    //MARK: - Lifecycle
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    //MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .white
        
        let imageView = UIImageView(image: UIImage(named: "icTabHomeAbled"))
        imageView.contentMode = .scaleAspectFit
        imageView.setDimensions(width: 44, height: 44)
        navigationItem.titleView = imageView

    }
    
    func configureLeftBarButton() {
        guard let user = user else {return}
    
        let profilImageView = UIImageView()
        profilImageView.setDimensions(width: 32, height: 32 )
        profilImageView.layer.cornerRadius = 32 / 2
        profilImageView.layer.masksToBounds = true
        
        profilImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profilImageView)
    }
    
}
