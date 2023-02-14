//
//  ViewController.swift
//  Crypto Market
//
//  Created by Ryan Hall on 2/10/2023.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Private Properties
    private let cellId: String = "LinkCVCell"
    
    // MARK: - Views
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = .preferredFont(forTextStyle: .headline)
        nameLabel.textColor = .white
        nameLabel.text = Bundle.main.displayName
        return nameLabel
    }()
    
    private lazy var cryptoListCV: UICollectionView = {
        let layout  = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20 //RM.shared.height(10)
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.register(CryptoItemViewCell.self, forCellWithReuseIdentifier: CryptoListIdentifier.cryptoItemCell)
        cv.backgroundColor = .clear
        return cv
    }()
    
    // MARK: - Variables
    var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        cryptoListCV.delegate = self
        cryptoListCV.dataSource = self
        view.addSubview(nameLabel)
        view.addSubview(cryptoListCV)
        setConstraints()
        initViewModel()
        observeEvent()
    }
    
    // MARK: - View Functions
    private func setConstraints() {
        nameLabel.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: RM.shared.height(80), paddingLeft: RM.shared.width(20), paddingRight: RM.shared.width(20))
        cryptoListCV.anchor(top: nameLabel.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    // MARK: - Api Call
    func initViewModel() {
        viewModel.fetchCryptoList()
        viewModel.fetchDetails(id: "whitebit")
    }
    
    func observeEvent() {
        viewModel.eventHandler = { [weak self] (event) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch event {
                case .loading:
                    self.view.activityStartAnimating(activityColor: .white, backgroundColor: .gray)
                case .stopLoading:
                    self.view.activityStopAnimating()
                case .dataLoaded:
                    self.cryptoListCV.reloadData()
                case .error(let error):
                    print(error?.localizedDescription ?? "")
                }
            }
        }
    }
}

