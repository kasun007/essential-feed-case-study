import XCTest
@testable import EssentialFeed

class RemoteFeedLoaderTests: XCTestCase {

    func test_init_RequestsDataFromURL() {
        let (_, client) = makeSUT()

        XCTAssertNil(client.requestedURL)
    }

    func test_load_requestDataFromURL() {
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        sut.load()

        XCTAssertEqual(client.requestedURL, url)
    }

    // mark Helpers
    private func makeSUT(url: URL = URL(string: "https://a-url.com")!) -> (sut: RemoteFeedLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        return (sut, client)
    }

    func test_load_requestDataFromURLTwice() {
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        sut.load()
        sut.load()

        XCTAssertEqual(client.requestedURLs, [url, url])
    }

    func test_load_deliversErrorOnClientError() {
        let (sut, client) = makeSUT()
        var capturedErrors = [RemoteFeedLoader.Error]()
        sut.load { capturedErrors.append($0) }

        let clientError = NSError(domain: "Test", code: 0)
        client.complete(with:clientError)

        XCTAssertEqual(capturedErrors, [.connectivity])
    }

    private class HTTPClientSpy: HTTPClient {
        var requestedURL: URL?
        var requestedURLs = [URL]()
        var completions = [(Error) -> Void]()

        func get(from url: URL, completion: @escaping (Error) -> Void) {
            completions.append(completion)
            requestedURL = url
            requestedURLs.append(url)
        }
        
        func complete(with error:Error,at index:Int = 0){
            
            completions[index](error)
            
        }
    }
}
