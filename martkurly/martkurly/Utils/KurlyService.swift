//
//  CurlyService.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/08.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import Alamofire
import Foundation

struct KurlyService {
    static let shared = KurlyService()
    private init() { }

    private let decoder = JSONDecoder()

    // MARK: - [추천] 데이터 상품 목록 가져오기

    func fetchRecommendationReviewProducts(completion: @escaping(ReviewProductsModel?) -> Void) {
        AF.request(REF_RC_REVIEW_GOODS, method: .get).responseJSON { response in
            guard let jsonData = response.data else { return completion(nil) }

            do {
                let responseData = try self.decoder.decode(ReviewProductsModel.self, from: jsonData)
                completion(responseData)
            } catch {
                print("ERROR: Recommendation ERROR, \(error.localizedDescription)")
                completion(nil)
            }
        }
    }

    func fetchRecommendationProducts(requestURL: String,
                                     completion: @escaping(Recommendation?) -> Void) {
        AF.request(requestURL, method: .get).responseJSON { response in
            guard let jsonData = response.data else { return completion(nil) }

            do {
                let responseData = try self.decoder.decode(Recommendation.self, from: jsonData)
                completion(responseData)
            } catch {
                print("ERROR: Recommendation ERROR, \(error.localizedDescription)")
                completion(nil)
            }
        }
    }

    // MARK: - MD의 추천 상품 목록 가져오기

    func fetchMDRecommendProducts(completion: @escaping([MDRecommendModel]) -> Void) {
        var recommendProducts = [MDRecommendModel]()

        AF.request(REF_MDRECOMMAND_PRODUCTS, method: .get).responseJSON { response in
            guard let jsonData = response.data else { return completion(recommendProducts) }

            do {
                recommendProducts = try self.decoder.decode([MDRecommendModel].self, from: jsonData)
            } catch {
                print("ERROR: SQAURE DATA REQUEST ERROR, \(error.localizedDescription)")
            }
            completion(recommendProducts)
        }
    }

    // MARK: - 이벤트 소식 데이터 가져오기

    func fetchSqaureEventList(completion: @escaping([EventSqaureModel]) -> Void) {
        var sqaureEvents = [EventSqaureModel]()

        AF.request(REF_SQAURE_EVENTS, method: .get).responseJSON { response in
            guard let jsonData = response.data else { return completion(sqaureEvents) }

            do {
                sqaureEvents = try self.decoder.decode([EventSqaureModel].self, from: jsonData)
            } catch {
                print("ERROR: SQAURE DATA REQUEST ERROR, \(error.localizedDescription)")
            }
            completion(sqaureEvents)
        }
    }

    // MARK: - 상품들의 정보 가져오기

    func fetchProducts(requestURL: String, completion: @escaping([Product]) -> Void) {
        var products = [Product]()

        AF.request(requestURL, method: .get).responseJSON { response in
            guard let jsonData = response.data else { return completion(products) }

            do {
                products = try self.decoder.decode([Product].self, from: jsonData)
            } catch {
                print("DEBUG: Products List Fetch Error, ", error.localizedDescription)
            }
            completion(products)
        }
    }

    // MARK: - 신상품 상품 가져오기

    func fetchNewProducts(completion: @escaping([Product]) -> Void) {
        var newProducts = [Product]()

        AF.request(REF_NEW_PRODUCTS, method: .get).responseJSON { response in
            guard let jsonData = response.data else { return completion(newProducts) }
            do {
                let products = try self.decoder.decode([Product].self, from: jsonData)
                newProducts = products
            } catch {
                print("DEBUG: New Products Request Error, ", error.localizedDescription)
            }
            completion(newProducts)
        }
    }

    // MARK: - 베스트 상품 가져오기

    func fetchBestProducts(completion: @escaping([Product]) -> Void) {
        var bestProducts = [Product]()

        AF.request(REF_BEST_PRODUCTS, method: .get).responseJSON { response in
            guard let jsonData = response.data else { completion(bestProducts); return }
            do {
                let products = try self.decoder.decode([Product].self, from: jsonData)
                bestProducts = products
            } catch {
                print("DEBUG: Cheap Products Request Error, ", error.localizedDescription)
            }
            completion(bestProducts)
        }
    }

    // MARK: - [홈] > [컬리추천] > [이 상품 어때요?]

    func fetchRecommendProducts(completion: @escaping([Product]) -> Void) {
        var recommendProducts = [Product]()

        AF.request(REF_RECOMMEND_PRODUCTS, method: .get).responseJSON { response in
            guard let jsonData = response.data else { return completion(recommendProducts) }

            do {
                recommendProducts = try self.decoder.decode([Product].self, from: jsonData)
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
        AF.request(KURLY_GOODS_REF, method: .get, parameters: parameters).responseJSON { response in
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
        AF.request(KURLY_GOODS_REF, method: .get, parameters: parameters).responseJSON { response in
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

    // MARK: - 인기 검색어 가져오기

    func fetchPopularSearchWords(completion: @escaping([PopularSearchModel]) -> Void) {
        var searchWords = [PopularSearchModel]()
        guard let currentUser = UserService.shared.currentUser else { return completion(searchWords) }
        let requestURL = REF_USER + "/\(currentUser.id)" + "/search_word/popular_word"

        AF.request(requestURL, method: .get).responseJSON { response in
            guard let jsonData = response.data else { return completion(searchWords) }

            do {
                searchWords = try self.decoder.decode([PopularSearchModel].self, from: jsonData)
            } catch {
                print("DEBUG: Popular Search Request Error, ", error.localizedDescription)
            }
            completion(searchWords)
        }
    }

    // MARK: - 최근 검색어 가져오기

    func fetchRecentSearchWords(completion: @escaping([RecentSearchModel]) -> Void) {
        var searchWords = [RecentSearchModel]()
        guard let currentUser = UserService.shared.currentUser else { return completion(searchWords) }
        let requestURL = REF_USER + "/\(currentUser.id)" + "/search_word"

        AF.request(requestURL, method: .get).responseJSON { response in
            guard let jsonData = response.data else { return completion(searchWords) }

            do {
                searchWords = try self.decoder.decode([RecentSearchModel].self, from: jsonData)
            } catch {
                print("DEBUG: Recent Search Request Error, ", error.localizedDescription)
            }
            completion(searchWords)
        }
    }

    // MARK: - 상품 검색 상품 목록 가져오기(저장)

    func requestSaveSearchProducts(searchKeyword: String, completion: @escaping([Product]) -> Void) {
        var products = [Product]()
        guard let currentUser = UserService.shared.currentUser else { return completion(products) }
        let headers: HTTPHeaders = ["Authorization": currentUser.token]
        let parameter = ["word": searchKeyword]

        AF.request(REF_SEARCH_WORD_PRODUCTS, method: .get, parameters: parameter, headers: headers).responseJSON { response in
            guard let jsonData = response.data else { return completion(products) }

            do {
                products = try self.decoder.decode([Product].self, from: jsonData)
            } catch {
                print("DEBUG: Search Products Request Error, ", error.localizedDescription)
            }
            completion(products)
        }
    }

    // MARK: - 상품 검색 상품 목록 가져오기(타이핑)

    func requestTypingSearchProducts(searchKeyword: String, completion: @escaping([Product]) -> Void) {
        var products = [Product]()
        guard let currentUser = UserService.shared.currentUser else { return completion(products) }
        let headers: HTTPHeaders = ["Authorization": currentUser.token]
        let parameter = ["word": searchKeyword]

        AF.request(REF_SEARCH_TYPING_PRODUCTS, method: .get, parameters: parameter, headers: headers).responseJSON { response in
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

        AF.request(KURLY_MAIN_EVENT_REF, method: .get).responseJSON { response in
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

        AF.request(KURLY_EVENT_REF, method: .get).responseJSON { response in
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

        AF.request(REF_CHEAP_PRODUCTS, method: .get).responseJSON { response in
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

        let urlString = REF_USER
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
        let urlString = REF_USER + "/check_username?username=" + username
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
    func signIn(username: String, password: String, completionHandler: @escaping (Bool, LoginData?) -> Void) {
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

                do {
                    let loginData = try self.decoder.decode(LoginData.self, from: jsonData)
                    completionHandler(true, loginData)
                } catch {
                    completionHandler(false, nil)
                }

            case .failure(let error):
                print("Error: ", error)
            }
        }
    }

    // MARK: - 장바구니 속 상품

    func setListCart(completion: @escaping([Cart]) -> Void) {
        guard let currentUser = UserService.shared.currentUser else { return completion([])}

        var cartList = [Cart]()
        let headers: HTTPHeaders = ["Authorization": currentUser.token]

//        AF.request(REF_CART_LOCAL, method: .get, headers: headers).responseJSON { response in
        AF.request(REF_CART, method: .get, headers: headers).responseJSON { response in
            guard let jsonData = response.data else { print("Guard"); return completion(cartList) }
            do {
                let cartUpList = try self.decoder.decode(Cart.self, from: jsonData)
                cartList = [cartUpList]
            } catch {
                print("DEBUG: Cart List Request Error, ", error)
            }
            completion(cartList)
        }
    }

    // MARK: - 장바구니 상품 추가

    func pushCartData(goods: Int, quantity: Int, cart: Int, completionHandler: @escaping () -> Void) {
        let value = [
            "goods": goods,
            "quantity": quantity,
            "cart": cart
        ]

//        let cartURL = URL(string: REF_CART_PUSH_LOCAL)!
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
                completionHandler()
                print("Success", data)
            case .failure(let error):
                print("Faulure", error)
            }
        }
    }

    // MARK: - 장바구니 상품 업데이트

    func cartUpdata(goods: Int, quantity: Int, cart: Int) {
        let value = [
            "goods": goods,
            "quantity": quantity,
            "cart": cart
        ]

        let id = goods

//        let cartURL = URL(string: REF_CART_PUSH_LOCAL + "/\(id)")!
        let cartURL = URL(string: REF_CART_PUSH + "/\(id)")!
        let token = UserDefaults.standard.string(forKey: "token")!
        print(token)

        var request = URLRequest(url: cartURL)
        let headers: HTTPHeaders = ["Authorization": "token " + token]

        request.httpMethod = "PATCH"
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

    // MARK: - 장바구니 상품 삭제
    func deleteCartData(goods: [Int]) {

//        let value = [ "items": [goods] ]

        var urlResult = ""
        for i in goods {
             urlResult += "\(i)" + ","
        }
        urlResult.removeLast(1)
        print(urlResult)

        let value = ["items": urlResult]

//        let cartURL = URL(string: REF_CART_DELETE_LOCAL + "/\(urlResult)")!
//        let cartURL = URL(string: REF_CART_DELETE_LOCAL + "/goods_delete")!
//        let cartURL = URL(string: REF_CART_DELETE + "/goods_delete")!
        let cartURL = URL(string: REF_CART_DELETE)!
        let token = UserDefaults.standard.string(forKey: "token")!

        var request = URLRequest(url: cartURL)
        let headers: HTTPHeaders = ["Authorization": "token " + token]
//        let headers: HTTPHeaders = ["Authorization": "token 88f0566e6db5ebaa0e46eae16f5a092610f46345"]

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

    // MARK: - 장바구니

    func cartUpdate(completion: @escaping([Cart]) -> Void) {
        let headers: HTTPHeaders = ["Authorization": "token 88f0566e6db5ebaa0e46eae16f5a092610f46345"]
        var cartList = [Cart]()

        AF.request(REF_CART, method: .get, headers: headers).responseJSON { response in
            guard let jsonData = response.data else { print("Guard"); return completion(cartList) }
            print(jsonData)
            do {
                let cartUpList = try self.decoder.decode(Cart.self, from: jsonData)
                print(cartUpList)
                cartList = [cartUpList]
            } catch {
                print("DEBUG: Cart List Request Error, ", error)
            }
            completion(cartList)
        }
    }

    // MARK: - 주문 생성

    func createOrder(cartItems: [Int], completion: @escaping(Int?) -> Void) {
        guard let currentUser = UserService.shared.currentUser else { return completion(nil) }

        let headers: HTTPHeaders = ["Authorization": currentUser.token]
        let parameters = ["items": cartItems]

        AF.request(REF_ORDER,
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: headers).responseJSON { response in
                    guard let jsonData = response.data else { return completion(nil) }

                    do {
                        let orderID = try self.decoder.decode(OrderModel.self, from: jsonData)
                        print(response.response?.statusCode)
                        completion(orderID.id)
                    } catch {
                        print("ERROR: ORDER CREATE FAIL, \(error.localizedDescription)")
                        print(response.response?.statusCode)
                        completion(nil)
                    }
        }
    }

    /*
     "delivery_cost": 0,
     "point": 0,
     "consumer": "string",
     "receiver": "string",
     "receiver_phone": "string",
     "delivery_type": "샛별배송",
     "zip_code": "string",
     "address": "string",
     "receiving_place": "0",
     "entrance_password": "string",
     "free_pass": true,
     "etc": "string",
     "extra_message": "string",
     "message": true,
     "payment_type": "카카오페이"
     */

    func createOrderDetail(orderID: Int,
                           delivery_cost: Int?,
                           consumer: String?, // username
                           receiver: String, // nickname
                           receiver_phone: String,
                           delivery_type: String, // "샛별배송", "택배배송"
                           zip_code: String, // "123456"
                           address: String,
                           receiving_place: String,
                           entrance_password: String?,
                           free_pass: Bool?,
                           etc: String?,
                           extra_message: String?,
                           message: Bool,
                           payment_type: String?,
                           completion: @escaping(Bool) -> Void) {
        let parameters = [
            "delivery_cost": delivery_cost as Any,
            "consumer": consumer as Any,
            "receiver": receiver,
            "receiver_phone": receiver_phone,
            "delivery_type": delivery_type,
            "zip_code": "23412",
            "address": address,
            "receiving_place": receiving_place,
            "entrance_password": entrance_password as Any,
            "free_pass": free_pass as Any,
            "etc": etc as Any,
            "extra_message": extra_message as Any,
            "message": message,
            "payment_type": "카카오페이"
        ] as [String: Any]

        let requestURL = REF_ORDER + "/\(orderID)/detail"
        AF.request(requestURL, method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default).responseJSON { response in
                    print(response)
                    if let statusCode = response.response?.statusCode {
                        completion(statusCode < 400 ? true : false)
                    } else {
                        completion(false)
                    }
        }
    }

    // MARK: - 마이컬리 주문내역 리스트
    func fetchOrderList(token: String, completionHandler: @escaping ([Order]) -> Void) {
        let headers: HTTPHeaders = ["Authorization": token]
//        let headers: HTTPHeaders = ["Authorization": "token 88f0566e6db5ebaa0e46eae16f5a092610f46345"]

        let urlString = REF_USER_ORDER
//        let urlString = REF_ORDER_LOCAL

        var request = URLRequest(url: URL(string: urlString)!)
        request.headers = headers
        AF.request(request).responseJSON { (response) in
            switch response.result {
            case .success:
                guard let jsonData = response.data else { print("No Data"); return }
                do {
                    let data = try decoder.decode([Order].self, from: jsonData)
                    print(#function, "Parsing Success")
                    completionHandler(data)
                } catch {
                    print(#function, "Parsing Error", error)
                }
            case .failure(let error):
                print("Failure: ", error)
            }
        }
    }

    // MARK: - 마이컬리 자주사는 상품 리스트
    func fetchFrequantlyBuyingProductsData(token: String, completionHandler: @escaping (FrequantlyBuyingProducts) -> Void) {
        print(#function)
        let headers: HTTPHeaders = ["Authorization": token]
        print(headers)
//        let headers: HTTPHeaders = ["Authorization": "token 88f0566e6db5ebaa0e46eae16f5a092610f46345"]
//        let urlString = REF_OFTEN_PURCHASE_LOCAL
        let urlString = REF_OFTEN_PURCHASE

        var request = URLRequest(url: URL(string: urlString)!)
        request.headers = headers
        AF.request(request).responseJSON { (response) in
            switch response.result {
            case .success:
                guard let jsonData = response.data else { return }
                do {
                    let data = try self.decoder.decode(FrequantlyBuyingProducts.self, from: jsonData)
                    print(#function, "Parsing Success", data.goods_purchase_count ?? 0)
                    completionHandler(data)
                } catch {
                    print("Parsing Error", error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
