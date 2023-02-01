//
//  HomeFeedViewController.swift
//  LearningTask-12.3
//
//  Created by rafael.rollo on 05/12/2022.
//

import UIKit

class HomeFeedViewController: UIViewController {
    
    var viewModel: HomeFeedViewModel?
    var refreshControl: UIRefreshControl!
    
    convenience init(viewModel: HomeFeedViewModel? = nil) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyHomeTheme()
        view.backgroundColor = .white
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.loadFeed()
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh() {
        viewModel?.loadFeed()
        refreshControl.endRefreshing()
    }
    
    internal func setupViews() {
        setupViewCode()
        setupRefreshControl()
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
    
    private lazy var newPostButton: UIButton = {
        let button = UIButton()
        button.disableAutoResizing()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(scale: .large), forImageIn: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.cornflowerBlue
        button.layer.cornerRadius = 28
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(addNewPost), for: .touchUpInside)
        button.addTarget(self, action: #selector(changeTintColor), for: [.touchDown, .touchDragEnter])
        button.addTarget(self, action: #selector(resetTintColor), for: [.touchUpInside, .touchDragExit, .touchCancel])
        return button
    }()
    
    @objc private func changeTintColor() {
        newPostButton.imageView?.tintColor = .cornflowerBlue
    }
    
    @objc private func resetTintColor() {
        newPostButton.imageView?.tintColor = .white
    }
    
    @objc private func addNewPost() {
        let authenticatedUser = UserAuthentication().get()!.user
        
        let newViewController = NewPostViewController(viewModel: NewPostViewModel())
        newViewController.modalPresentationStyle = .fullScreen
        newViewController.viewModel = NewPostViewModel(author: authenticatedUser, tuitrAPI: TuitrAPI(httpRequest: HTTPRequest()))
        self.present(newViewController, animated: true)
    }
    
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
        self.view.addSubview(newPostButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            newPostButton.heightAnchor.constraint(equalToConstant: 56),
            newPostButton.widthAnchor.constraint(equalToConstant: 56),
            newPostButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            newPostButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
    
}
