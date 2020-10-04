//
//  KakaoAddressVC.swift
//  martkurly
//
//  Created by Kas Song on 9/16/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import Then
import UIKit
import WebKit

class KakaoAddressVC: UIViewController {

    // MARK: - Properties
    private var containerView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 4
    }
    private var backButton = UIButton().then {
        let image = UIImage(systemName: "xmark")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        $0.setImage(image, for: .normal)
    }
    private var webView: WKWebView?
    private let indicator = UIActivityIndicatorView(style: .medium)

    private var zipCode = ""
    private var address = ""

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarStatus(type: .whiteType,
        isShowCart: false,
        leftBarbuttonStyle: .pop,
        titleText: StringManager.Sign.signUp.rawValue)
    }

    // MARK: - UI
    private func configureUI() {
        let backbroundColor = UIColor.black.withAlphaComponent(0.7)
        view.backgroundColor = backbroundColor
        setAttributes()
        setContraints()
    }

    private func setAttributes() {
        backButton.addTarget(self, action: #selector(handleButton(_:)), for: .touchUpInside)

        //message handler를 추가하는 메소드
        let contentController = WKUserContentController()
        contentController.add(self, name: "callBackHandler")

        let config = WKWebViewConfiguration()
        config.userContentController = contentController

        self.webView = WKWebView(frame: .zero, configuration: config)
        self.webView?.navigationDelegate = self

        guard
            let url = URL(string: "https://kasroid.github.io/Kakao-Postcode/"),
            let webView = webView
            else { return }

        let request = URLRequest(url: url)
        webView.load(request)
        indicator.startAnimating()
    }

    private func setContraints() {
        guard let webView = webView else { return }
        view.addSubview(containerView)

        [backButton, webView, indicator].forEach {
            containerView.addSubview($0)
        }

        containerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(20)
        }
        backButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(10)
        }
        webView.snp.makeConstraints {
            $0.top.equalTo(backButton.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        indicator.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }

    // MARK: - Selectors
    @objc
    private func handleButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension KakaoAddressVC: WKScriptMessageHandler {
    //데이터를 받았을때 Invoke 하는 메서드
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if let postCodeData = message.body as? [String: Any] {
            zipCode = postCodeData["zonecode"] as? String ?? ""
            address = postCodeData["roadAddress"] as? String ?? ""
        }
        print("Post Code:", zipCode)
        print("Address:", address)
        guard let navigationControllers = (self.presentingViewController as? UINavigationController)?.viewControllers else { print(#function, "Guard Activated"); return }
        for viewController in navigationControllers {
            if let signUpVC = viewController as? SignUpVC {
                signUpVC.address = address
                signUpVC.isMainAddressFilled = true
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
}

extension KakaoAddressVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        indicator.startAnimating()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicator.stopAnimating()
    }
}
