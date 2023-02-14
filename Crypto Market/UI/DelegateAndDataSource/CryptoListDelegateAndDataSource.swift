//
//  CryptoListDelegateAndDataSource.swift
//  Crypto Market
//
//  Created by Ryan Hall on 2/10/2023.
//

import Foundation
import UIKit

extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailsVC()
        let data = viewModel.products[indexPath.row]
        vc.model = data
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Total Item
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    //MARK: - Cell Reg
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CryptoListIdentifier.cryptoItemCell, for: indexPath) as? CryptoItemViewCell else {return UICollectionViewCell()}
        let data = viewModel.products[indexPath.row]
        cell.populateData(crypto: data)
        return cell
    }
    
    //MARK: - Cell Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: RM.shared.height(60))
    }
}
