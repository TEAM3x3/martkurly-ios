//
//  AddressSearchView.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/08/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import WebKit
import Then

class AddressSearchView: UIView, WKUIDelegate {

    // MARK: - Properties
    private var web: WKWebView!
    private let url: String = "https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI
    private func setWeb() {
        let webConfigure = WKWebViewConfiguration()
        web = WKWebView(frame: .zero, configuration: webConfigure)

    }
}
