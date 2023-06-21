//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Kasun Wickramanayake on 21/06/23.
//

import Foundation

 

enum LoadFeedResult{
    
    case sucess ([FeedItem ])
    case error (Error)
    
}

protocol FeedLoader{
    
    func load(completion :@escaping (LoadFeedResult)->Void)
    
}
