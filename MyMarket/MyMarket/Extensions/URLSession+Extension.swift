//
//  URLSession+Extension.swift
//  MyMarket
//
//  Created by Jegathas Sivanesan on 19/07/2021.
//

import Foundation

extension URLSession {

    static func perform<T: Decodable>(_ request: URLRequest,
                                      decode decodable: T.Type,
                                      decoder: JSONDecoder = JSONDecoder(),
                                      result: @escaping (Result<T, Error>) -> Void) {

        URLSession.shared.dataTask(with: request) { (data, response, error) in

            if let error = error {
                result(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                result(.failure(URLError(.badServerResponse)))
                return
            }

            guard let data = data else {
                result(.failure(URLError(.dataNotAllowed)))
                return
            }

            do {
                let object = try decoder.decode(decodable, from: data)
                result(.success(object))
            } catch {
                result(.failure(error))
            }

        }.resume()

    }

}
