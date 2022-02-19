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
    private(set) var viewModel: PropertiesViewModelProtocol = PropertiesViewModel()
    private let cellIdentifier = "PropertyCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureUI()
        viewModel.fetchProperties { [weak self] in
            self?.tableView.reloadData()
        }
        //navigationController?.tabBarController?.tabBar.backgroundColor = .white
    }
    private func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(6)
            make.trailing.equalToSuperview().offset(-6)
            make.top.equalToSuperview().offset(108)
            make.bottom.equalToSuperview().offset(-25)
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 400
        tableView.register(PropertiesCell.self, forCellReuseIdentifier: cellIdentifier)
    }
}

extension PropertiesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 440
    }
}

extension PropertiesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.propertiesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PropertiesCell
        
        let model = viewModel.propertiesArray[indexPath.row]
        cell?.setUpCell(model: model)
        return cell ?? UITableViewCell()
    }
}
