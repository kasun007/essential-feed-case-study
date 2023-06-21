//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Kasun Wickramanayake on 21/06/23.
//

import XCTest

class RemoteFeedLoader {
    
    let client :HTTPClient
    let url :URL
    
    init(url :URL=URL(string: "https://adsds-url.com")! ,client :HTTPClient){
        self.url = url
        self.client = client
    }
    
    func load(){
        
        client.get(from:url)
        
    }
    
    
}

protocol HTTPClient{
   
    
    func get(from url :URL)
      
     
}


private class HTTPClientSpy :HTTPClient {
    
    var requestedURL :URL?
    
    func get(from url: URL) {
        
        requestedURL = url
      
    }
    
}

class RemoteFeedLoaderTests:XCTestCase{
    
    func test_init_doesNotRequestDataFromURL () {
        let client = HTTPClientSpy()
        let url = URL(string: "https://a-given-url.com")!
      
        _ = RemoteFeedLoader(url:url,client: client)
        XCTAssertNil(client.requestedURL)
         
       
    }
    
    
    func test_load_requestDataFromURL(){
       
        
        let url = URL (string:"https://a-given-url.com")!
        let (sut,client) = makeSUT(url:url)
        sut.load()
        
        XCTAssertEqual(client.requestedURL, url)
    }
    
    // mark Helpers
    private func makeSUT(url:URL = URL(string: "https://a-url.com")!)->(sut:RemoteFeedLoader,client:HTTPClientSpy){
        
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url:url,client: client)
        return(sut,client)
    }
    
}

 
