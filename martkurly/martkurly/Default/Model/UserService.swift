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
    let id: Int
    let username: String  // 아이디
    let email: String
    let phone: String
    let nickname: String // 이름
    let gender: String
}

class UserService {
    static let shared = UserService()
    private init() {}

    var currentUser: UserModel?

    func loadData() {
        guard let token = UserDefaults.standard.string(forKey: "token"),
              let userData = UserDefaults.standard.dictionary(forKey: "user") else { return }
        currentUser = UserModel(token: "token \(token)",
                                id: userData["id"] as? Int ?? 0,
                                username: userData["username"] as? String ?? "EMPTY",
                                email: userData["email"] as? String ?? "EMPTY",
                                phone: userData["phone"] as? String ?? "EMPTY",
                                nickname: userData["nickname"] as? String ?? "EMPTY",
                                gender: userData["gender"] as? String ?? "EMPTY")
    }
}
