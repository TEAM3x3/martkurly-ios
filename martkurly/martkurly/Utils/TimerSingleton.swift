//
//  TimerSingleton.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/16.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import Foundation

class TimerSingleton {
    static let shared = TimerSingleton()
    private init() { }

    static let nextReviews = "NEXTREVIEWS"

    var timer: Timer?
}
