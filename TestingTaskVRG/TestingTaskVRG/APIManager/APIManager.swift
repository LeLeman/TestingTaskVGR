//
//  APIManager.swift
//  TestingTaskVRG
//
//  Created by Evgeniy Lemish on 07.02.2023.
//

import Foundation
import Alamofire

class APIManager {
static let apiManager = APIManager()
    
    private let apiKey: String = "wxwDDAiDp6pWMe9N5eJntb8rcizj26th"
    
    func fetchContent (type: MostPopular, period: Period, completion: @escaping ([Result]) -> Void) {
        let urlString = "https://api.nytimes.com/svc/mostpopular/v2/\(type)/\(period.rawValue).json?api-key=\(apiKey)"
        guard let url = URL(string: urlString) else { return }
        AF.request(url, encoding: URLEncoding.default).responseData { response in
            guard let data = response.data else { return }
            do {
                let jsonResult: APIResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                completion(jsonResult.results)
               print (jsonResult.results)
            } catch {
                print (error)
            }
        }
        
    }
}

