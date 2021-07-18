//
//  ListPresenter.swift
//  MyMarket
//
//  Created by Jegathas Sivanesan on 18/07/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ListPresentationLogic {
    func presentSomething(response: List.Something.Response)
}

class ListPresenter: ListPresentationLogic {
    weak var viewController: ListDisplayLogic?

    // MARK: Do something

    func presentSomething(response _: List.Something.Response) {
        let viewModel = List.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
