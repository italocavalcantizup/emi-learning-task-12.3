//
//  HomeFeedTableViewCell.swift
//  LearningTask-12.3
//
//  Created by Italo cavalcanti on 20/01/23.
//

import UIKit

class HomeFeedTableViewCell: UITableViewCell {
    
    static var reuseIdentifier = "HomeFeedTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        self.contentView.isUserInteractionEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup(post: Post?) {
        guard let post = post else { return }
        profileImageView.setImageByDowloading(url: post.author.profilePictureURL)
        nameLabel.text = post.author.fullName
        usernameLabel.text = "@\(post.author.username)"
        dateLabel.text = getFormatedDate(date: post.createdAt)
        tweetTextLabel.text = post.textContent
        commentButton.count = String(describing: post.replies)
        retweetButton.count = String(describing: post.reposts)
        likeButton.count = String(describing: post.loves)
        
        if let repost = post.reposting {
            tweetRepostDataStackView.isHidden = false
            profileRepostImageView.setImageByDowloading(url: repost.author.profilePictureURL)
            nameRepostLabel.text = repost.author.fullName
            usernameRepostLabel.text = "@\(repost.author.username)"
            dateRepostLabel.text = getFormatedDate(date: repost.createdAt)
            tweetTextRepostLabel.text = repost.textContent
        } else {
            tweetRepostDataStackView.isHidden = true
        }
    }
    
    private func getFormatedDate(date: Date) -> String {
        return Date.now.getFormattedTimeInterval(since: date)
    }
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            pictureProfileStackView,
            tweetContainerStackView,
        ])
        stackView.disableAutoResizing()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 12, left: 20, bottom: 12, right: 20)
        return stackView
    }()
    
    private lazy var pictureProfileStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            profileImageView,
        ])
        view.disableAutoResizing()
        view.axis = .horizontal
        view.alignment = .top
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalTo: profileImageView.widthAnchor)
        ])
        return view
    }()
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.disableAutoResizing()
        imageView.backgroundColor = .quaternaryLabel
        imageView.contentMode = .scaleAspectFit
        imageView.image = .init(named: "Avatar")
        
        let imageSize: CGSize = .init(width: 52, height: 52)
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: imageSize.width),
            imageView.heightAnchor.constraint(equalToConstant: imageSize.height),
        ])
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageSize.width / 2
        return imageView
    }()
    
    private lazy var tweetContainerStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            tweetDataStackView,
            actionsButtonsStackView,
        ])
        view.disableAutoResizing()
        view.axis = .vertical
        view.spacing = 12
        return view
    }()
    
    private lazy var tweetDataStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            authorInfoStackView,
            tweetTextStackView,
            tweetRepostDataStackView,
        ])
        view.disableAutoResizing()
        view.axis = .vertical
        view.spacing = 4
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        return view
    }()
    
    private lazy var authorInfoStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            nameLabel,
            usernameLabel,
            bulletLabel,
            dateLabel,
        ])
        view.disableAutoResizing()
        view.axis = .horizontal
        view.spacing = 4
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.disableAutoResizing()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.disableAutoResizing()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private lazy var bulletLabel: UILabel = {
        let label = UILabel()
        label.disableAutoResizing()
        label.text = "???"
        label.font = .systemFont(ofSize: 17)
        label.textColor = .secondaryLabel
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.disableAutoResizing()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    
    private lazy var tweetTextStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [ tweetTextLabel ])
        view.disableAutoResizing()
        view.alignment = .top
        return view
    }()
    
    private lazy var tweetTextLabel: UILabel = {
        let label = UILabel()
        label.disableAutoResizing()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    /* MARK: - REPOST AREA */
    
    private lazy var tweetRepostDataStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            authorInfoRepostStackView,
            tweetTextRepostStackView,
        ])
        view.disableAutoResizing()
        view.axis = .vertical
        view.spacing = 6
        view.isHidden = false
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = .init(top: 12, left: 12, bottom: 12, right: 12)
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.quaternaryLabel.cgColor
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        return view
    }()
    
    private lazy var authorInfoRepostStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            profileRepostImageView,
            nameRepostLabel,
            usernameRepostLabel,
            bulletRepostLabel,
            dateRepostLabel,
        ])
        view.disableAutoResizing()
        view.axis = .horizontal
        view.spacing = 4
        return view
    }()
    
    private lazy var profileRepostImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.disableAutoResizing()
        imageView.backgroundColor = .quaternaryLabel
        imageView.contentMode = .scaleAspectFit
        imageView.image = .init(named: "Avatar")
        
        let imageSize: CGSize = .init(width: 24, height: 24)
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: imageSize.width),
            imageView.heightAnchor.constraint(equalToConstant: imageSize.height),
        ])
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageSize.width / 2
        return imageView
    }()
    
    private lazy var nameRepostLabel: UILabel = {
        let label = UILabel()
        label.disableAutoResizing()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    
    private lazy var usernameRepostLabel: UILabel = {
        let label = UILabel()
        label.disableAutoResizing()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private lazy var bulletRepostLabel: UILabel = {
        let label = UILabel()
        label.disableAutoResizing()
        label.text = "???"
        label.font = .systemFont(ofSize: 17)
        label.textColor = .secondaryLabel
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private lazy var dateRepostLabel: UILabel = {
        let label = UILabel()
        label.disableAutoResizing()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    
    private lazy var tweetTextRepostStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [ tweetTextRepostLabel ])
        view.disableAutoResizing()
        view.alignment = .top
        return view
    }()
    
    private lazy var tweetTextRepostLabel: UILabel = {
        let label = UILabel()
        label.disableAutoResizing()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    /* MARK: - END REPOST AREA */
    
    private lazy var actionsButtonsStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            commentButton,
            retweetButton,
            likeButton,
            shareButton,
        ])
        view.disableAutoResizing()
        view.axis = .horizontal
        view.distribution = .equalSpacing
        return view
    }()
    
    public lazy var commentButton: ActionButton = {
        let button = ActionButton()
        button.icon = UIImage(named: "BubbleChat")
        button.count = "0"
        button.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
        return button
    }()
    
    public lazy var retweetButton: ActionButton = {
        let button = ActionButton()
        button.disableAutoResizing()
        button.icon = .init(named: "ExchangeArrows")
        button.count = "0"
        button.addTarget(self, action: #selector(retweetButtonTapped), for: .touchUpInside)
        return button
    }()
    
    public lazy var likeButton: ActionButton = {
        let button = ActionButton()
        button.disableAutoResizing()
        button.icon = .init(named: "Heart")
        button.count = "0"
        button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    public lazy var shareButton: ActionButton = {
        let button = ActionButton()
        button.disableAutoResizing()
        button.icon = .init(named: "ShareArrow")
        button.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func commentButtonTapped() {
        print("Coment??rio")
    }
    
    @objc func retweetButtonTapped() {
        print("Retweet")
    }
    
    @objc func likeButtonTapped() {
        print("Like")
    }
    
    @objc func shareButtonTapped() {
        print("Share")
    }
}

extension HomeFeedTableViewCell: ViewCode {
    
    func setupViews() {
        buildHierarchy()
        setupConstraints()
    }
    
    func buildHierarchy() {
        self.addSubview(containerStackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: self.topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
        ])
    }
}
