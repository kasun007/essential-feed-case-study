//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Kasun Wickramanayake on 21/06/23.
//

import XCTest

@testable  import EssentialFeed




private class HTTPClientSpy :HTTPClient {
    
    var requestedURL :URL?
    
    func get(from url: URL) {
        
        requestedURL = url
        
      
    }
    
}

class RemoteFeedLoaderTests:XCTestCase{
    
    func test_init_RequestsDataFromURL () {
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
    
    
    func test_load_requestDataFromURLTwice(){
       
        
        let url = URL (string:"https://a-given-url.com")!
        let (sut,client) = makeSUT(url:url)
        sut.load()
        sut.load()
        
        XCTAssertEqual(client.requestedURLs, [url,url])
    }
    
    func test_load_deliversErrorOnClientError() {
            let (sut, client) = makeSUT()
            client.error = NSError(domain: "Test", code: 0)
            
            var capturedError: RemoteFeedLoader.Error?
            sut.load { error in capturedError = error }
            
            XCTAssertEqual(capturedError, .connectivity)
    }
    
    private class HTTPClientSpy:HTTPClient{
       
        
        var requestedURL :URL?
        var requestedURLs = [URL]()
        var error:Error?
        
        func get(from url : URL,completion :@escaping (Error)->Void){
            
            if let error = error{
                
                completion(error)
            }
             requestedURL = url
             requestedURLs.append(url)
        }
        
    }
    
}

 
