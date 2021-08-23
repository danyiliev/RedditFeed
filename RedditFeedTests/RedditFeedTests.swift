//
//  RedditFeedTests.swift
//  RedditFeedTests
//
//  Created by Danny on 8/20/21.
//

import XCTest
@testable import RedditFeed

class RedditFeedTests: XCTestCase {

    var testInstance: FeedViewController!
    
    
    let postWithoutImage = Post(JSONString: """
        {
            "title": "University of Virginia disenrolls 238 students for not complying with university's vaccine mandate",
            "thumbnail_height": 78,
            "name": "t3_p8j3ml",
            "thumbnail_width": 140,
            "score": 17560,
            "thumbnail": "default",
            "id": "p8j3ml",
            "num_comments": 981
        }
        """)!
    
    let postWithImage = Post(JSONString: """
        {
            "title": "Police can't stop petting cat.",
            "thumbnail_height": 78,
            "name": "t3_p8jo7j",
            "thumbnail_width": 140,
            "score": 18115,
            "thumbnail": "https://b.thumbs.redditmedia.com/AvYWf9Fj7Ggu1_SGpWSN0YP0DtQy1ZI6vz8oEi4LUAM.jpg",
            "id": "p8jo7j",
            "num_comments": 336
        }
        """)!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        testInstance = FeedViewController(style: .plain)
        testInstance.posts = [postWithImage, postWithoutImage]
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        testInstance = nil
    }

    func testNumberOfPosts() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        XCTAssert(testInstance.tableView(testInstance.tableView, numberOfRowsInSection: 0) == testInstance.posts.count, "number of rows should match number of posts")
    }
    
    func testFeedTableViewCellTitle() throws {
        let firstCell = testInstance.tableView(testInstance.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        let titleLabel = firstCell.viewWithTag(1) as? UILabel
        XCTAssert(titleLabel?.text?.count ?? 0 > 0, "title should not be blank")
        XCTAssert(titleLabel?.numberOfLines ?? -1 == 0, "title label should show multiline")
    }
    
    func testFeedTableViewCellImage() throws {
        let firstCell = testInstance.tableView(testInstance.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        let imageView1 = firstCell.viewWithTag(2) as? UIImageView
        XCTAssert(imageView1?.isHidden != testInstance.posts[0].hasThumbnail, "image view should be shown on first cell")
        
        let secondCell = testInstance.tableView(testInstance.tableView, cellForRowAt: IndexPath(row: 1, section: 0))
        let imageView2 = secondCell.viewWithTag(2) as? UIImageView
        XCTAssert(imageView2?.isHidden != testInstance.posts[1].hasThumbnail, "image view should not be shown on second cell")
    }
    
    func testFeedTableViewCellScore() throws {
        let firstCell = testInstance.tableView(testInstance.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        let scoreLabel = firstCell.viewWithTag(3) as? UILabel
        XCTAssert(scoreLabel?.text == "18.1K", "score label should match")
    }
    
    func testFeedTableViewCellNumComment() throws {
        let firstCell = testInstance.tableView(testInstance.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        let numCommentButton = firstCell.viewWithTag(4) as? UIButton
        XCTAssert(numCommentButton?.title(for: .normal) == "336", "number of comments should match")
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
