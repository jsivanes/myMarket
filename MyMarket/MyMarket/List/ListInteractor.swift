//
//  ListInteractor.swift
//  MyMarket
//
//  Created by Jegathas Sivanesan on 18/07/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

protocol ListBusinessLogic {
    func fetchListItems(_ request: List.Request)
}

protocol ListDataStore {
    var items: [List.Item]? { get set }
    var categorys: [List.Category]? { get set }
}

class ListInteractor: ListBusinessLogic, ListDataStore {

    var presenter: ListPresentationLogic?
    lazy var worker = ListWorker()

    var items: [List.Item]?
    var categorys: [List.Category]?

    // MARK: Business Logic

    func fetchListItems(_ request: List.Request) {
        worker.fetchListItems(request, completionHandler: {[weak self] items, error in
            if let err = error {
                print(err)
                return
            }

            self?.items = items
            self?.worker.fetchCategory(List.Request(url: "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json"), completionHandler: { [weak self] categorys, error in
                guard let categorys = categorys, let items = self?.items else {
                    if let err = error {
                        print(err)
                    }
                    return
                }
                self?.categorys = categorys
                DispatchQueue.main.async {
                self?.presenter?.presentItems(List.Response(items: items, categorys: categorys))
                }
            })
        })
    }
}
