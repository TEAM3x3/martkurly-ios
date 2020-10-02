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

    // MARK: - 메인화면 - 이 상품 어때요? 데이터 가져오기

    func fetchRecommendProducts(completion: @escaping([ProductDetail]) -> Void) {
        var recommendProducts = [ProductDetail]()

        AF.request(REF_RECOMMEND_PRODUCTS, method: .get).responseJSON { response in
            guard let jsonData = response.data else { return completion(recommendProducts) }

            do {
                recommendProducts = try self.decoder.decode([ProductDetail].self, from: jsonData)
            } catch {
                print("DEBUG: Recommend List Fetch Error, ", error.localizedDescription)
            }
            completion(recommendProducts)
        }
    }

    // MARK: - 타입 상품 목록 가져오기

    func requestTypeProdcuts(type: String, completion: @escaping([Product]) -> Void) {
        var typeProducts = [Product]()

        let parameters = ["type": type]
        AF.request(CURLY_GOODS_REF, method: .get, parameters: parameters).responseJSON { response in
            guard let jsonData = response.data else { return completion(typeProducts) }

            do {
                typeProducts = try self.decoder.decode([Product].self, from: jsonData)
            } catch {
                print("DEBUG: Category List Request Error, ", error.localizedDescription)
            }
            completion(typeProducts)
        }
    }

    // MARK: - 카테고리 전체보기 상품 목록 가져오기

    func requestCategoryProdcuts(category: String, completion: @escaping([Product]) -> Void) {
        var categoryProducts = [Product]()

        let parameters = ["category": category]
        AF.request(CURLY_GOODS_REF, method: .get, parameters: parameters).responseJSON { response in
            guard let jsonData = response.data else { return completion(categoryProducts) }

            do {
                categoryProducts = try self.decoder.decode([Product].self, from: jsonData)
            } catch {
                print("DEBUG: Category List Request Error, ", error.localizedDescription)
            }
            completion(categoryProducts)
        }
    }

    // MARK: - 카테고리 목록 가져오기

    func requestCurlyCategoryList(completion: @escaping([Category]) -> Void) {
        var categoryList = [Category]()

        AF.request(REF_CATEGORY, method: .get).responseJSON { response in
            guard let jsonData = response.data else { return completion(categoryList) }

            do {
                categoryList = try self.decoder.decode([Category].self, from: jsonData)
            } catch {
                print("DEBUG: Category List Request Error, ", error.localizedDescription)
            }
            completion(categoryList)
        }
    }

    // MARK: - 상품 검색 목록 가져오기

    func requestSearchProducts(searchKeyword: String, completion: @escaping([Product]) -> Void) {
        let headers: HTTPHeaders = ["Authorization": "token 88f0566e6db5ebaa0e46eae16f5a092610f46345"]
        let parameter = ["word": searchKeyword]
        var products = [Product]()

        AF.request(REF_SEARCH_PRODUCTS, method: .get, parameters: parameter, headers: headers).responseJSON { response in
            print(response)
            guard let jsonData = response.data else { return completion(products) }

            do {
                products = try self.decoder.decode([Product].self, from: jsonData)
            } catch {
                print("DEBUG: Search Products Request Error, ", error.localizedDescription)
            }
            completion(products)
        }
    }

    // MARK: - 메인 이벤트 목록 가져오기 & 이벤트 상품 가져오기

    func fetchMainEventList(completion: @escaping([MainEvent]) -> Void) {
        var mainEventList = [MainEvent]()

        AF.request(CURLY_MAIN_EVENT_REF, method: .get).responseJSON { response in
            guard let jsonData = response.data else { return completion(mainEventList) }

            do {
                let eventList = try self.decoder.decode([MainEvent].self, from: jsonData)
                mainEventList = eventList
            } catch {
                print("DEBUG: Main Event List Request Error, ", error.localizedDescription)
            }
            completion(mainEventList)
        }
    }

    func fetchMainEventProducts(eventID: Int, completion: @escaping(MainEventProducts?) -> Void) {
        AF.request(REF_MAIN_EVENT + "\(eventID)", method: .get).responseJSON { response in
            guard let jsonData = response.data else { return completion(nil) }

            do {
                let eventProducts = try self.decoder.decode(MainEventProducts.self, from: jsonData)
                completion(eventProducts)
            } catch {
                print("DEBUG: Main Event Products Request Error, ", error.localizedDescription)
                completion(nil)
            }
        }
    }

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
    func signUp(username: String, password: String, nickname: String, email: String, phone: String, gender: String, address: String, completionHandler: @escaping () -> Void ) {
        let value = [
            "username": username,
            "nickname": nickname,
            "password": password,
            "email": email,
            "phone": phone,
            "gender": gender,
            "address": address
        ]

        let urlString = REF_SIGNUP
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: value)

        AF.request(request).responseString { (response) in
            switch response.result {
            case .success(let data):
                print("Success", data)
                completionHandler()
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

    // MARK: - 로그인
    func signIn(username: String, password: String, completionHandler: @escaping (Bool, String?) -> Void) {
        let value = [
            "username": username,
            "password": password
        ]

        let signInURL = URL(string: REF_SIGNIN)!
        var request = URLRequest(url: signInURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: value)

        AF.request(request).responseString { (response) in
            switch response.result {
            case .success(let json):
                print("Success: ", json)
                guard let jsonData = response.data else { return }

                struct TokenData: Decodable {
                    let token: String
                }

                do {
                    let tokenData = try self.decoder.decode(TokenData.self, from: jsonData)
                    completionHandler(true, tokenData.token)
                } catch {
                    completionHandler(false, nil)
                }

            case .failure(let error):
                print("Error: ", error)
            }
        }
    }

    // MARK: - 장바구니

    func pushCartData(goods: Int, quantity: Int, cart: Int) {
        let value = [
            "goods": goods,
            "quantity": quantity,
            "cart": cart
        ]

        let cartURL = URL(string: REF_CART_PUSH)!
        let token = UserDefaults.standard.string(forKey: "token")!
        print(token)

        var request = URLRequest(url: cartURL)
        let headers: HTTPHeaders = ["Authorization": "token " + token]

        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: value)
        request.headers = headers

        AF.request(request).responseString { (response) in
            switch response.result {
            case .success(let data):
                print("Success", data)
            case .failure(let error):
                print("Faulure", error)
            }
        }
    }
    
    func deleteCartData(goods: [Int]) {
        let value = [
            "goods": [goods]
        ]

        let cartURL = URL(string: REF_CART_DELETE)!
        let token = UserDefaults.standard.string(forKey: "token")!

        var request = URLRequest(url: cartURL)
//        let headers: HTTPHeaders = ["Authorization": "token " + token]
        let headers: HTTPHeaders = ["Authorization": "token 88f0566e6db5ebaa0e46eae16f5a092610f46345"]

        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: value)
        request.headers = headers

        AF.request(request).responseString { (response) in
            switch response.result {
            case .success(let data):
                print("Success", data)
            case .failure(let error):
                print("Faulure", error)
            }
        }
    }
}
