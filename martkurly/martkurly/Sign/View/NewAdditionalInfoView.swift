//
//  NewAdditionalInfoView.swift
//  martkurly
//
//  Created by Kas Song on 9/23/20.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class NewAdditionalInfoView: UIView {

    // MARK: - Properties
    private let titleView = SignUpTextFieldTitleView(title: StringManager.SignUp.additionalInfo.rawValue, mendatory: false)
    private let subtitleView = UILabel().then {
        $0.text = StringManager.SignUp.additionalInfoSubtitle.rawValue
        $0.textColor = .agreementInfoGray
        $0.font = UIFont.systemFont(ofSize: 14)
    }

    private let recommendViewEmptyCircle = UIView().then {
        $0.layer.cornerRadius = 25 / 2
        $0.layer.borderWidth = 1
        $0.layer.borderColor = ColorManager.General.placeholder.rawValue.cgColor
        $0.backgroundColor = .white
    }
    private let recommendViewFilledCircle = UIView().then {
        $0.layer.cornerRadius = 10 / 2
        $0.backgroundColor = .white
    }
    let recommendationView = UIView()
    private let recommendationTitleLabel = UILabel().then {
        $0.text = "추천인 아이디"
        $0.font = UIFont.systemFont(ofSize: 18)
    }
    private let recommendationTextField = UserTextFieldView(placeholder: "추천인 아이디를 입력해주세요", fontSize: 14).then {
        $0.isHidden = true
    }

    private let eventNameViewEmptyCircle = UIView().then {
        $0.layer.cornerRadius = 25 / 2
        $0.layer.borderWidth = 1
        $0.layer.borderColor = ColorManager.General.placeholder.rawValue.cgColor
        $0.backgroundColor = .white
    }
    private let eventNameViewFilledCircle = UIView().then {
        $0.layer.cornerRadius = 10 / 2
        $0.backgroundColor = .white
    }
    let eventNameView = UIView()
    private let eventNameTitleLabel = UILabel().then {
        $0.text = "참여 이벤트명"
        $0.font = UIFont.systemFont(ofSize: 18)
    }
    private let eventNameTextField = UserTextFieldView(placeholder: "참여 이벤트명을 입력해주세요", fontSize: 14).then {
        $0.isHidden = true
    }

    var isRecommendationViewActive = false {
        willSet {
            recommendViewEmptyCircle.backgroundColor = newValue ? ColorManager.General.mainPurple.rawValue : .white
            setConstraintsForRecommendationViewIsActive(newValue: newValue)
        }
    }

    var isEventNameViewActive = false {
        willSet {
            eventNameViewEmptyCircle.backgroundColor = newValue ? ColorManager.General.mainPurple.rawValue : .white
            setConstraintsForEventNameViewIsActive(newValue: newValue)
        }
    }

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI
    private func configureUI() {
        setAttributes()
        setContraints()
    }

    private func setAttributes() {

    }

    private func setContraints() {
        [titleView, subtitleView, recommendationView, recommendationTextField, eventNameView, eventNameTextField].forEach {
            self.addSubview($0)
        }

        [recommendViewEmptyCircle, recommendationTitleLabel].forEach {
            recommendationView.addSubview($0)
        }
        recommendViewEmptyCircle.addSubview(recommendViewFilledCircle)

        [eventNameViewEmptyCircle, eventNameTitleLabel].forEach {
            eventNameView.addSubview($0)
        }
        eventNameViewEmptyCircle.addSubview(eventNameViewFilledCircle)

        titleView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        subtitleView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom).offset(6)
            $0.leading.equalTo(titleView)
        }
        recommendationView.snp.makeConstraints {
            $0.top.equalTo(subtitleView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(25)
        }

        recommendViewEmptyCircle.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.height.equalTo(25)
        }
        recommendViewFilledCircle.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(10)
        }
        recommendationTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(recommendViewEmptyCircle.snp.trailing).offset(12)
            $0.centerY.equalTo(recommendViewEmptyCircle)
        }

        eventNameView.snp.makeConstraints {
            $0.top.equalTo(recommendationView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(25)
        }

//        eventNameView.snp.makeConstraints {
//            $0.top.equalTo(recommendationTextField.snp.bottom).offset(15)
//            $0.leading.trailing.equalToSuperview()
//            $0.height.equalTo(25)
//        }
//        eventNameTextField.snp.makeConstraints {
//            $0.top.equalTo(eventNameView.snp.bottom).offset(10)
//            $0.leading.trailing.equalToSuperview()
//            $0.height.equalTo(40)
//        }

        eventNameViewEmptyCircle.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.height.equalTo(25)
        }
        eventNameViewFilledCircle.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(10)
        }
        eventNameTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(eventNameViewEmptyCircle.snp.trailing).offset(12)
            $0.centerY.equalTo(eventNameViewEmptyCircle)
        }
    }

    private func setConstraintsForRecommendationViewIsActive(newValue: Bool) {
        guard newValue == true else { return }
        recommendationTextField.isHidden = false
        eventNameTextField.isHidden = true
        recommendationTextField.snp.makeConstraints {
            $0.top.equalTo(recommendationView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }
        eventNameView.snp.removeConstraints()
        eventNameView.snp.makeConstraints {
            $0.top.equalTo(recommendationTextField.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(25)
        }
        eventNameTextField.snp.removeConstraints()
    }

    private func setConstraintsForEventNameViewIsActive(newValue: Bool) {
        guard newValue == true else { return }
        eventNameTextField.isHidden = false
        recommendationTextField.isHidden = true
        eventNameTextField.snp.makeConstraints {
            $0.top.equalTo(eventNameView.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }
        recommendationTextField.snp.removeConstraints()
        eventNameView.snp.removeConstraints()
        eventNameView.snp.makeConstraints {
            $0.top.equalTo(recommendationView.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(25)
        }
    }

    // MARK: - Helpers

    // MARK: - Selectors
}
