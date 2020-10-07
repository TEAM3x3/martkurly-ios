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

    // MARK: - 배송지 등록

    func registerAddress(delivery: DeliverySpaceModel, completion: @escaping(Bool) -> Void) {
        guard let currentUser = UserService.shared.currentUser else { return completion(false) }
        let registerRef = REF_ADDRESS + "/\(currentUser.id)" + "/address/order"

        let headers: HTTPHeaders = ["Authorization": currentUser.token]
        let parameters = [
            "address": delivery.address,
            "detail_address": delivery.detail_address,
            "status": delivery.status,
            "receiving_place": delivery.receiving_place,
            "entrance_password": delivery.entrance_password ?? "False",
            "free_pass": delivery.free_pass,
            "etc": delivery.etc ?? "False",
            "message": delivery.message ?? true,
            "extra_message": delivery.extra_message ?? "False"
        ] as [String: Any]

        AF.request(registerRef, method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: headers).responseJSON { response in
                    switch response.result {
                    case .success:
                        if let status = response.response?.statusCode,
                           status >= 400 {
                            completion(false)
                        } else {
                            completion(true)
                        }
                    case .failure: completion(false)
                    }
        }
    }

    // MARK: - 배송지 목록 가져오기

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

    // MARK: - 배송지 삭제

    func deleteAddress(addressID: Int, completion: @escaping() -> Void) {
        let deleteRef = REF_ADDRESS + "/1" + "/address" + "/\(addressID)"

        AF.request(deleteRef, method: .delete).responseJSON { _ in
            completion()
        }
    }
}
