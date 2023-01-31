//
//  NewPostViewController.swift
//  LearningTask-12.3
//
//  Created by Italo cavalcanti on 30/01/23.
//

import UIKit

class NewPostViewController: UIViewController {
    
    var viewModel: NewPostViewModel?
    var TOTAL_CHARACTERS = 280
    var placeholder = "What's happening?"
    
    convenience init(viewModel: NewPostViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        initiateSetup()
    }
    
    private func initiateSetup() {
        setupViews()
        postTextView.delegate = self
    }
    
    private lazy var containerView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            headerView,
            horizontalLineHeader,
            containerPostAreaView,
            horizontalLineFooter,
            footerView,
        ])
        view.disableAutoResizing()
        view.axis = .vertical
        view.spacing = 16
        return view
    }()
    
    private lazy var headerView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            cancelButton,
            sendPostButton,
        ])
        view.disableAutoResizing()
        view.axis = .horizontal
        view.distribution = .equalSpacing
        view.alignment = .center
        view.setContentCompressionResistancePriority(.required, for: .vertical)
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = .init(top: 0, left: 20, bottom: 0, right: 20)
        return view
    }()
    
    private lazy var cancelButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.contentInsets = .init(top: 0, leading: 6, bottom: 0, trailing: 6)
        config.attributedTitle = setButtonFont(title: "Cancel", ofSize: 14, weight: .regular)
        config.baseForegroundColor = .label
        
        let button = UIButton(configuration: config)
        button.disableAutoResizing()
        button.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var sendPostButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.contentInsets = .init(top: 6, leading: 24, bottom: 6, trailing: 24)
        config.cornerStyle = .capsule
        config.attributedTitle = setButtonFont(title: "Tuít", ofSize: 14, weight: .bold)
        config.baseForegroundColor = .white
        config.baseBackgroundColor = .cornflowerBlue
        
        let button = UIButton(configuration: config)
        button.disableAutoResizing()
        button.isHighlighted = true
        return button
    }()
    
    private var horizontalLineHeader: UIView = {
        let view = UIView()
        view.disableAutoResizing()
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.backgroundColor = .quaternaryLabel
        view.setContentCompressionResistancePriority(.required, for: .vertical)
        return view
    }()
    
    private var horizontalLineFooter: UIView = {
        let view = UIView()
        view.disableAutoResizing()
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.backgroundColor = .quaternaryLabel
        view.setContentCompressionResistancePriority(.required, for: .vertical)
        return view
    }()
    
    private lazy var containerPostAreaView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            pictureProfileView,
            postAreaView,
        ])
        view.disableAutoResizing()
        view.axis = .horizontal
        view.spacing = 12
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = .init(top: 0, left: 20, bottom: 0, right: 20)
        return view
    }()
    
    private lazy var pictureProfileView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            pictureProfileImageView,
        ])
        view.disableAutoResizing()
        view.axis = .horizontal
        view.alignment = .top
        return view
    }()
    
    private lazy var pictureProfileImageView: UIImageView = {
        let authenticatedUser = UserAuthentication().get()!.user
        
        let image = UIImageView()
        image.setImageByDowloading(url: authenticatedUser.profilePictureURL)
        
        image.disableAutoResizing()
        image.layer.masksToBounds = true
        let imageSize = CGSize(width: 32, height: 32)
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: imageSize.width),
            image.heightAnchor.constraint(equalToConstant: imageSize.height),
        ])
        image.layer.cornerRadius = imageSize.width / 2
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .quaternaryLabel
        return image
    }()
    
    private lazy var postAreaView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            publicButtonView,
            postTextView,
        ])
        view.disableAutoResizing()
        view.axis = .vertical
        return view
    }()
    
    private lazy var publicButtonView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            publicButton,
            paddingView,
        ])
        view.disableAutoResizing()
        return view
    }()
    
    private lazy var publicButton: UIButton = {
        var config = UIButton.Configuration.tinted()
        config.cornerStyle = .capsule
        config.attributedTitle = setButtonFont(title: "Public", ofSize: 12, weight: .regular)
        config.contentInsets = .init(top: 10, leading: 24, bottom: 10, trailing: 24)
        
        let button = UIButton(configuration: config)
        button.disableAutoResizing()
        button.setTitleColor(.cornflowerBlue, for: .normal)
        button.isUserInteractionEnabled = false
        return button
    }()
    
    private lazy var paddingView: UIView = {
        let view = UIView()
        view.disableAutoResizing()
        return view
    }()
    
    private lazy var postTextView: UITextView = {
        let textView = UITextView()
        textView.disableAutoResizing()
        textView.text = placeholder
        textView.font = .systemFont(ofSize: 14)
        textView.textColor = .secondaryLabel
        return textView
    }()
    
    private lazy var footerView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            addPhotoButton,
            totalCharactersButton,
        ])
        view.disableAutoResizing()
        view.axis = .horizontal
        view.distribution = .equalSpacing
        view.setContentCompressionResistancePriority(.required, for: .vertical)
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = .init(top: 0, left: 20, bottom: 0, right: 20)
        return view
    }()
    
    private lazy var addPhotoButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.contentInsets = .init(top: 6, leading: 0, bottom: 6, trailing: 0)
        
        let button = UIButton(configuration: config)
        button.disableAutoResizing()
        button.setImage(.init(systemName: "photo"), for: .normal)
        return button
    }()
    
    
    private lazy var totalCharactersButton: UIButton = {
        var config = UIButton.Configuration.tinted()
        config.cornerStyle = .capsule
        config.attributedTitle = setButtonFont(title: String(TOTAL_CHARACTERS), ofSize: 12, weight: .bold)
        config.baseForegroundColor = .cornflowerBlue
        config.baseBackgroundColor = .tertiaryLabel
        
        let button = UIButton(configuration: config)
        button.disableAutoResizing()
        button.setTitleColor(.cornflowerBlue, for: .normal)
        button.isUserInteractionEnabled = false
        return button
    }()
    
    private func setButtonFont(title: String, ofSize: CGFloat, weight: UIFont.Weight) -> AttributedString {
        return AttributedString(title, attributes: AttributeContainer([.font : UIFont.systemFont(ofSize: ofSize, weight: weight)]))
    }
    
    @objc private func cancelButtonPressed() {
        self.dismiss(animated: true)
    }
    
}

extension NewPostViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholder {
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholder
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let newTotal = String(TOTAL_CHARACTERS - Int(textView.text.count))
        totalCharactersButton.configuration?.attributedTitle = setButtonFont(title: String(newTotal), ofSize: 12, weight: .bold)
        if textView.text.count <= TOTAL_CHARACTERS {
            sendPostButton.isEnabled = true
            totalCharactersButton.configuration?.baseForegroundColor = .cornflowerBlue
        } else {
            sendPostButton.isEnabled = false
            totalCharactersButton.configuration?.baseForegroundColor = .cinnabar
        }
    }
}

extension NewPostViewController: ViewCode {
    func setupViews() {
        buildHierarchy()
        setupConstraints()
    }
    
    func buildHierarchy() {
        self.view.addSubview(containerView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 12),
            containerView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            
        ])
    }
    
    
}
