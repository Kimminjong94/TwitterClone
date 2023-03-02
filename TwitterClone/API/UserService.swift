//
//  UserService.swift
//  TwitterClone
//
//  Created by 김민종 on 2023/02/27.
//

import Firebase

struct UserService {
    static let shared = UserService()
    
    func fetchUser(completion: @escaping(User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
//            guard let key = snapshot.key as? String else {return}
//            print("my Key : \(key)")
            
            guard let dictionary = snapshot.value as? [String: AnyObject] else {return}
            print("\(dictionary)")
            
            let user = User(uid: uid, dictionary: dictionary)
            completion(user)

            
        }
    }
}
