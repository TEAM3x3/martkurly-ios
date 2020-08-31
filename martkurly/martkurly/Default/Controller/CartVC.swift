//
//  CartVC.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/08/31.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class CartVC: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarStatus(
            type: .whiteType,
            isShowCart: false,
            leftBarbuttonStyle: .dismiss,
            titleText: "장바구니")
    }
    
    // MARK: - UI
    private func setConfigure() {
        setConstraints()
    }
    
    private func setConstraints() {
        
    }
}
