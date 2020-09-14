//
//  CurlyService.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/08.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import Alamofire
import Foundation

struct CurlyService {
    static let shared = CurlyService()
    private init() { }

    private let decoder = JSONDecoder()

    // MARK: - 이벤트 목록 및 이벤트 상품 가져오기

    func fetchEventProducts(completion: @escaping([EventModel]) -> Void) {
        var events = [EventModel]()

        AF.request(REF_EVENTLIST, method: .get).responseJSON { response in
            guard let jsonData = response.data else { return completion(events) }

            do {
                let eventList = try self.decoder.decode([EventModel].self, from: jsonData)
                events = eventList
            } catch {
                print("DEBUG: Event List Request Error, ", error.localizedDescription)
            }
            completion(events)
        }
    }

    // MARK: - 알뜰상품 목록 가져오기

    func fetchCheapProducts(completion: @escaping([Product]) -> Void) {
        var cheapProducts = [Product]()

        AF.request(REF_CHEAP, method: .get).responseJSON { response in
            guard let jsonData = response.data else { completion(cheapProducts); return }
            do {
                let products = try self.decoder.decode([Product].self, from: jsonData)
                cheapProducts = products
            } catch {
                print("DEBUG: Cheap Products Request Error, ", error.localizedDescription)
            }
            completion(cheapProducts)
        }
    }

    // MARK: - 상품 상세 정보 가져오기

    func requestProductDetailData(productID: Int, completion: @escaping(ProductDetail?) -> Void) {
        let productURL = REF_GOODS + "\(productID)"
        AF.request(productURL, method: .get).responseJSON { response in
            guard let jsonData = response.data else { completion(nil); return }
            do {
                let productDetailInfo = try self.decoder.decode(ProductDetail?.self, from: jsonData)
                completion(productDetailInfo)
            } catch {
                print("DEBUG: Product Detail Request Error, ", error.localizedDescription)
                completion(nil)
            }
        }
    }

    // MARK: - 회원가입
    func signUp(username: String, password: String, email: String, phone: String, gener: String, address: String) {
        let value = [
            "username": username,
            "password": password,
            "email": email,
            "phone": phone,
            "gender": gener,
            "address": address
        ]

        let url = REF_SIGNUP
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: value)

        AF.request(request).responseJSON { (response) in
            switch response.result {
            case .success(let data):
                print("Success", data)
            case .failure(let error):
                print("Failure", error)
            }
        }
    }
    
    // MARK: - 아이디 중복확인
    
}
