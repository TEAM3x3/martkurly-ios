//
//  User.swift
//  martkurly
//
//  Created by Kas Song on 10/4/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import Foundation

class User {

    static let shared = User()
    private init() {}

    var id: Int? = 0
    var username: String? = ""
    var email: String? = ""
    var phone: String? = ""
    var nickname: String? = ""
    var gender: String? = ""

    func loadData() {
        guard UserDefaults.standard.string(forKey: "token") != nil else { return }
        guard
            let id = (UserDefaults.standard.dictionary(forKey: "user")!)["id"]! as? Int,
            let username = (UserDefaults.standard.dictionary(forKey: "user")!)["username"]! as? String,
            let email = (UserDefaults.standard.dictionary(forKey: "user")!)["email"]! as? String,
            let phone = (UserDefaults.standard.dictionary(forKey: "user")!)["phone"]! as? String,
            let nickname = (UserDefaults.standard.dictionary(forKey: "user")!)["nickname"]! as? String,
            let gender = (UserDefaults.standard.dictionary(forKey: "user")!)["gender"]! as? String
        else { print("DEBUG: Incorrect User Info"); return }
        self.id = id
        self.username = username
        self.email = email
        self.phone = phone
        self.nickname = nickname
        self.gender = gender
    }
}
