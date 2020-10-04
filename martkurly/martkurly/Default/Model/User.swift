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

    var username: String? = ""
    var email: String? = ""
    var phone: String? = ""
    var nickname: String? = ""
    var gender: String? = ""

    func loadData() {
        guard UserDefaults.standard.string(forKey: "token") != nil else { return }
        username = (UserDefaults.standard.dictionary(forKey: "user")! as! [String: String])["username"]!
        email = (UserDefaults.standard.dictionary(forKey: "user")! as! [String: String])["email"]!
        phone = (UserDefaults.standard.dictionary(forKey: "user")! as! [String: String])["phone"]!
        nickname = (UserDefaults.standard.dictionary(forKey: "user")! as! [String: String])["nickname"]!
        gender = (UserDefaults.standard.dictionary(forKey: "user")! as! [String: String])["gender"]!
    }
}
