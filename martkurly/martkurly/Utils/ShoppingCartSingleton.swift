//
//  ShoppingCartSingleton.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/19.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ShoppingCartSingleton {
    static let shared = ShoppingCartSingleton()
    private init() { }

    let shoppingCartView = ShoppingCartView()
}
