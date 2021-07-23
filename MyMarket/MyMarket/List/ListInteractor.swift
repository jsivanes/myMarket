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
}

class ListInteractor: ListBusinessLogic, ListDataStore {
    var presenter: ListPresentationLogic?
    var worker: ListWorker?
    var items: [List.Item]?

    // MARK: Do something

    func fetchListItems(_ request: List.Request) {
        worker = ListWorker()
        worker?.fetchListItems(request, completionHandler: {[weak self] items, error in
            guard let items = items else {
                if let err = error {
                    print(err)
                }
                return
            }
            self?.items = items
            DispatchQueue.main.async {
                self?.presenter?.presentItems(List.Response(items: items))
            }
        })
    }
}
