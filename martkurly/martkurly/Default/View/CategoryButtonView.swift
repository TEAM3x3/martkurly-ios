//
//  CategoryButtonCell.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/08/22.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

class CategoryButtonView: UIView {

    // MARK: - Properties
    let title = StringManager().categoryTitle
    var btnDataArray: [String] = []
    var btnArray: [UIButton] = []
    var inBtnViewArray: [UIView] = []
    var heightArray: [Int] = []
    var height = 0

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConfigure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI
    private func setConfigure() {
        setConstraints()
    }

    private func setConstraints() {
        for i in title.indices {
            let btn = CategoryMainButton()
            let inBtn = CategorySecondButtonView()
            let data = StringManager()
            switch i {
            case 0:
                inBtn.configure(data: data.category0)
                height = data.category0.count * 50
                heightArray.append(height)
            case 1:
                inBtn.configure(data: data.category1)
                height = data.category1.count * 50
                heightArray.append(height)
            case 2:
                inBtn.configure(data: data.category2)
                height = data.category2.count * 50
                heightArray.append(height)
            case 3:
                inBtn.configure(data: data.category3)
                height = data.category3.count * 50
                heightArray.append(height)
            case 4:
                inBtn.configure(data: data.category2)
                height = data.category4.count * 50
                heightArray.append(height)
            case 5:
                inBtn.configure(data: data.category2)
                height = data.category5.count * 50
                heightArray.append(height)
            case 6:
                inBtn.configure(data: data.category6)
                height = data.category6.count * 50
                heightArray.append(height)
            case 7:
                inBtn.configure(data: data.category7)
                height = data.category7.count * 50
                heightArray.append(height)
            case 8:
                inBtn.configure(data: data.category8)
                height = data.category8.count * 50
                heightArray.append(height)
            case 9:
                inBtn.configure(data: data.category9)
                height = data.category9.count * 50
                heightArray.append(height)
            case 10:
                inBtn.configure(data: data.category10)
                height = data.category10.count * 50
                heightArray.append(height)
            case 11:
                inBtn.configure(data: data.category11)
                height = data.category11.count * 50
                heightArray.append(height)
            case 12:
                inBtn.configure(data: data.category12)
                height = data.category12.count * 50
                heightArray.append(height)
            case 13:
                inBtn.configure(data: data.category13)
                height = data.category13.count * 50
                heightArray.append(height)
            case 14:
                inBtn.configure(data: data.category14)
                height = data.category14.count * 50
                heightArray.append(height)
            case 15:
                inBtn.configure(data: data.category15)
                height = data.category15.count * 50
                heightArray.append(height)
            case 16:
                inBtn.configure(data: data.category16)
                height = data.category16.count * 50
                heightArray.append(height)
            default:
                break
            }
            btn.configure(
                image: title[i],
                setTitle: title[i])
            btn.tag = i
            inBtn.tag = i
            if btn.isSelected == true {
                btn.title.textColor = ColorManager.General.mainPurple.rawValue
                btn.chevron.image = UIImage(systemName: "chevron.up")
                btn.chevron.tintColor = ColorManager.General.mainPurple.rawValue
            }
            if btn.isSelected == false {
                btn.title.textColor = ColorManager.General.mainGray.rawValue
                btn.chevron.image = UIImage(systemName: "chevron.down")
                btn.chevron.tintColor = ColorManager.General.mainGray.rawValue
            }
            inBtnViewArray.append(inBtn)
            btnArray.append(btn)
            addSubview(btnArray[i])
            addSubview(inBtnViewArray[i])
        }

        for i in btnArray.indices {
            btnArray[i].addTarget(self, action: #selector(selectCategory(_:)), for: .touchUpInside)
            if i == 0 {
                btnArray[i].snp.makeConstraints {
                    $0.top.equalToSuperview()
                    $0.leading.width.equalToSuperview()
                    $0.height.equalTo(50)
                }
            } else {
                btnArray[i].snp.makeConstraints {
                    $0.top.equalTo(btnArray[i-1].snp.bottom).offset(0)
                    $0.leading.width.equalToSuperview()
                    $0.bottom.equalTo(inBtnViewArray[i].snp.top)
                    $0.height.equalTo(50)
                }
            }
        }
        for i in inBtnViewArray.indices {
            if i == 16 {
                inBtnViewArray[i].snp.makeConstraints {
                    $0.top.equalTo(btnArray[i].snp.bottom)
                    $0.leading.width.equalToSuperview()
                    $0.bottom.equalToSuperview().offset(300)
                    $0.height.equalTo(heightArray[i])
                }
            } else {
                inBtnViewArray[i].snp.makeConstraints {
                    $0.top.equalTo(btnArray[i].snp.bottom)
                    $0.leading.width.equalToSuperview()
                    $0.height.equalTo(heightArray[i])
                }
            }
            inBtnViewArray[i].isHidden = true
        }
    }

    @objc func selectCategory(_ sender: UIButton) {
        let i = sender.tag
        sender.isSelected.toggle()
        if sender.isSelected {
            inBtnViewArray[i].isHidden = false
            print(btnArray[i].isSelected)
            print(sender.tag)
            print(btnArray[i].tag)
            if btnArray[i].isSelected == true, btnArray[i].tag == sender.tag {
                if i != 16 {
                    btnArray[i + 1].snp.remakeConstraints {
                        $0.top.equalTo(btnArray[i].snp.bottom).offset(heightArray[i])
                        $0.leading.width.equalToSuperview()
                        $0.height.equalTo(50)
                    }
                } else {
                    btnArray[16].snp.remakeConstraints {
                        $0.top.equalTo(btnArray[15].snp.bottom).offset(0)
                        $0.leading.width.equalToSuperview()
                        $0.bottom.equalToSuperview().offset(-300)
                        $0.height.equalTo(50)
                    }
                }
            }

            for i in btnArray.indices {
                if btnArray[i].isSelected == true, btnArray[i].tag != sender.tag {
                    inBtnViewArray[i].isHidden = true
                    if i != 16 {
                        btnArray[i + 1].snp.remakeConstraints {
                            $0.top.equalTo(btnArray[i].snp.bottom).offset(0)
                            $0.leading.width.equalToSuperview()
                            $0.height.equalTo(50)
                        }
                    } else {
                        btnArray[16].snp.remakeConstraints {
                            $0.top.equalTo(btnArray[15].snp.bottom).offset(0)
                            $0.leading.width.equalToSuperview()
                            $0.height.equalTo(50)
                        }
                    }
                }
            }

        } else {
            inBtnViewArray[i].isHidden = true
            if i != 16 {
                btnArray[i + 1].snp.remakeConstraints {
                    $0.top.equalTo(btnArray[i].snp.bottom).offset(0)
                    $0.leading.width.equalToSuperview()
                    $0.height.equalTo(50)
                }
            } else {
                btnArray[16].snp.remakeConstraints {
                    $0.top.equalTo(btnArray[15].snp.bottom).offset(0)
                    $0.leading.width.equalToSuperview()
                    $0.height.equalTo(50)
                }
            }
        }
    }
}
