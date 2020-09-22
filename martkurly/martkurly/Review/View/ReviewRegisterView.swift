//
//  ReviewRegisterView.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/22.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class ReviewRegisterView: UIView {

    // MARK: - Properties

    private let sideInsetValue: CGFloat = 12
    private let lineInsetValue: CGFloat = 24

    var isShowTitlePlaceHolder: Bool = true {
        didSet { reviewTitlePlaceHolder.isHidden = !isShowTitlePlaceHolder }
    }

    var isShowContentsPlaceHolder: Bool = true {
        didSet { reviewContentsPlaceHolder.isHidden = !isShowContentsPlaceHolder }
    }

    var titleTextCount: Int = 0

    var contentsTextCount: Int = 0 {
        didSet { reviewContentsTextCountLabel.text =
            "\(contentsTextCount)자 / 최소 10자"
        }
    }

    var isRegisterEnabled: Bool {
        let isEnabled = (titleTextCount > 0) && (contentsTextCount >= 10)
        reviewRegisterButton.backgroundColor = isEnabled ?
            ColorManager.General.mainPurple.rawValue :
            ColorManager.General.backGray.rawValue
        return isEnabled
    }

    private let productTitleLabel = UILabel().then {
        $0.text = "[간식엔] 우리쌀로 만든 호두과자 (냉동)"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16)
    }

    private let underLine = UIView().then {
        $0.backgroundColor = ColorManager.General.backGray.rawValue
    }

    private let reviewWriteLabel = UILabel().then {
        $0.text = "후기 쓰기"
        $0.textColor = .darkGray
        $0.font = .boldSystemFont(ofSize: 16)
    }

    private let reviewNoteButton = UIButton(type: .system).then {
        $0.setTitle("작성 시 유의사항", for: .normal)
        $0.setTitleColor(ColorManager.General.mainPurple.rawValue, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14)
        $0.backgroundColor = .clear
    }

    private let reviewTitlePlaceHolder = UILabel().then {
        $0.text = "제목을 입력해주세요"
        $0.textColor = ColorManager.General.chevronGray.rawValue
        $0.font = .systemFont(ofSize: 16)
    }

    lazy var reviewTitleTextView = UITextView().then {
        $0.textContainerInset = UIEdgeInsets(top: 16, left: 12, bottom: 16, right: 12)
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16)
        $0.isScrollEnabled = false
        $0.layer.borderWidth = 1
        $0.layer.borderColor = ColorManager.General.chevronGray.rawValue.cgColor

        $0.addSubview(reviewTitlePlaceHolder)
        reviewTitlePlaceHolder.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(-16)
            $0.trailing.equalToSuperview().offset(-16)
        }
    }

    private let reviewContentsPlaceHolder = UILabel().then {
        $0.text = """
        자세한 후기는 다른 고객의 구매에 많은 도움이 되며,
        일반식품의 효능이나 효과 등에 오해의 소지가 있는 내용을 작성 시 검토 후 비공개 조치 될 수 있습니다.
        반품/환불 문의는 1:1문의로 가능합니다.
        """
        $0.textColor = ColorManager.General.chevronGray.rawValue
        $0.font = .systemFont(ofSize: 16)
        $0.numberOfLines = 0
    }

    let reviewContentsTextView = UITextView().then {
        $0.textContainerInset = UIEdgeInsets(top: 16, left: 12, bottom: 16, right: 12)
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 16)
        $0.isScrollEnabled = false
        $0.layer.borderWidth = 1
        $0.layer.borderColor = ColorManager.General.chevronGray.rawValue.cgColor
    }

    private let reviewContentsTextCountLabel = UILabel().then {
        $0.text = "0자 / 최소 10자"
        $0.textColor = ColorManager.General.chevronGray.rawValue
        $0.font = .systemFont(ofSize: 14)
    }

    private let pictureRegisterLabel = UILabel().then {
        $0.text = "사진 등록"
        $0.textColor = .darkGray
        $0.font = .boldSystemFont(ofSize: 16)
    }

    private let pictureRegisterCountLabel = UILabel().then {
        $0.text = "0장 / 최대 8장"
        $0.textColor = ColorManager.General.chevronGray.rawValue
        $0.font = .systemFont(ofSize: 14)
    }

    private let pictureInfoLabel = UILabel().then {
        $0.text = "구매한 상품이 아니거나 캡쳐 사진을 첨부할 경우, 통보없이 삭제 및 적립 혜택이 취소됩니다."
        $0.textColor = .darkGray
        $0.font = .boldSystemFont(ofSize: 14)
        $0.numberOfLines = 0
    }

    private let reviewRegisterButton = UIButton(type: .system).then {
        $0.setTitle("등록하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 18)
        $0.backgroundColor = ColorManager.General.backGray.rawValue
    }

    // Picture CollectionView

    private let flowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
    }

    private lazy var pictureCollectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout: flowLayout)

    var pictureArray: [UIImage] = [] {
        didSet { pictureCollectionView.reloadData() }
    }

    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Actions

    func tappedReviewPictureRemove(index: Int) {
        pictureArray.remove(at: index)
    }

    // MARK: - Helpers

    func configureUI() {
        configureLayout()
        configureAttributes()
    }

    func configureLayout() {
        self.backgroundColor = .white

        [productTitleLabel, underLine, reviewWriteLabel, reviewNoteButton, reviewTitleTextView, reviewContentsTextView, reviewContentsPlaceHolder, reviewContentsTextCountLabel, pictureRegisterLabel, pictureRegisterCountLabel, pictureCollectionView, pictureInfoLabel, reviewRegisterButton].forEach {
            self.addSubview($0)
        }

        productTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(lineInsetValue)
            $0.leading.equalToSuperview().offset(sideInsetValue)
            $0.trailing.equalToSuperview().offset(-sideInsetValue)
        }

        underLine.snp.makeConstraints {
            $0.top.equalTo(productTitleLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(sideInsetValue)
            $0.trailing.equalToSuperview().offset(-sideInsetValue)
            $0.height.equalTo(0.5)
        }

        reviewWriteLabel.snp.makeConstraints {
            $0.top.equalTo(underLine.snp.bottom).offset(lineInsetValue)
            $0.leading.equalToSuperview().offset(sideInsetValue)
            $0.trailing.equalTo(reviewNoteButton.snp.leading).offset(-sideInsetValue)
        }

        reviewNoteButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-sideInsetValue)
            $0.height.equalTo(50)
            $0.centerY.equalTo(reviewWriteLabel)
        }

        reviewTitleTextView.snp.makeConstraints {
            $0.top.equalTo(reviewWriteLabel.snp.bottom).offset(sideInsetValue)
            $0.leading.equalToSuperview().offset(sideInsetValue)
            $0.trailing.equalToSuperview().offset(-sideInsetValue)
        }

        reviewContentsTextView.snp.makeConstraints {
            $0.top.equalTo(reviewTitleTextView.snp.bottom).offset(sideInsetValue)
            $0.leading.equalToSuperview().offset(sideInsetValue)
            $0.trailing.equalToSuperview().offset(-sideInsetValue)

            let textHeight = ("1" as NSString)
                .size(withAttributes: [NSAttributedString.Key.font: reviewContentsTextView.font!])
                .height
            $0.height.greaterThanOrEqualTo(32 + (textHeight * 5))
        }

        reviewContentsPlaceHolder.snp.makeConstraints {
            $0.top.equalTo(reviewContentsTextView).offset(16)
            $0.leading.equalTo(reviewContentsTextView).offset(16)
            $0.trailing.equalTo(reviewContentsTextView).offset(-16)
        }

        reviewContentsTextCountLabel.snp.makeConstraints {
            $0.top.equalTo(reviewContentsTextView.snp.bottom).offset(sideInsetValue)
            $0.trailing.equalToSuperview().offset(-sideInsetValue)
        }

        pictureRegisterLabel.snp.makeConstraints {
            $0.top.equalTo(reviewContentsTextCountLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(sideInsetValue)
        }

        pictureRegisterCountLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-sideInsetValue)
            $0.centerY.equalTo(pictureRegisterLabel)
        }

        pictureCollectionView.snp.makeConstraints {
            $0.top.equalTo(pictureRegisterLabel.snp.bottom).offset(sideInsetValue)
            $0.leading.equalToSuperview().offset(sideInsetValue)
            $0.trailing.equalToSuperview().offset(-sideInsetValue)
            $0.height.equalTo(88)
        }

        pictureInfoLabel.snp.makeConstraints {
            $0.top.equalTo(pictureCollectionView.snp.bottom).offset(sideInsetValue)
            $0.leading.equalToSuperview().offset(sideInsetValue)
            $0.trailing.equalToSuperview().offset(-sideInsetValue)
        }

        reviewRegisterButton.snp.makeConstraints {
            $0.top.equalTo(pictureInfoLabel.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(sideInsetValue)
            $0.trailing.equalToSuperview().offset(-sideInsetValue)
            $0.height.equalTo(52)
            $0.bottom.equalToSuperview().offset(-lineInsetValue)
        }
    }

    func configureAttributes() {

    }

    func configureCollectionView() {
        pictureCollectionView.backgroundColor = .white

        pictureCollectionView.dataSource = self
        pictureCollectionView.delegate = self

        pictureCollectionView.register(ReviewPictureCell.self,
                                       forCellWithReuseIdentifier: ReviewPictureCell.identifier)
        pictureCollectionView.register(ReviewPictureRegisterButtonCell.self,
                                       forCellWithReuseIdentifier: ReviewPictureRegisterButtonCell.identifier)
    }
}

// MARK: - UICollectionViewDataSource

extension ReviewRegisterView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictureArray.count < 8 ? pictureArray.count + 1 : 8
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == pictureArray.count {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ReviewPictureRegisterButtonCell.identifier,
                for: indexPath) as! ReviewPictureRegisterButtonCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ReviewPictureCell.identifier,
                for: indexPath) as! ReviewPictureCell
            cell.removeButton.tag = indexPath.item
            cell.tappedRemoveButton = tappedReviewPictureRemove(index:)
            cell.reviewImageView.image = pictureArray[indexPath.item]
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ReviewRegisterView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height,
                      height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == pictureArray.count,
           let parentVC = self.parentViewController as? ReviewRegisterVC {
            parentVC.tappedRegisterPicture()
        }
    }
}

import UIKit

class ReviewPictureCell: UICollectionViewCell {

    // MARK: - Properties

    static let identifier = "ReviewPictureCell"

    var tappedRemoveButton: ((Int) -> Void)?

    let reviewImageView = UIImageView().then {
        $0.image = UIImage(named: "TestImage")
        $0.contentMode = .scaleToFill
        $0.clipsToBounds = true
    }

    lazy var removeButton = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        $0.tintColor = .darkGray
        $0.backgroundColor = .white
        $0.addTarget(self,
                     action: #selector(handleRemoveEvent(_:)),
                     for: .touchUpInside)
    }

    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Selecters

    @objc
    func handleRemoveEvent(_ sender: UIButton) {
        tappedRemoveButton?(sender.tag)
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = .clear

        [reviewImageView, removeButton].forEach {
            self.addSubview($0)
        }

        reviewImageView.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview()
            $0.height.width.equalTo(80)
        }

        removeButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.height.width.equalTo(20)
        }
        removeButton.layer.cornerRadius = 20 / 2
    }
}

import UIKit

class ReviewPictureRegisterButtonCell: UICollectionViewCell {

    // MARK: - Properties

    static let identifier = "ReviewPictureRegisterButtonCell"

    private let registerLabel = UILabel().then {
        $0.text = "+"
        $0.textColor = ColorManager.General.mainPurple.rawValue
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 28)

        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.lightGray.cgColor
    }

    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = .clear

        self.addSubview(registerLabel)
        registerLabel.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview()
            $0.height.width.equalTo(80)
        }
    }
}
