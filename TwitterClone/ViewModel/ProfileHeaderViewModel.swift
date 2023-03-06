//
//  ViewModel.swift
//  TwitterClone
//
//  Created by 김민종 on 2023/03/06.
//

import Foundation

enum ProfileFilterOption: Int, CaseIterable {
    case tweets
    case replies
    case likes
    
    var description: String {
        switch self {
        case .tweets: return "Tweets"
        case .replies: return "Tweets & Replies"
        case .likes: return "Likes"

        }
    }
}
