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

    func fetchEventList(completion: @escaping([EventModel]) -> Void) {
        var events = [EventModel]()

        AF.request(CURLY_EVENT_REF, method: .get).responseJSON { response in
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

    func fetchEventProducts(eventID: Int, completion: @escaping(EventProducts?) -> Void) {
        AF.request(REF_EVENT_GOODS + "\(eventID)", method: .get).responseJSON { response in
            guard let jsonData = response.data else { return completion(nil) }

            do {
                let eventProducts = try self.decoder.decode(EventProducts.self, from: jsonData)
                completion(eventProducts)
            } catch {
                print("DEBUG: Event Products Request Error, ", error.localizedDescription)
                completion(nil)
            }
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

        let urlString = REF_SIGNUP
        var request = URLRequest(url: URL(string: urlString)!)
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
    func checkUsername(username: String, completionHandler: @escaping (String) -> Void) {
        let urlString = REF_SIGNUP + "/check_username?username=" + username
        print(urlString)
        let request = URLRequest(url: URL(string: urlString)!)
        AF.request(request).responseJSON { (response) in
            switch response.result {
            case .success:
                switch response.response?.statusCode {
                case 200:
                    print("Great Username")
                    completionHandler("사용하실 수 있는 아이디입니다!")
                case 400:
                    print("Username is already taken.")
                    completionHandler("동일한 아이디가 이미 등록되어 있습니다")
                default:
                    print("Unknown Response StatusCode")
                    completionHandler("알 수 없는 오류가 발생했습니다")
                }
            case .failure(let error):
                print("Error", error.localizedDescription)
                completionHandler("통신에 실패했습니다. 다시 시도해주세요.")
            }
        }
    }
}
