//
//  CategoryTitleModel.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/09/07.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import Foundation

class CategoryTitleModel {
    var headerName: String?
    var subType = [String]()
    var isExpandable: Bool = false

    init(headerName: String, subType: [String], isExpandable: Bool) {
        self.headerName = headerName
        self.subType = subType
        self.isExpandable = isExpandable
    }
}
