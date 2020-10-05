//
//  SearchVC.swift
//  martkurly
//
//  Created by 천지운 on 2020/08/26.
//  Copyright © 2020 Team3x3. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    // MARK: - Properties

    private let defaultInset: CGFloat = 16

    private let searchBar = SearchBarView()
    private var searchType: SearchType = .popular {
        didSet { resultTableView.reloadData() }
    }
    private var searchProducts = [Product]() {
        didSet { resultTableView.reloadData() }
    }

    private let resultTableView = UITableView()
    private let productListView = ProductListView(headerType: .fastAreaAndNot)

    private var recentArray: [String] = ["바나나", "애호박"]
    private let popularArray: [String] = ["마스크팩", "햅쌀", "마스크"]

    var isEmptySearchText: Bool {
        guard let text = searchBar.searchTextField.text else { return true }
        return text.isEmpty
    }

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
        fetchRecentSearchWords()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.setNavigationBarStatus(type: .purpleType,
                                    isShowCart: true,
                                    leftBarbuttonStyle: .none,
                                    titleText: "검색")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }

    // MARK: - API

    func fetchRecentSearchWords() {
        KurlyService.shared.fetchRecentSearchWords()
    }

    func fetchTypingSearchProducts(keyword: String) {
        self.searchProducts.removeAll()
        KurlyService.shared.requestTypingSearchProducts(searchKeyword: keyword) { products in
            if self.isEmptySearchText { return }
            self.searchType = .fileShort
            self.searchProducts = products
            self.productListView.products = products
        }
    }

    func fetchWordSearchProducts(keyword: String) {
        self.searchProducts.removeAll()
        KurlyService.shared.requestSaveSearchProducts(searchKeyword: keyword) { products in
            if self.isEmptySearchText { return }
            self.searchType = .fileShort
            self.searchProducts = products
            self.productListView.products = products
        }
    }

    // MARK: - Actions

    func tappedProduct(productID: Int) {
        KurlyService.shared.requestProductDetailData(productID: productID) { productDetailData in
            let controller = ProductDetailVC()
            controller.productDetailData = productDetailData
            controller.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }

    // MARK: - Selectors

    @objc
    func textFieldEditingChanged(_ sender: UITextField) {
        guard let text = sender.text else { return }

        if text.isEmpty {
            searchType = .recent
            productListView.isHidden = true
            return
        }
        fetchTypingSearchProducts(keyword: text)
        searchBar.cancelButton.isEnabled = true
    }

    @objc
    func tappedCancelButton(_ sender: UIButton) {
        searchType = .popular
        productListView.isHidden = true
        searchBar.searchTextField.text = nil
        searchBar.cancelButton.isEnabled = false
        self.view.endEditing(true)
    }

    // MARK: - Helpers

    func configureUI() {
        view.backgroundColor = .white
        configureLayout()
        configureAttributes()
    }

    func configureLayout() {
        [searchBar, resultTableView, productListView].forEach {
            view.addSubview($0)
        }

        searchBar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(68)
        }

        resultTableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(defaultInset)
            $0.leading.equalToSuperview().offset(defaultInset)
            $0.trailing.equalToSuperview().offset(-defaultInset)
            $0.bottom.equalToSuperview()
        }

        productListView.isHidden = true
        productListView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }

    func configureAttributes() {
        searchBar.searchTextField.addTarget(self,
                                            action: #selector(textFieldEditingChanged(_:)),
                                            for: .editingChanged)
        searchBar.searchTextField.delegate = self

        searchBar.cancelButton.addTarget(self,
                                         action: #selector(tappedCancelButton),
                                         for: .touchUpInside)

        productListView.tappedProduct = tappedProduct(productID:)
    }

    func configureTableView() {
        resultTableView.backgroundColor = .white
        resultTableView.separatorStyle = .none
        resultTableView.rowHeight = 52
        resultTableView.isScrollEnabled = true

        resultTableView.dataSource = self
        resultTableView.delegate = self

        resultTableView.register(SearchResultCell.self,
                                 forCellReuseIdentifier: SearchResultCell.identifier)
    }
}

// MARK: - UITableViewDataSource

extension SearchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch searchType {
        case .popular:
            return popularArray.count
        case .recent:
            return recentArray.isEmpty ? 1 : recentArray.count
        case .fileShort:
            return searchProducts.isEmpty ? 1 : searchProducts.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchResultCell.identifier,
            for: indexPath) as! SearchResultCell

        switch searchType {
        case .popular:
            cell.resultLabel.text = popularArray[indexPath.row]
        case .recent:
            cell.isEmptyRecentArray = recentArray.isEmpty ? true : false
            cell.resultLabel.text = recentArray.isEmpty ?
                searchType.emptySentence : recentArray[indexPath.row]
        case .fileShort:
            cell.isEmptySearchArray = searchProducts.isEmpty ? true : false
            cell.resultLabel.text = searchProducts.isEmpty ?
                searchType.emptySentence : searchProducts[indexPath.row].title
        }

        cell.searchType = searchType
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = SearchTableViewHeaderView(searchType: searchType)
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
}

// MARK: - UITableViewDelegate

extension SearchVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch searchType {
        case .popular, .recent:
            let searchKeyword = searchType == .popular ?
                popularArray[indexPath.row] : recentArray[indexPath.row]

            searchBar.searchTextField.text = searchKeyword
            searchBar.cancelButton.isEnabled = true
            fetchTypingSearchProducts(keyword: searchKeyword)
            productListView.isHidden = false
            self.view.endEditing(true)
        case .fileShort:
            if searchProducts.isEmpty { break }
            KurlyService.shared.requestProductDetailData(
            productID: searchProducts[indexPath.row].id) { productDetailData in
                let controller = ProductDetailVC()
                controller.productDetailData = productDetailData
                controller.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(controller, animated: true)
            }
        }
        tableView.selectRow(at: nil, animated: false, scrollPosition: .middle)
    }
}

// MARK: - UITextFieldDelegate

extension SearchVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if isEmptySearchText {
            self.searchType = .recent
        } else {
            self.searchType = .fileShort
        }
        searchBar.cancelButton.isEnabled = true
        productListView.isHidden = true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if isEmptySearchText { return false }
        productListView.isHidden = false
        self.view.endEditing(true)

        if (textField.text ?? "").isEmpty {
            fetchWordSearchProducts(keyword: textField.text!)
        }
        return true
    }
}
