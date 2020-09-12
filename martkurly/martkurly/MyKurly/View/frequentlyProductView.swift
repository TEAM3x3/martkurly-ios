//
//  CategoryMainView.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/08/21.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

protocol ExpandableHeaderViewDelegate: AnyObject {
    func toggleSection(header: frequentlyProductView, section: Int)
}

class frequentlyProductView: UITableViewHeaderFooterView {

    weak var delegate: ExpandableHeaderViewDelegate?
    var section: Int?

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    func selectHeaderAction(gestureRecognizer: UITapGestureRecognizer) {
        let cell = gestureRecognizer.view as! frequentlyProductView
        delegate?.toggleSection(header: self, section: cell.section!)

    }

    func customInit(imageName: String, title: String, chevron: String, section: Int, delegate: ExpandableHeaderViewDelegate) {
        let header = CategoryHeaderV()
        header.configure(image: imageName, setTitle: title, direction: chevron)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

    }

}
