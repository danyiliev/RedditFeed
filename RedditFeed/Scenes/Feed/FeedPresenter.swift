//
//  FeedPresenter.swift
//  RedditFeed
//
//  Created by Danny on 8/20/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol FeedPresentationLogic
{
    func presentFetchFeed(response: Feed.FetchFeed.Response)
}

class FeedPresenter: FeedPresentationLogic
{
    weak var viewController: FeedDisplayLogic?
    
    // MARK: Present fetch feed
    
    func presentFetchFeed(response: Feed.FetchFeed.Response)
    {
        let viewModel = Feed.FetchFeed.ViewModel(
            posts: response.posts,
            hasMore: response.posts.count > 0,
            error: response.error?.localizedDescription)
        
        viewController?.displayFetchFeed(viewModel: viewModel)
    }
}
