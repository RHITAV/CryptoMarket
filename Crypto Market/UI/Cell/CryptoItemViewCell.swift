//
//  CryptoItemViewCell.swift
//  Crypto Market
//
//  Created by Ryan Hall on 2/10/2023.
//

import UIKit
import SDWebImage

class CryptoItemViewCell: UICollectionViewCell {
    
    let imageCache = NSCache<NSString, UIImage>()
    
    lazy var container: UIView = {
        let uv = UIView()
        uv.backgroundColor = .black
        uv.addShadow(color: UIColor.black.withAlphaComponent(0.15).cgColor)
        uv.layer.cornerRadius = RM.shared.height(10)
        uv.layer.borderWidth = 1.0
        uv.layer.borderColor = UIColor.black.cgColor
        return uv
    }()
    
    lazy var imgIcon: UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.backgroundColor = .gray
        img.layer.cornerRadius = RM.shared.height(50/2)
        img.layer.borderWidth = 1.0
        img.layer.borderColor = UIColor.white.cgColor
        img.image = UIImage(named: "blockchain")
        img.contentMode = .scaleAspectFit
        return img
    }()

    
    lazy var txtCoinName: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = .preferredFont(forTextStyle: .subheadline)
        lbl.text = "Bit Coin"
        lbl.textAlignment = .left
        lbl.numberOfLines = 1
        return lbl
    }()
    
    lazy var txtCurrentPercentage: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .gray
        lbl.text = "$1221 -12.33"
        lbl.font = UIFont.systemFont(ofSize: RM.shared.width(12))
        lbl.textAlignment = .left
        lbl.numberOfLines = 1
        return lbl
    }()
    
    lazy var txtCurrentPrice: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.text = "3.777"
        lbl.font = UIFont.systemFont(ofSize: RM.shared.width(15))
        lbl.textAlignment = .left
        lbl.numberOfLines = 1
        return lbl
    }()
    
    lazy var txtFullyDilutedValuation: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .gray
        lbl.text = "$3,777663"
        lbl.font = UIFont.systemFont(ofSize: RM.shared.width(12))
        lbl.textAlignment = .left
        lbl.numberOfLines = 1
        return lbl
    }()
    
    lazy var arrowImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "next")
        return img
    }()
    
    lazy var nameContainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fillEqually
        stack.spacing = 5.0
        stack.addArrangedSubview(txtCoinName)
        stack.addArrangedSubview(txtCurrentPercentage)
        return stack
    }()
    
    lazy var priceContainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .trailing
        stack.distribution = .fillEqually
        stack.spacing = 5.0
        stack.addArrangedSubview(txtCurrentPrice)
        stack.addArrangedSubview(txtFullyDilutedValuation)
        return stack
    }()
    
    lazy var hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.distribution = .fillProportionally
        stack.spacing = 5.0
        stack.addArrangedSubview(nameContainStack)
        stack.addArrangedSubview(priceContainStack)
        return stack
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(container)
        addSubview(imgIcon)
        addSubview(hStack)
        addSubview(arrowImage)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populateData(crypto: CryptoResponseModel) {
        imgIcon.sd_setImage(with: URL(string: crypto.image ?? ""), placeholderImage: UIImage(named: "blockchain"))
        txtCoinName.text = crypto.name
        let text = "$\(crypto.market_cap ?? 0.0) \(crypto.price_change_percentage_24h ?? 0.0)"
        let attributedText = text.getAttributedString()
        attributedText.apply(font: UIFont.systemFont(ofSize:RM.shared.height(12)), subString: "$\(crypto.market_cap ?? 0.0)")
        attributedText.apply(color: .red, subString: "\(crypto.price_change_percentage_24h ?? 0.0)")
        txtCurrentPercentage.attributedText = attributedText
        txtCurrentPrice.text = "\(crypto.current_price ?? 0.0)"
        txtFullyDilutedValuation.text = "$\(crypto.fully_diluted_valuation ?? 0)"
    }
    
    func setConstraints() {
        container.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        imgIcon.anchor(left: container.leftAnchor, paddingLeft: RM.shared.width(18), width: RM.shared.height(50), height: RM.shared.height(50))
        imgIcon.centerY(inView: container)
        arrowImage.anchor(right: container.rightAnchor, paddingRight: RM.shared.width(6), width: RM.shared.height(20), height: RM.shared.height(20))
        arrowImage.centerY(inView: container)
        hStack.anchor(left: imgIcon.rightAnchor, right: arrowImage.leftAnchor, paddingLeft: RM.shared.width(12),paddingRight: RM.shared.width(10))
        hStack.centerY(inView: imgIcon)
    }
}
