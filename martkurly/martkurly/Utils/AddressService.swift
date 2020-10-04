//
//  AddressService.swift
//  martkurly
//
//  Created by 천지운 on 2020/10/03.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import Foundation
import Alamofire

struct AddressService {
    static let shared = AddressService()
    private init() { }

    private let decoder = JSONDecoder()

    func requestAddressList(userPK: Int, completion: @escaping([AddressModel]) -> Void) {
        var userAddressList = [AddressModel]()

        let requestRef = REF_ADDRESS + "/\(userPK)" + "/address"

        AF.request(requestRef, method: .get).responseJSON { response in
            guard let jsonData = response.data else { return completion(userAddressList) }

            do {
                userAddressList = try decoder.decode([AddressModel].self, from: jsonData)
            } catch {
                print("DEBUG: Request Address List Error => ", error.localizedDescription)
            }
            completion(userAddressList)
        }
    }

    func deleteAddress(addressID: Int, completion: @escaping() -> Void) {
        let deleteRef = REF_ADDRESS + "/1" + "/address" + "/\(addressID)"

    }
}
