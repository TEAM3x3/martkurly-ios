//
//  CategorySceondData.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/08/28.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import Foundation

func secondData() {
    for i in StringManager().categoryTitle.indices {
        let inBtn = CategorySecondButtonView()
        let data = StringManager()
        var height = 0
        switch i {
        case 0:
            inBtn.configure(data: data.category0)
            height = data.category0.count * 50
            CategoryButtonView().heightArray.append(height)
            print("0")
        case 1:
            inBtn.configure(data: data.category1)
            height = data.category1.count * 50
            CategoryButtonView().heightArray.append(height)
        case 2:
            inBtn.configure(data: data.category2)
            height = data.category2.count * 50
            CategoryButtonView().heightArray.append(height)
        case 3:
            inBtn.configure(data: data.category3)
            height = data.category3.count * 50
            CategoryButtonView().heightArray.append(height)
        default:
            break
        }
        inBtn.tag = i
        CategoryButtonView().inBtnViewArray.append(inBtn)
        CategoryButtonView().addSubview(CategoryButtonView().inBtnViewArray[i])
    }
}
