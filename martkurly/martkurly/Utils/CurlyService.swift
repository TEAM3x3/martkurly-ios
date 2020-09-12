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

    func fetchCheapProducts(completion: @escaping([Product]) -> Void) {
        var cheapProducts = [Product]()

        AF.request(REF_CHEAP, method: .get).responseJSON { response in
            guard let jsonData = response.data else { completion(cheapProducts); return }
            do {
                let products = try self.decoder.decode([Product].self, from: jsonData)
                cheapProducts = products
                completion(cheapProducts)
            } catch {
                print("DEBUG: Cheap Products Request Error", error.localizedDescription)
            }
        }
    }

    func requestProductDetailData(productID: Int, completion: @escaping(ProductDetail?) -> Void) {
        let productURL = REF_GOODS + "\(productID)"
        AF.request(productURL, method: .get).responseJSON { response in
            guard let jsonData = response.data else { completion(nil); return }
            do {
                let productDetailInfo = try self.decoder.decode(ProductDetail?.self, from: jsonData)
                completion(productDetailInfo)
            } catch {
                print("DEBUG: Product Detail Request Error", error.localizedDescription)
                completion(nil)
            }
        }
    }
}
