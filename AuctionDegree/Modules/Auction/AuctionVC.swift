//
//  AuctionVC.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 01.01.2022.
//

import Foundation
import UIKit
import SnapKit

class AuctionVC: UIViewController {
    
    private let nameLabel = UILabel()
    private let betButton = EntranceButton()
    private let propertyPhotoCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        return collectionView
    }()

    private let additionInfoTableView = UITableView()
    private let auctionTableView = UITableView()
    private let scrollView = UIScrollView()
    private let pageControl = UIPageControl()
    private let imagesIdetifierCell = "imagesCellIdentifier"
    private let addInfoIdetifierCell = "addInfoCellIdentifier"
    private let auctionInfoIdetifierCell = "auctionInfoCellIdentifier"
    var viewModel = AuctionViewModel()
    var timer: Timer?
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureUI()
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(slideToNext), userInfo: nil, repeats: true)
    }
    
    private func setupUI() {
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(80)
        }
        
        view.addSubview(propertyPhotoCollectionView)
        propertyPhotoCollectionView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(252)
        }
        
        view.addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.centerX.equalTo(propertyPhotoCollectionView.snp.centerX)
            make.bottom.equalTo(propertyPhotoCollectionView.snp.bottom).offset(-8)
            make.height.equalTo(30)
        }
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(propertyPhotoCollectionView.snp.bottom).offset(15)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
//
//        scrollView.addSubview(additionInfoTableView)
//        additionInfoTableView.snp.makeConstraints { make in
//            make.leading.equalToSuperview()
//            make.trailing.equalToSuperview()
//            make.top.equalToSuperview()
//        }
//        scrollView.addSubview(auctionTableView)
//        auctionTableView.snp.makeConstraints { make in
//            make.leading.equalToSuperview()
//            make.trailing.equalToSuperview()
//            make.top.equalTo(additionInfoTableView.snp.bottom).offset(15)
//        }
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        propertyPhotoCollectionView.delegate = self
        propertyPhotoCollectionView.dataSource = self
        propertyPhotoCollectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "Some")
        propertyPhotoCollectionView.layer.cornerRadius = 15
        
        nameLabel.text = "Имущество 2014 года"
        nameLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        nameLabel.textColor = UIColor(hex: "565656")
        
        scrollView.addSubview(additionInfoTableView)
        additionInfoTableView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
        }
        additionInfoTableView.backgroundColor = .white
        additionInfoTableView.delegate = self
        additionInfoTableView.dataSource = self
        additionInfoTableView.separatorStyle = .none
        additionInfoTableView.showsVerticalScrollIndicator = false
        additionInfoTableView.rowHeight = UITableView.automaticDimension
        additionInfoTableView.estimatedRowHeight = 400
        additionInfoTableView.register(AuctionCell.self, forCellReuseIdentifier: addInfoIdetifierCell
        )
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = UIColor(hex: "565656")
        pageControl.numberOfPages = viewModel.model?.images.count ?? 0
//        additionInfoTableView.delegate = viewModel
//        auctionTableView.delegate = viewModel
        
    }
    
    @objc
    private func slideToNext() {
        if currentIndex < (viewModel.model?.images.count)! - 1 {
            currentIndex += 1
        } else {
            currentIndex = 0
        }
        propertyPhotoCollectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .right, animated: true)
        pageControl.currentPage = currentIndex
    }
}

extension AuctionVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: propertyPhotoCollectionView.frame.width, height: propertyPhotoCollectionView.frame.height)
    }
}

extension AuctionVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.model?.images.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = propertyPhotoCollectionView.dequeueReusableCell(withReuseIdentifier: "Some", for: indexPath) as! PhotoCell
        cell.configure(image: (viewModel.model?.images[indexPath.row])!)
        return cell
    }
}

extension AuctionVC: UICollectionViewDelegateFlowLayout {
    
}

extension AuctionVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 80
    }
}

extension AuctionVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: addInfoIdetifierCell, for: indexPath) as? AuctionCell
        cell?.setup(model: AuctionCell.Model(title: "some", subtitile: "some"))
        return cell ?? UITableViewCell()
    }
}
