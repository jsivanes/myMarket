//
//  ListViewController+Delegate.swift
//  MyMarket
//
//  Created by Jegathas Sivanesan on 20/07/2021.
//

import UIKit

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model?.items.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = model?.items[indexPath.row],
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListItemCell.reuseIdentifier, for: indexPath) as? ListItemCell else {
            return UICollectionViewCell()
        }

        cell.fill(item: item)
        return cell
    }

}
