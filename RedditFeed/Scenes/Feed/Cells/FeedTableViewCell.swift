//
//  FeedTableViewCell.swift
//  RedditFeed
//
//  Created by Danny on 8/20/21.
//

import UIKit
import SDWebImage

class FeedTableViewCell: UITableViewCell {
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.tag = 1
        
        return label
    }()
    
    var thumbImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightGray
        imageView.tag = 2
        
        return imageView
    }()
    
    var upvoteButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "arrowtriangle.up.fill"), for: .normal)
        button.setTitle(nil, for: .normal)
        button.tintColor = .darkGray
        
        return button
    }()
    
    var downvoteButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "arrowtriangle.down.fill"), for: .normal)
        button.setTitle(nil, for: .normal)
        button.tintColor = .darkGray
        
        return button
    }()
    
    var scoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.tag = 3
        
        return label
    }()
    
    var commentButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "bubble.right.fill"), for: .normal)
        button.setTitle("0", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.tintColor = .darkGray
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .footnote)
        
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: -8)
        button.tag = 4
        
        return button
    }()
    
    var shareButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.setTitle("Share", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.tintColor = .darkGray
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .footnote)
        
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: -8)
        
        return button
    }()
    
    // height constraint of thumbnail image view. It's changed dynamically per post thumbnail height
    var thumbnailHeightConstraint: NSLayoutConstraint?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView?.image = nil
        titleLabel.text = ""
        scoreLabel.text = "0"
        commentButton.setTitle("0", for: .normal)
    }
}

extension FeedTableViewCell {
    func configure(_ post: Post, cellWidth: CGFloat) {
        titleLabel.text = post.title
        scoreLabel.text = post.score.short()
        commentButton.setTitle(post.numComments.short(), for: .normal)
        
        if post.hasThumbnail, let width = post.thumbnailWidth, let height = post.thumbnailHeight {
            let height = floor(cellWidth / CGFloat(width) * CGFloat(height))
            thumbnailHeightConstraint?.constant = height
            thumbnailHeightConstraint?.priority = UILayoutPriority(999)
            
            thumbImageView.isHidden = false
            
            thumbImageView.sd_setImage(with: post.thumbnailUrl, completed: nil)
        } else {
            thumbImageView.isHidden = true
        }
    }
    
    private func setupUI() {
        let horizontalPadding: CGFloat = 24
        let verticalPadding: CGFloat = 12
        
        // header
        let headerView: UIView = {
            let view = UIView()
            view.backgroundColor = .clear
            
            return view
        }()
        headerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: horizontalPadding),
            titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -horizontalPadding),
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: verticalPadding),
            titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -verticalPadding)
        ])
        
        // thumbnail
        
        // add dummy constraint first. It will be removed when configuring the cell with a post
        thumbnailHeightConstraint = thumbImageView.heightAnchor.constraint(equalToConstant: 300)
        thumbnailHeightConstraint?.isActive = true
        
        // footer
        let footerView: UIView = {
            let view = UIView()
            view.backgroundColor = .clear
            
            return view
        }()
        
        let scoreStack = UIStackView(arrangedSubviews: [upvoteButton, scoreLabel, downvoteButton])
        scoreStack.axis = .horizontal
        scoreStack.spacing = 4
        scoreStack.alignment = .center
        scoreStack.distribution = .equalSpacing
        upvoteButton.setContentHuggingPriority(.required, for: .horizontal)
        scoreLabel.setContentHuggingPriority(.required, for: .horizontal)
        downvoteButton.setContentHuggingPriority(.required, for: .horizontal)
        
        
        let footerStack = UIStackView(arrangedSubviews: [scoreStack, commentButton, shareButton])
        footerStack.axis = .horizontal
        footerStack.alignment = .center
        footerStack.distribution = .equalSpacing
        footerStack.translatesAutoresizingMaskIntoConstraints = false
        
        footerView.addSubview(footerStack)
        
        NSLayoutConstraint.activate([
            footerStack.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: horizontalPadding),
            footerStack.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -horizontalPadding),
            footerStack.topAnchor.constraint(equalTo: footerView.topAnchor, constant: verticalPadding),
            footerStack.bottomAnchor.constraint(equalTo: footerView.bottomAnchor, constant: -verticalPadding)
        ])
        
        // custom separtor
        let separtor = UIView()
        separtor.heightAnchor.constraint(equalToConstant: 8).isActive = true
        separtor.backgroundColor = .systemGroupedBackground
        
        // cell layout
        let stackView = UIStackView(arrangedSubviews: [headerView, thumbImageView, footerView, separtor])

        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(stackView)
        
        
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
