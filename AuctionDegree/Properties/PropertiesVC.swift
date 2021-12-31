//
//  PropertiesVC.swift
//  AuctionDegree
//
//  Created by maksim.surkov on 31.12.2021.
//

import Foundation
import UIKit
import SnapKit

class PropertiesVC: UIViewController {
    
    
    private let tableView = UITableView()
    private(set) var viewModel = PropertiesViewModel()
    private let cellIdentifier = "PropertyCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureUI()
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(6)
            make.trailing.equalToSuperview().offset(-6)
            make.top.equalToSuperview().offset(80)
            make.bottom.equalToSuperview()
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PropertiesCell.self, forCellReuseIdentifier: cellIdentifier)
    }
}

extension PropertiesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 410
    }
}

extension PropertiesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 19
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PropertiesCell
        cell?.setUpCell(model: PropertiesModel(image: UIImage(named: "car")!, name: "Твоя тачка", endDate: "29.11.2020", isFavourite: false))
        return cell ?? UITableViewCell()
    }
}