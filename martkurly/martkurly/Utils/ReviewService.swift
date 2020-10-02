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

    // MARK: - 해당 상품에 대한 리뷰 가져오기

    func requestProductReviews(productID: Int, completion: @escaping() -> Void) {
        let requestURL = KURLY_GOODS_REF + "/\(productID)" + REF_PRODUCT_REVIEW_LIST

        AF.request(requestURL, method: .get).responseJSON { response in
            print(response)
            completion()
        }
    }

    // MARK: - 유저가 작성한 리뷰 리스트 반환

    func requestUserReviews() {

    }

    // MARK: - 후기 생성

    func writeProductReivew() {

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
