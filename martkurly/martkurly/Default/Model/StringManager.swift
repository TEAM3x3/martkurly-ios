//
//  StringManager.swift
//  martkurly
//
//  Created by Doyoung Song on 8/19/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import Foundation

// 사용법: StringManager.HomeVC.howToUse.rawValue
// 새로운 값을 추가할 때는 case 를 생성하고 = 옆에 String 을 입력

struct StringManager {

    enum homeVC: String {
        case howToUse = "이렇게 여기에 원하는 텍스트를 여기에 입력하고 뷰컨에서 자동완성으로 사용하세요"
    }

    enum whyKurly: String {
        case title = "WHY KURLY"

//        case category1 = "깐깐한 상품위원회"
//        case categoryContent1 = "나와 내 가족이 먹고 쓸 상품을 고르는 마음으로 매주 상품을 직접 먹어보고, 경험해보고 성분, 맛, 안정성 등 다각도의 기준을 통과한 상품만을 판매합니다."
//
//        case category2 = "차별화된 Kurly Only 상품"
//        case categoryContent2 = "전국 각지와 해외의 훌륭한 생산자가 믿고 선택하는 파트너, 마켓컬리. 2천여 개가 넘는 컬리 단독 브랜드, 스펙의 Kurly Only 상품을 믿고 만나보세요."
//        case subTitle2 = "(온라인 기준 / 자사몰, 직구 제외)"
//
//        case category3 = "신선한 풀콜드체인 배송"
//        case categoryContent3 = "온라인 업계 최초로 산지에서 문 앞까지 상온, 냉장, 냉동 상품을 분리 포장 후 최적의 온도를 유지하는 냉장 배송 시스템, 풀콜드체인으로 상품을 신선하게 전해드립니다."
//        case subTitle3 = "(샛별배송에 한함)"
//
//        case category4 = "고객, 생산자를 위한 최선의 가격"
//        case categoryContent4 = "매주 대형 마트와 주요 온라인 마트의 가격 변동 상황을 확인해 신선식품은 품질을 타협하지 않는 선에서 최선의 가격으로, 가공식품은 언제나 합리적인 가격으로 정기 조정합니다."
//
//        case category5 = "환경을 생각하는 지속 가능한 유통"
//        case categoryContent5 = "친환경 포장재부터 생산자가 상품에만 집중할 수 있는 직매입 유통구조까지, 지속 가능한 유통을 고민하며 컬리를 있게 하는 모든 환경(생산자, 커뮤니티, 직원)이 더 나아질 수 있도록 노력합니다."
    }

    let whyKurly = [
        ["title": "깐깐한 상품위원회",
         "content": "나와 내 가족이 먹고 쓸 상품을 고르는 마음으로 \n매주 상품을 직접 먹어보고, 경험해보고 \n성분, 맛, 안정성 등 다각도의 기준을 통과한 \n상품만을 판매합니다.",
         "info": "",
         "imageName": "01_check"
        ],
        ["title": "차별화된 Kurly Only 상품",
         "content": "전국 각지와 해외의 훌륭한 생산자가 믿고 \n선택하는 파트너, 마켓컬리. 2천여 개가 넘는 \n컬리 단독 브랜드, 스펙의 Kurly Only 상품을 \n믿고 만나보세요.",
         "info": "(온라인 기준 / 자사몰, 직구 제외)",
         "imageName": "02_only"
        ],
        ["title": "신선한 풀콜드체인 배송",
         "content": "온라인 업계 최초로 산지에서 문 앞까지 상온, \n냉장, 냉동 상품을 분리 포장 후 최적의 온도를 \n유지하는 냉장 배송 시스템, 풀콜드체인으로 \n상품을 신선하게 전해드립니다.",
         "info": "(샛별배송에 한함)",
         "imageName": "03_cold"
        ],
        ["title": "고객, 생산자를 위한 최선의 가격",
         "content": "매주 대형 마트와 주요 온라인 마트의 가격 변동 \n상황을 확인해 신선식품은 품질을 타협하지 않는 \n선에서 최선의 가격으로, 가공식품은 언제나 \n합리적인 가격으로 정기 조정합니다.",
         "info": "",
         "imageName": "04_price"
        ],
        ["title": "환경을 생각하는 지속 가능한 유통",
         "content": "친환경 포장재부터 생산자가 상품에만 집중할 수 \n있는 직매입 유통구조까지, 지속 가능한 유통을 \n고민하며 컬리를 있게 하는 모든 환경(생산자, \n커뮤니티, 직원)이 더 나아질 수 있도록 노력합니다.",
         "info": "",
         "imageName": "05_eco"
        ]
    ]

    enum orderCancelNotice: String {
        case orderCancelNoticeTitle = "주문 취소 안내"

        case depositIdentify1 = "[입금 확인]단계"
        case depositIdentify2 = "마이컬리 > 주문 내역 상세페이지에서"
        case depositIdentify3 = "직접 취소하실 수 있습니다."

        case depositIdentifyAfter1 = "[입금 확인] 이후 단계"
        case depositIdentifyAfter2 = "고객행복센터로 문의해주세요."

        case paymentCancelRefund1 = "결제 승인 취소 / 환불"
        case paymentCancelRefund2 = "결제 수단에 따라 영업일 기준 3~7일 내에 처리해드립니다."
    }

    enum orderCancelMoreNotice: String {
        case orderCancel = "주문 취소 관련"

        case orderCancel1 = "∙ [상품 준비 중] 이후 단계에는 취소가 제한되는 점 고객님의 양해 \n   부탁드립니다."
        case orderCancel2 = "∙ 비회원은 모바일 App / Web > 마이컬리 > 비회원 주문 조회 페\n   이지에서 주문을 취소하실 수 있습니다."
        case orderCancel3 = "∙ 일부 예약 상품은 배송 3~4일 전에만 취소하실 수 있습니다."
        case orderCacnel4 = "∙ 주문 상품의 부분 취소는 불가능합니다. 전체 주문 취소 후 재구매\n   해 주세요."

        case paymentRefund = "결제 승인 취소 / 환불 관련"

        case paymentRefund1 = "∙ 카드 환불은 카드사 정책에 따르며, 자세한 사항은 카드사에 문의\n   해주세요."
        case paymentRefund2 = "∙ 결제 취소 시, 사용하신 적립금과 쿠폰도 모두 복원됩니다."
    }

    enum changeAndRefund: String {
        case changeAndRefundTitle = "교환 및 환불 안내"
    }

}
