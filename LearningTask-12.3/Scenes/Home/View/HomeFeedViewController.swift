//
//  HomeFeedViewController.swift
//  LearningTask-12.3
//
//  Created by rafael.rollo on 05/12/2022.
//

import UIKit

class HomeFeedViewController: UIViewController {
    
    var viewModel: HomeFeedViewModel?
    
    convenience init(viewModel: HomeFeedViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyHomeTheme()
        view.backgroundColor = .white
        setupViews()
    }
    
    internal func setupViews() {
        setupViewCode()
        viewModel?.delegate = self
        viewModel?.loadFeed()
    }
    
    private lazy var containerStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            tableView,
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
    
    private lazy var newTweetButton: UIButton = {
        let button = UIButton()
        button.disableAutoResizing()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.cornflowerBlue
        button.layer.cornerRadius = 28
        button.layer.masksToBounds = true
        return button
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
        cell.setup(post: viewModel?.feed[indexPath.row])
        return cell
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
        self.view.addSubview(tableView)
        self.view.addSubview(newTweetButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            newTweetButton.heightAnchor.constraint(equalToConstant: 56),
            newTweetButton.widthAnchor.constraint(equalToConstant: 56),
            newTweetButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            newTweetButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
    
}
