//
//  ListModels.swift
//  MyMarket
//
//  Created by Jegathas Sivanesan on 18/07/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum List {
    // MARK: Use cases

    struct Request {
        let url: String
    }

    struct Response {
        let items: [Item]
    }

    struct ViewModel {
        let items: [ViewItem]
    }

    struct ViewItem {
        let image: String?
        let title: String
        let category: String
        let price: Double
        let isUrgent: Bool
    }

    struct Item: Decodable {
        enum CodingKeys: String, CodingKey {
            case identifier = "id"
            case categoryId = "category_id"
            case title, description, price
            case imagesURL = "images_url"
            case creationDate = "creation_date"
            case isUrgent = "is_urgent"
        }

        let identifier: Int
        let categoryId: Int
        let title: String
        let description: String
        let price: Double
        let imagesURL: ImagesURL
        let creationDate: Date
        let isUrgent: Bool
    }

    struct ImagesURL: Decodable {
        let small: String?
        let thumb: String?
    }

    struct Category: Decodable {
        
    }
}
