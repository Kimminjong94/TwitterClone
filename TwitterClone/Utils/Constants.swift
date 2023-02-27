//
//  Constants.swift
//  Pods
//
//  Created by 김민종 on 2023/02/24.
//

import Firebase

let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")

