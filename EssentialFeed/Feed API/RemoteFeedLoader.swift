//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Kasun Wickramanayake on 24/06/23.
//

import Foundation


public protocol HTTPClient{
   
    
    func get(from url :URL)
      
     
}
public final  class RemoteFeedLoader {
    
   private  let client :HTTPClient
   private  let url :URL
    
    public init(url :URL=URL(string: "https://adsds-url.com")! ,client :HTTPClient){
        self.url = url
        self.client = client
    }
    
   public  func load(){
        
        client.get(from:url)
        
    }
    
    
}
