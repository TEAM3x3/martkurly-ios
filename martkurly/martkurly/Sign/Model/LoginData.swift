//
//  LoginData.swift
//  martkurly
//
//  Created by Kas Song on 10/3/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import Foundation

struct LoginData: Decodable {
    let token: String
    let user: User

    struct User: Decodable {
        let username: String
        let email: String
        let phone: String
        let nickname: String
        let gender: String
    }
}
