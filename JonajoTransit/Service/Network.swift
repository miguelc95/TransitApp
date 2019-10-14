//
//  Network.swift
//  JonajoTransit
//
//  Created by Miguel Fernando Cuellar Gauna on 10/13/19.
//  Copyright © 2019 Miguel Fernando Cuellar Gauna. All rights reserved.
//

import Foundation

class Network {
    static func getExternalData<T: Decodable>(fileLocation: String, completionHandler: @escaping (T?, Error?) -> Void){
        if let request = URL(string: fileLocation) {
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 200
                
                if error != nil {
                    completionHandler(nil, error)
                }
                
                if statusCode != 200 {
                    completionHandler(nil, error)
                }
                
                do {
                    if let jsonData = data {
                        let decoder = JSONDecoder()
                        let typedObject: T? = try decoder.decode(T.self, from: jsonData)
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                            completionHandler(typedObject, nil)
                        }
                    }
                } catch {
                    completionHandler(nil, error)
                }
            }
            
            task.resume()
        } else {
            completionHandler(nil, NSError(domain: "Url does not exist", code: 1001, userInfo: nil))
        }
        
    }
}
