//
//  User.swift
//  martkurly
//
//  Created by Kas Song on 10/4/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import Foundation

struct UserModel {
    let token: String
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

    func loadData() {
        guard let token = UserDefaults.standard.string(forKey: "token"),
              let userData = UserDefaults.standard.dictionary(forKey: "user") as? [String: String] else { return }
        currentUser = UserModel(token: token,
                                username: userData["username"] ?? "",
                                email: userData["email"] ?? "",
                                phone: userData["phone"] ?? "",
                                nickname: userData["nickname"] ?? "",
                                gender: userData["gender"] ?? "")
    }
}
