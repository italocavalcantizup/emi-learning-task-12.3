//
//  HomeFeedViewController.swift
//  LearningTask-12.3
//
//  Created by rafael.rollo on 05/12/2022.
//

import UIKit

class HomeFeedViewController: UIViewController {
    
    var userAuthentication: UserAuthentication?
    var viewModel: HomeFeedViewModel?
    
    convenience init(userAuthentication: UserAuthentication? = nil,
                     viewModel: HomeFeedViewModel? = nil) {
        self.init()
        self.userAuthentication = userAuthentication
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyHomeTheme()
        view.backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        setupViewCode()
        viewModel?.delegate = self
    }
    
    private lazy var containerStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            tableView
        ])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .brown
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(HomeFeedTableViewCell.self, forCellReuseIdentifier: HomeFeedTableViewCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
}

// MARK: - HomeFeedViewModelDelegate
extension HomeFeedViewController: HomeFeedViewModelDelegate {
    
    func homeFeedViewModel(_ viewModel: HomeFeedViewModel, postsLoaded: [Post]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - TableView DataSource
extension HomeFeedViewController: UITableViewDataSource {

    // - Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.feed.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeFeedTableViewCell.reuseIdentifier, for: indexPath) as? HomeFeedTableViewCell else {
            fatalError("Não foi possível obter a célula da lista de posts")
        }
        cell.testeLabel.text = "Meu teste"
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

// MARK: - TableView Delegate
extension HomeFeedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - ViewCode Protocol
extension HomeFeedViewController: ViewCode {
    
    func setupViewCode() {
        buildHierarchy()
        setupConstraints()
    }
    
    func buildHierarchy() {
        self.view.addSubview(containerStackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}
