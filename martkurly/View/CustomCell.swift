//
//  GrayCell.swift
//  martkurly
//
//  Created by ㅇ오ㅇ on 2020/09/08.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit
import Then

class CustomCell: UITableViewCell {

    static let identifier = "CustomCell"

    let stackView = UIStackView()

    let mainTitle = CategoryHeaderV()
    let subView = UIView().then {
        $0.backgroundColor = ColorManager.General.backGray.rawValue
    }
    //    let data = StringManager().categoryTitleData
    var data = [String: Any]() {
        didSet {
            setConfigure()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConfigure()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func prepareForReuse() {
        super.prepareForReuse()

    }

    private func setConfigure() {
        setConstraints()
    }

    private func setConstraints() {
        selectionStyle = .none

        guard
            let title = data["title"] as? String,
            let imageName = data["imageName"] as? String,
            let subTitle = data["inData"] as? [String] ?? nil
            else { return }

        mainTitle.configure(image: imageName, setTitle: title, direction: "chevron.down")

        mainTitle.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(50)
        }

        stackView.addArrangedSubview(mainTitle)

        for i in subTitle.indices {
            let btn = UIButton()
//            btn.titleLabel?.text = subTitle[i]
//            btn.titleLabel?.textColor = .black
            btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 64, bottom: 0, right: 0)
            btn.contentHorizontalAlignment = .left
            btn.setTitle(subTitle[i], for: .normal)
            btn.setTitleColor(.black, for: .normal)
            btn.tag = i
            btn.addTarget(self, action: #selector(setSubTitle(_:)), for: .touchUpInside)
            subView.addSubview(btn)
            if i == 0 {
                btn.snp.makeConstraints {
                    $0.top.equalTo(subView.snp.top)
                    $0.leading.trailing.equalToSuperview()
                    $0.height.equalTo(50)
                }
            } else {
                btn.snp.makeConstraints {
                    $0.top.equalTo(subView.snp.top).offset(50 * i)
                    $0.leading.trailing.equalToSuperview()
                    $0.height.equalTo(50)
                }
            }
            subView.snp.makeConstraints {
                $0.height.greaterThanOrEqualTo(50 * subTitle.count)
            }
//            subView.isHidden = true
            stackView.addArrangedSubview(subView)
        }

        stackView.distribution = .fill
        stackView.spacing = 0
        stackView.axis = .vertical

        contentView.addSubview(stackView)

        stackView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
//        for i in data.indices {
//            guard
//                let title = data[i]["title"] as? String,
//                let imageName = data[i]["imageName"] as? String,
//                let subTitle = data[i]["inData"] as? [String] ?? nil
//                else { return }
//            let mainTitle = CategoryHeaderV()
//            mainTitle.configure(image: imageName, setTitle: title, direction: "chevron.down")
//            mainTitle.btn.addTarget(self, action: #selector(setSubTitle(_:)), for: .touchUpInside)
//            mainTitle.btn.tag = i
//            stackView.addArrangedSubview(mainTitle)
//
//            let subView = UIView()
//            subView.backgroundColor = ColorManager.General.backGray.rawValue
//            for j in subTitle.indices {
//                let btn = UIButton()
//                btn.setTitle(subTitle[j], for: .normal)
//                btn.setTitleColor(.black, for: .normal)
//
//                subView.addSubview(btn)
//                if j == 0 {
//                    btn.snp.makeConstraints {
//                        $0.top.equalTo(subView.snp.top)
//                        $0.leading.equalToSuperview().offset(64)
//                        $0.height.equalTo(40)
//                    }
//                } else {
//                    btn.snp.makeConstraints {
//                        $0.top.equalToSuperview().offset(40 * j)
//                        $0.leading.equalToSuperview().offset(64)
//                        $0.height.equalTo(40)
//                    }
//                }
//            }
//            subView.snp.makeConstraints {
//                $0.height.equalTo(40 * subTitle.count)
//            }
//            subView.isHidden = true
//            stackView.addArrangedSubview(subView)
//        }
//
//        stackView.distribution = .fill
//        stackView.spacing = 0
//        stackView.axis = .vertical
//        contentView.addSubview(stackView)
//
//        stackView.snp.makeConstraints {
//            $0.top.leading.trailing.bottom.equalToSuperview()
//
//        }
    }

    // MARK: - Action
    @objc
    func setSubTitle(_ sender: UIButton) {
        print(sender.tag)
    }

    func configure(data: [String: Any]) {
        self.data = data
    }
}
