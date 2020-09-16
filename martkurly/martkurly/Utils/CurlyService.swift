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

    // MARK: - 메인 이벤트 목록 가져오기

    func fetchMainEventList(completion: @escaping([MainEvent]) -> Void) {
        var mainEventList = [MainEvent]()

        AF.request(REF_MAIN_EVENT, method: .get).responseJSON { response in
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
}
