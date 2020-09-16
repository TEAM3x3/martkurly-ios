//
//  MainCurlyInfomationCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/16.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class MainCurlyInfomationCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "MainCurlyInfomationCell"

    private let defaultSideValue: CGFloat = 20

    private var policyStackView: UIStackView!
    private var textStackView: UIStackView!
    private var snsStackView: UIStackView!

    // MARK: - LifeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        configureInit()
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = ColorManager.General.backGray.rawValue

        textStackView = UIStackView(arrangedSubviews:
            [UILabel(), UILabel(), UILabel()])

        policyStackView = UIStackView(arrangedSubviews:
            [UIButton(type: .system), UIButton(type: .system), UIButton(type: .system)])
        policyStackView.spacing = 20

        snsStackView = UIStackView(arrangedSubviews:
            [UIButton(type: .system), UIButton(type: .system), UIButton(type: .system),
             UIButton(type: .system), UIButton(type: .system)])
        snsStackView.spacing = 12

        [policyStackView, textStackView, snsStackView].forEach {
            self.addSubview($0!)
            $0!.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(defaultSideValue)
                $0.centerY.equalToSuperview()
            }
        }
    }

    func configure(cellType: InfoCellType) {
        switch cellType.cellStyle {
        case .basic, .lastHighlight, .centerHighlight:
            cellType.description.enumerated().forEach {
                let textColor = $0.offset.isMultiple(of: 2) ?
                    ColorManager.General.chevronGray.rawValue :
                    ColorManager.General.mainPurple.rawValue

                self.editTextLabel(
                    label: textStackView.arrangedSubviews[$0.offset] as! UILabel,
                    text: $0.element,
                    textColor: textColor)
            }
        case .custom:
            if cellType == .curlyPolicy {
                cellType.description.enumerated().forEach {
                    let textColor = $0.offset != cellType.description.count - 1 ?
                        UIColor.gray : UIColor.darkGray

                    self.editTextButton(
                        button: policyStackView.arrangedSubviews[$0.offset] as! UIButton,
                        text: $0.element,
                        textColor: textColor,
                        textFont: .boldSystemFont(ofSize: 12))
                }
            } else {
                cellType.description.enumerated().forEach {
                    self.editSNSButton(
                        button: snsStackView.arrangedSubviews[$0.offset] as! UIButton,
                        imageName: $0.element)
                }
            }
        default:
            break
        }
    }

    func editTextLabel(label: UILabel, text: String, textColor: UIColor) {
        label.text = text
        label.textColor = textColor
        label.font = .systemFont(ofSize: 12)
    }

    func editTextButton(button: UIButton, text: String, textColor: UIColor, textFont: UIFont) {
        button.setTitle(text, for: .normal)
        button.setTitleColor(textColor, for: .normal)
        button.titleLabel?.font = textFont
    }

    func editSNSButton(button: UIButton, imageName: String) {
        let image: UIImage? = imageName.isEmpty ?
            nil : UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        button.layer.cornerRadius = 24 / 2

        button.snp.makeConstraints {
            $0.width.height.equalTo(24)
        }
    }

    func configureInit() {
        textStackView.arrangedSubviews.forEach {
            self.editTextLabel(label: $0 as! UILabel,
                               text: "",
                               textColor: .white)
        }

        policyStackView.arrangedSubviews.forEach {
            self.editTextButton(button: $0 as! UIButton,
                                text: "",
                                textColor: .white,
                                textFont: .boldSystemFont(ofSize: 12))
        }
        snsStackView.arrangedSubviews.forEach {
            self.editSNSButton(button: $0 as! UIButton,
                               imageName: "")
        }
    }
}
