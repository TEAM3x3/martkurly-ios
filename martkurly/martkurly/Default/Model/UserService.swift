//
//  User.swift
//  martkurly
//
//  Created by Kas Song on 10/4/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import Foundation

struct UserModel {
    let username: String
    let email: String
    let phone: String
    let nickname: String
    let gender: String
}

class UserService {
    static let shared = UserService()
    private init() {}

    var currentUser: UserModel?

    var username: String? = ""
    var email: String? = ""
    var phone: String? = ""
    var nickname: String? = ""
    var gender: String? = ""

    func loadData() {
        guard UserDefaults.standard.string(forKey: "token") != nil,
              let userData = UserDefaults.standard.dictionary(forKey: "user") as? [String: String] else { return }
        currentUser = UserModel(username: userData["username"] ?? "",
                                email: userData["email"] ?? "",
                                phone: userData["phone"] ?? "",
                                nickname: userData["nickname"] ?? "",
                                gender: userData["gender"] ?? "")
    }
}
