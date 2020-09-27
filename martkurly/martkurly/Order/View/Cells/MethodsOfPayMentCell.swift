//
//  MethodsOfPayMentCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/28.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class MethodsOfPayMentCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "MethodsOfPayMentCell"

    private let spacingValue: CGFloat = 16
    private let cellHeight: CGFloat = 56

    private let flowLayout = UICollectionViewFlowLayout()
    private lazy var paymentCollectionView = UICollectionView(frame: .zero,
                                                              collectionViewLayout: flowLayout)

    var selectedPaymentType: ((Int) -> Void)?
    var selectedType: PaymentType = .creditCard

    // MARK: - LifeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        configureCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        paymentCollectionView.selectItem(at: IndexPath(item: selectedType.rawValue, section: 0),
                                         animated: false,
                                         scrollPosition: .bottom)
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = .white

        [paymentCollectionView].forEach {
            self.addSubview($0)
        }

        let height = (cellHeight * 4) + (spacingValue * 3) + orderVCSideInsetValue
        paymentCollectionView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(height)
            $0.bottom.equalToSuperview()
        }
    }

    func configureCollectionView() {
        paymentCollectionView.backgroundColor = .clear
        paymentCollectionView.isScrollEnabled = false

        paymentCollectionView.dataSource = self
        paymentCollectionView.delegate = self

        paymentCollectionView.register(PaymentTypeCell.self,
                                       forCellWithReuseIdentifier: PaymentTypeCell.identifier)

    }
}

// MARK: - UICollectionViewDataSource

extension MethodsOfPayMentCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PaymentType.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PaymentTypeCell.identifier,
            for: indexPath) as! PaymentTypeCell
        cell.paymentImageView.image = UIImage(
            named: PaymentType(rawValue: indexPath.item)!.imageName)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MethodsOfPayMentCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - (orderVCSideInsetValue * 2) - spacingValue) / 2
        let height: CGFloat = cellHeight
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacingValue
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacingValue
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: orderVCSideInsetValue,
                            bottom: orderVCSideInsetValue, right: orderVCSideInsetValue)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedPaymentType?(indexPath.item)
    }
}

// MARK: - PaymentTypeCell

import UIKit

class PaymentTypeCell: UICollectionViewCell {

    // MARK: - Properties

    static let identifier = "PaymentTypeCell"

    override var isSelected: Bool {
        didSet {
            self.layer.borderColor = isSelected ?
                ColorManager.General.mainPurple.rawValue.cgColor : UIColor.lightGray.cgColor
        }
    }

    let paymentImageView = UIImageView().then {
        $0.image = UIImage(named: "TestImage")
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.backgroundColor = .white
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
        self.backgroundColor = .white

        self.layer.cornerRadius = self.frame.height / 2
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor

        self.addSubview(paymentImageView)
        paymentImageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(14)
        }
    }
}
