//
//  RecommendImageSliderCell.swift
//  martkurly
//
//  Created by 천지운 on 2020/09/04.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class RecommendImageSliderCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "RecommendImageSideCell"

    var imageArray = ["TestImage", "TestImage", "TestImage", "TestImage"] {
        didSet {
            imageCountLabel.text = "1 / \(imageArray.count)"
            imageCollectionView.reloadData()
        }
    }

    private let flowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
    }
    private lazy var imageCollectionView = UICollectionView(frame: .zero,
                                                            collectionViewLayout: flowLayout)

    private let imageCountLabel = UILabel().then {
        $0.text = "1 / 4"
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 12)
        $0.backgroundColor = UIColor(white: 0, alpha: 0.2)
        $0.clipsToBounds = true
    }

    // MARK: - LifeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers

    func configureUI() {
        self.backgroundColor = .white

        configureLayout()
        configureCollectionView()
    }

    func configureCollectionView() {
        imageCollectionView.backgroundColor = .white
        imageCollectionView.isPagingEnabled = true
        imageCollectionView.showsHorizontalScrollIndicator = false

        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self

        imageCollectionView.register(MainImageCell.self,
                                     forCellWithReuseIdentifier: MainImageCell.identifier)
    }

    func configureLayout() {
        [imageCollectionView, imageCountLabel].forEach {
            self.addSubview($0)
        }

        imageCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        imageCountLabel.snp.makeConstraints {
            $0.width.equalTo(48)
            $0.height.equalTo(20)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-16)
        }
        imageCountLabel.layer.cornerRadius = 20 / 2
    }
}

// MARK: - UICollectionViewDataSource

extension RecommendImageSliderCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MainImageCell.identifier,
            for: indexPath) as! MainImageCell
        cell.imageView.image = UIImage(named: imageArray[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension RecommendImageSliderCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: self.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        let currentPage = Int(scrollView.contentOffset.x / width) + 1
        imageCountLabel.text = "\(currentPage) / \(imageArray.count)"
    }
}

// MARK: - MainImageCell

class MainImageCell: UICollectionViewCell {

    // MARK: - Properties

    static let identifier = "MainImageCell"

    let imageView = UIImageView().then {
        $0.image = UIImage(named: "TestImage")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
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
        self.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
