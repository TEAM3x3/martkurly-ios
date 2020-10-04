//
//  AddressViewModel.swift
//  martkurly
//
//  Created by 천지운 on 2020/10/04.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import Foundation

struct AddressViewModel {
    let address: AddressModel

    var totalAddressText: String {
        return address.address + " " + address.detail_address
    }

    var isStarsDelivery: Bool {
        return address.address.contains("경기") || address.address.contains("서울")
    }

    var isDefaultDelivery: Bool {
        return address.status == "T"
    }

    var userDataText: String {
        guard let currentUser = UserService.shared.currentUser else { return "" }
        return "\(currentUser.nickname), \(currentUser.phone)"
    }

    var receiveSpace: String {
        return "받으실 장소: \(address.receiving_place ?? "")"
    }
}
