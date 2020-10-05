//
//  ReviewService.swift
//  martkurly
//
//  Created by 천지운 on 2020/10/03.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import Foundation
import Alamofire

struct ReviewService {
    static let shared = ReviewService()
    private init() { }

    private let decoder = JSONDecoder()

    // MARK: - 해당 상품에 대한 리뷰 가져오기

    func requestProductReviews(productID: Int, completion: @escaping([ReviewModel]) -> Void) {
        var reviews = [ReviewModel]()

        let requestURL = KURLY_GOODS_REF + "/\(productID)" + REF_PRODUCT_REVIEW_LIST

        AF.request(requestURL, method: .get).responseJSON { response in
            guard let jsonData = response.data else { return completion(reviews) }

            do {
                reviews = try decoder.decode([ReviewModel].self, from: jsonData)
            } catch {
                print("DEBUG: Request User Reviews Error => \(error.localizedDescription)")
            }
            completion(reviews)
        }
    }

    // MARK: - 유저가 작성한 리뷰 리스트 반환

    func requestUserCompleteReviews(completion: @escaping([ReviewModel]) -> Void) {
        var reviews = [ReviewModel]()

        guard let currentUser = UserService.shared.currentUser else { return completion(reviews) }
        let headers: HTTPHeaders = ["Authorization": currentUser.token]

        AF.request(REF_USER_REVIEW_LIST, method: .get, headers: headers).responseJSON { response in
            guard let jsonData = response.data else { return completion(reviews) }

            do {
                reviews = try decoder.decode([ReviewModel].self, from: jsonData)
            } catch {
                print("DEBUG: Request User Reviews Error => \(error.localizedDescription)")
            }
            completion(reviews)
        }
    }

    // MARK: - 유저가 작성 가능한 리뷰 리스트 반환

    func requestUserPossibleReviews(completion: @escaping([CartItem]) -> Void) {
        var cartItems = [CartItem]()
        guard let currentUser = UserService.shared.currentUser else { return completion(cartItems) }
        let headers: HTTPHeaders = ["Authorization": currentUser.token]

        AF.request(REF_USER_POSSIBLE_REVIEW_LIST, method: .get, headers: headers).responseJSON { response in
            guard let jsonData = response.data else { return completion(cartItems) }

            do {
                cartItems = try decoder.decode([CartItem].self, from: jsonData)
            } catch {
                print("ERROR: \(error.localizedDescription)")
            }
            completion(cartItems)
        }
    }

    // MARK: - 후기 생성

    func writeProductReivew(reviewTitle: String, reviewContents: String, reviewItem: CartItem, completion: @escaping() -> Void) {
        guard let currentUser = UserService.shared.currentUser else { return completion() }
        let headers: HTTPHeaders = ["Authorization": currentUser.token]

        let parameters = ["title": reviewTitle,
                          "content": reviewContents,
                          "goods": reviewItem.goods.id,
                          "cartItem": reviewItem.id] as [String: Any]

        AF.request(REF_USER_REVIEW_LIST, method: .post, parameters: parameters, headers: headers).responseJSON { response in
            print(response)
            completion()
        }
    }

    // MARK: - 후기 상세 요청

    func requestReviewDetail() {

    }

    // MARK: - 후기 업데이트

    func updateReview() {

    }

    // MARK: - 후기 삭제

    func removeReview() {

    }
}
