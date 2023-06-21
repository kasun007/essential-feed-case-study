//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Kasun Wickramanayake on 21/06/23.
//

import XCTest

class RemoteFeedLoader {
    
    
}

class HTTPClient{
    
    var requestedURL : URL?
}

class RemoteFeedLoaderTests:XCTestCase{
    
    func test_init_doesNotRequestDataFromURK() {
      let client = HTTPClient()
      _ = RemoteFeedLoader()
      XCTAssertNil(client.requestedURL)
         
       
    }
    
    
}

 
