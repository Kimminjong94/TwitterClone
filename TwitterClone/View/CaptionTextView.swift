//
//  CaptionTextView.swift
//  TwitterClone
//
//  Created by 김민종 on 2023/02/28.
//

import UIKit


class CaptionTextView: UITextView {

    let placeholederLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.text = "What' is it"
        return label
    }()
    
    //MARK: - Lifecylcle
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        backgroundColor = .white
        font = UIFont.systemFont(ofSize: 16)
        isScrollEnabled = false
        heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        addSubview(placeholederLabel)
        placeholederLabel.anchor(top:topAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 4)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc func handleTextInputChange() {
        placeholederLabel.isHidden = !text.isEmpty
    }
    
    
}
