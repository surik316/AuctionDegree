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
    enum Actions {
        case back
    }
    struct Static {
        static let imagesIdetifierCell = "imagesIdetifierCell"
        static let auctionInfoIdetifierCell = "auctionInfoCellIdentifier"
        static let auctionInfoIdetifierHeader = "auctionInfoHeaderIdentifier"
        static let auctionInfoIdetifierFooter = "auctionInfoFooterIdentifier"
    }
    
    private let propertyPhotoCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        return collectionView
    }()
    
    private let scrollableStackView: ScrollableStackView = {
        let config: ScrollableStackView.Config = ScrollableStackView.Config(
                stack: ScrollableStackView.Config.Stack(axis: .vertical, distribution: .fill,
                                                        alignment: .fill, spacing: 10),
                scroll: .defaultVertical,
                pinsStackConstraints: UIEdgeInsets(top: 0.0, left: 0.0, bottom: -60.0, right: 0.0)
        )
        return ScrollableStackView(config: config)
    }()
    
    private let liveCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    private let detailsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    private let pageControl = UIPageControl()
    private let nameLabel = UILabel()
    private let betButton = EntranceButton()
    var viewModel: AuctionViewModelProtocol = AuctionViewModel()
    var timer: Timer?
    var currentIndex = 0
    var navigation: ((Actions) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureUI()
        setupBindings()
        viewModel.fetchData()
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
        
        view.addSubview(scrollableStackView)
        scrollableStackView.snp.makeConstraints { make in
            make.top.equalTo(propertyPhotoCollectionView.snp.bottom).offset(15)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        scrollableStackView.addArrangedSubview(detailsCollectionView)
        scrollableStackView.addArrangedSubview(liveCollectionView)
        detailsCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(300)
        }

        liveCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
        
        view.addSubview(betButton)
        betButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-5)
            make.height.equalTo(60)
        }
    }
    
    private func setupBindings() {
        viewModel.updateUI = { [weak self] updateType in
            switch updateType {
            case .slotInfo:
                self?.detailsCollectionView.reloadData()
            case .auctionMembers:
                debugPrint("")
            }
            
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        propertyPhotoCollectionView.delegate = self
        propertyPhotoCollectionView.dataSource = self
        propertyPhotoCollectionView.register(PhotoCell.self, forCellWithReuseIdentifier: Static.imagesIdetifierCell)
        propertyPhotoCollectionView.layer.cornerRadius = 15
        
        nameLabel.text = "Имущество 2014 года"
        nameLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        nameLabel.textColor = UIColor(hex: "565656")
        
        detailsCollectionView.backgroundColor = UIColor(hex: "EAEAEA")
        detailsCollectionView.layer.cornerRadius = 15
        detailsCollectionView.showsVerticalScrollIndicator = false
        detailsCollectionView.register(AuctionCell.self, forCellWithReuseIdentifier: Static.auctionInfoIdetifierCell)
        detailsCollectionView.register(AuctionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Static.auctionInfoIdetifierHeader)
        detailsCollectionView.register(AuctionFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: Static.auctionInfoIdetifierFooter)
        detailsCollectionView.delegate = self
        detailsCollectionView.dataSource = self
        
        liveCollectionView.backgroundColor = UIColor(hex: "EAEAEA")
        liveCollectionView.layer.cornerRadius = 15
        liveCollectionView.showsVerticalScrollIndicator = false
        liveCollectionView.register(AuctionCell.self, forCellWithReuseIdentifier: Static.auctionInfoIdetifierCell)
        liveCollectionView.register(AuctionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Static.auctionInfoIdetifierHeader)
        liveCollectionView.delegate = self
        liveCollectionView.dataSource = self
        
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = UIColor(hex: "565656")
        pageControl.numberOfPages = viewModel.images.count
        let backNavigationItem = UIBarButtonItem(
            image: UIImage(named: "back_rounded")?.withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(backAction)
        )
        backNavigationItem.tintColor = .white
        navigationItem.leftBarButtonItem = backNavigationItem
        
        betButton.configure(title: "Поставить ставку")
        betButton.addTarget(self, action: #selector(setBet), for: .touchUpInside)
    }
    
    @objc
    private func slideToNext() {
        if currentIndex < (viewModel.images.count) - 1 {
            currentIndex += 1
        } else {
            currentIndex = 0
        }
        propertyPhotoCollectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .right, animated: true)
        pageControl.currentPage = currentIndex
    }
    
    @objc
    private func setBet() {
        debugPrint("Betted")
    }
    
    @objc
    private func backAction() {
        self.navigation?(.back)
    }
}

extension AuctionVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView === self.detailsCollectionView {
            return CGSize(width: detailsCollectionView.bounds.width, height: 20)
        } else if collectionView === self.propertyPhotoCollectionView {
            return CGSize(width: propertyPhotoCollectionView.bounds.width, height: propertyPhotoCollectionView.bounds.height)
        } else if collectionView === self.liveCollectionView{
            return CGSize(width: liveCollectionView.bounds.width, height: 20)
        }
        return CGSize(width: 0, height: 0)
    }
}

extension AuctionVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView === self.detailsCollectionView {
            return viewModel.keys.count
        } else if collectionView === self.propertyPhotoCollectionView {
            return viewModel.images.count
        } else if collectionView === self.liveCollectionView {
            return 30
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView === self.detailsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Static.auctionInfoIdetifierCell, for: indexPath) as! AuctionCell
            let title = viewModel.keys[indexPath.row]
            let subtitle = viewModel.model[title] ?? ""
            cell.setup(model: AuctionCell.Model(title: title, subtitile: subtitle))
            return cell
        } else if collectionView === self.propertyPhotoCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Static.imagesIdetifierCell, for: indexPath) as! PhotoCell
            cell.configure(image: viewModel.images[indexPath.row]!)
            return cell
        } else  if collectionView === self.liveCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Static.auctionInfoIdetifierCell, for: indexPath) as! AuctionCell
            cell.setup(model: AuctionCell.Model(title: "Maksim", subtitile: "Surkov"))
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView === self.detailsCollectionView {
            if kind == UICollectionView.elementKindSectionHeader {
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Static.auctionInfoIdetifierHeader, for: indexPath) as! AuctionHeaderView
                
                header.configure(text: "SOME")
                return header
            } else if kind == UICollectionView.elementKindSectionFooter {
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: Static.auctionInfoIdetifierFooter, for: indexPath) as! AuctionFooterView
                return footer
            }
        } else if collectionView === self.liveCollectionView {
            if kind == UICollectionView.elementKindSectionHeader {
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Static.auctionInfoIdetifierHeader, for: indexPath) as! AuctionHeaderView
                
                header.configure(text: "LIVE")
                return header
            } else if kind == UICollectionView.elementKindSectionFooter {
                
            }
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if collectionView === self.detailsCollectionView {
            return CGSize(width: detailsCollectionView.bounds.width, height: 40)
        } else if collectionView === self.liveCollectionView  {
            return CGSize(width: liveCollectionView.bounds.width, height: 60)
        }
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if collectionView === self.detailsCollectionView {
            return CGSize(width: detailsCollectionView.bounds.width, height: 60)
        } else if collectionView === self.liveCollectionView  {
            return CGSize(width: 0, height: 0)
        }
        return CGSize(width: 0, height: 0)
    }
}

