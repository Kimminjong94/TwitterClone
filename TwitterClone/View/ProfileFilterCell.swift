//
//  ProfileFilterCell.swift
//  TwitterClone
//
//  Created by 김민종 on 2023/03/06.
//

import UIKit

class ProfileFilterCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    var option: ProfileFilterOption! {
        didSet {
            titleLabel.text = option.description
        }
    }
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Test Filter"
        return label
    }()
    
    
    override var isSelected: Bool {
        didSet {
            titleLabel.font = isSelected ? UIFont.boldSystemFont(ofSize: 16) : UIFont.systemFont(ofSize: 14)
            titleLabel.textColor = isSelected ? .black : .lightGray
        }
    }
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(titleLabel)
        titleLabel.center(inView: self)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
