//
//  ApiCallManager.swift
//  TokeiAnime
//
//  Created by Praveen Kumar on 07/09/20.
//  Copyright © 2020 TokeiAnime. All rights reserved.
//

import Foundation


class ApiCallManager : NSObject {
    
    
    static func GET(url : URL, completion : @escaping (Data?, URLResponse?, Error?) -> ()) {
        
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            completion(data, response, error)
        }
        
        dataTask.resume()
        
        
    }
    
}
