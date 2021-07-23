//
//  ListWorker.swift
//  MyMarket
//
//  Created by Jegathas Sivanesan on 18/07/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

class ListWorker {
    func fetchListItems(_ request: List.Request, completionHandler: @escaping ([List.Item]?, Error?) -> Void) {
        guard let url = URL(string: request.url) else {
            completionHandler(nil, URLError(.badURL))
            return
        }

        let request = URLRequest(url: url)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        URLSession.perform(request, decode: [List.Item].self, decoder: decoder) { result in
            switch result {
            case .failure(let error):
                completionHandler(nil, error)
            case .success(let items):
                completionHandler(items, nil)
            }
        }
    }

    func fetchCategory(_ request: List.Request, completionHandler: @escaping ([List.Category]?, Error?) -> Void) {
        
    }
}
