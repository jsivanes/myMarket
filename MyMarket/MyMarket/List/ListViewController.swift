//
//  ListViewController.swift
//  MyMarket
//
//  Created by Jegathas Sivanesan on 18/07/2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ListDisplayLogic: AnyObject {
    func displayItems(_ viewModel: List.ViewModel)
}

class ListViewController: UIViewController, ListDisplayLogic {
    var interactor: ListBusinessLogic?
    var router: (NSObjectProtocol & ListRoutingLogic & ListDataPassing)?

    var collectionView: UICollectionView! = nil

    var model: List.ViewModel?

    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = ListInteractor()
        let presenter = ListPresenter()
        let router = ListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        collectionView.register(ListItemCell.self, forCellWithReuseIdentifier: ListItemCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    // MARK: Routing

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white

        configureCollectionView()
        
        retrieveItems()
    }


    func retrieveItems() {
        let request = List.Request(url: "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json")
        interactor?.fetchListItems(request)
    }

    private func createLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: (view.bounds.width - 26) / 2, height: 250)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 16
        return layout
    }

    // MARK: Display logic

    func displayItems(_ viewModel: List.ViewModel) {
        model = viewModel
        collectionView.reloadData()
    }
}
