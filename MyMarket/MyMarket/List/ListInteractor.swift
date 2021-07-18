//
//  ListInteractor.swift
//  MyMarket
//
//  Created by Jegathas Sivanesan on 18/07/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ListBusinessLogic {
    func doSomething(request: List.Something.Request)
}

protocol ListDataStore {
    // var name: String { get set }
}

class ListInteractor: ListBusinessLogic, ListDataStore {
    var presenter: ListPresentationLogic?
    var worker: ListWorker?
    // var name: String = ""

    // MARK: Do something

    func doSomething(request _: List.Something.Request) {
        worker = ListWorker()
        worker?.doSomeWork()

        let response = List.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
