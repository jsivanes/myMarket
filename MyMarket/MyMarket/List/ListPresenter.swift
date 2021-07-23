//
//  ListPresenter.swift
//  MyMarket
//
//  Created by Jegathas Sivanesan on 18/07/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ListPresentationLogic {
    func presentItems(_ response: List.Response)
}

class ListPresenter: ListPresentationLogic {
    weak var viewController: ListDisplayLogic?

    // MARK: Do something

    func presentItems(_ response: List.Response) {
        let urgentItems = response.items.filter({ $0.isUrgent })
            .sorted(by: { $0.creationDate > $1.creationDate })
            .map({ List.ViewItem(image: $0.imagesURL.small, title: $0.title, category: "test", price: $0.price, isUrgent: $0.isUrgent)})
        let regularItems = response.items.filter({ !$0.isUrgent })
            .sorted(by: { $0.creationDate > $1.creationDate })
            .map({ List.ViewItem(image: $0.imagesURL.small, title: $0.title, category: "test", price: $0.price, isUrgent: $0.isUrgent)})

        let orderedList = urgentItems + regularItems

        let viewModel = List.ViewModel(items: orderedList)
        viewController?.displayItems(viewModel)
    }
}
