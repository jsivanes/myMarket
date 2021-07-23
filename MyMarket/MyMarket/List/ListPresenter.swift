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
            .map({ item in
                List.ViewItem(image: item.imagesURL.small,
                              title: item.title,
                              category: response.categorys.first(where: { $0.identifier == item.categoryId })?.name ?? "",
                              price: item.price,
                              isUrgent: item.isUrgent)
            })
        let regularItems = response.items.filter({ !$0.isUrgent })
            .sorted(by: { $0.creationDate > $1.creationDate })
            .map({ item in
                List.ViewItem(image: item.imagesURL.small,
                              title: item.title,
                              category: response.categorys.first(where: { $0.identifier == item.categoryId })?.name ?? "",
                              price: item.price,
                              isUrgent: item.isUrgent)
            })

        let orderedList = urgentItems + regularItems

        let viewModel = List.ViewModel(items: orderedList)
        viewController?.displayItems(viewModel)
    }
}
