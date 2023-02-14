//
//  DetailsVC.swift
//  Crypto Market
//
//  Created by Ryan Hall on 2/10/2023.
//

import UIKit
import Charts

class DetailsVC: UIViewController {
    
    var model: CryptoResponseModel?
    
    // MARK: - Views
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .black
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let uv = UIView()
        uv.backgroundColor = .black
        uv.translatesAutoresizingMaskIntoConstraints = false
        return uv
    }()
    
    lazy var chartView: LineChartView = {
        let uv = LineChartView()
        uv.backgroundColor = .white
        uv.clipsToBounds = true
        uv.layer.cornerRadius = 10
        return uv
    }()
    
    private lazy var txtPrice: PaddingLabel = {
        let label = PaddingLabel()
        label.font = UIFont.systemFont(ofSize: RM.shared.width(14))
        label.textColor = .white
        label.backgroundColor = .gray
        label.clipsToBounds = true
        label.layer.cornerRadius = 10
        label.text = "$123"
        return label
    }()
    
    private lazy var txt24hPrice: PaddingLabel = {
        let label = PaddingLabel()
        label.font = UIFont.systemFont(ofSize: RM.shared.width(14))
        label.textColor = .red
        label.backgroundColor = .white
        label.clipsToBounds = true
        label.layer.cornerRadius = 10
        label.text = "$123"
        return label
    }()
    
    // 24Price
    lazy var txt24hPriceHeader: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .gray
        lbl.text = "24h"
        lbl.font = UIFont.systemFont(ofSize: RM.shared.width(14))
        lbl.textAlignment = .left
        lbl.numberOfLines = 1
        return lbl
    }()
    
    lazy var txt24hPriceTag: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.text = "$1212"
        lbl.font = UIFont.systemFont(ofSize: RM.shared.width(16))
        lbl.textAlignment = .left
        lbl.numberOfLines = 1
        return lbl
    }()
    
    lazy var price24hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 5.0
        stack.addArrangedSubview(txt24hPriceHeader)
        stack.addArrangedSubview(txt24hPriceTag)
        return stack
    }()
    
    // Liquidity Price
    lazy var txtLiquidityPriceHeader: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .gray
        lbl.text = "Liquidity"
        lbl.font = UIFont.systemFont(ofSize: RM.shared.width(14))
        lbl.textAlignment = .left
        lbl.numberOfLines = 1
        return lbl
    }()
    
    lazy var txtLiquidityPriceTag: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.text = "$1212"
        lbl.font = UIFont.systemFont(ofSize: RM.shared.width(16))
        lbl.textAlignment = .left
        lbl.numberOfLines = 1
        return lbl
    }()
    
    lazy var priceLiquidityhStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 5.0
        stack.addArrangedSubview(txtLiquidityPriceHeader)
        stack.addArrangedSubview(txtLiquidityPriceTag)
        return stack
    }()
    
    // Market Price
    lazy var txtMarketPriceHeader: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .gray
        lbl.text = "Market"
        lbl.font = UIFont.systemFont(ofSize: RM.shared.width(14))
        lbl.textAlignment = .left
        lbl.numberOfLines = 1
        return lbl
    }()
    
    lazy var txtMarketPriceTag: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.text = "$12,12"
        lbl.font = UIFont.systemFont(ofSize: RM.shared.width(16))
        lbl.textAlignment = .left
        lbl.numberOfLines = 1
        return lbl
    }()
    
    lazy var priceMarkethStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 5.0
        stack.addArrangedSubview(txtMarketPriceHeader)
        stack.addArrangedSubview(txtMarketPriceTag)
        return stack
    }()
    
    lazy var hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.spacing = 5.0
        stack.addArrangedSubview(price24hStack)
        stack.addArrangedSubview(priceLiquidityhStack)
        stack.addArrangedSubview(priceMarkethStack)
        return stack
    }()
    
    
    lazy var txtDescriptionHeader: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.text = "Description"
        lbl.font = .preferredFont(forTextStyle: .title3)
        lbl.textAlignment = .left
        lbl.numberOfLines = 1
        return lbl
    }()
    
    lazy var txtDescription: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.text = "The oldest classical British and Latin writing had little or no space between words and could be written in boustrophedon (alternating directions). Over time, text direction (left to right) became standardized."
        lbl.font = .preferredFont(forTextStyle: .subheadline)
        lbl.textAlignment = .justified
        lbl.numberOfLines = 0
        return lbl
    }()
    
    // MARK: - Variables
    var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarBackButtonName()
        navigationItem.title = model?.name ?? ""
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        view.backgroundColor = .black
        view.addSubview(scrollView)
        
        initViewModel()
        observeEvent()
        
    }
    
    private func initView() {
        self.contentView.addSubview(txtPrice)
        self.contentView.addSubview(txt24hPrice)
        self.contentView.addSubview(chartView)
        self.contentView.addSubview(hStack)
        self.contentView.addSubview(txtDescriptionHeader)
        self.contentView.addSubview(txtDescription)
        scrollView.addSubview(contentView)
        setConstraints()
    }
    
    private func setData() {
        txtDescription.text = viewModel.details?.description?.en
        txtPrice.text = "$\(model?.current_price ?? 0.0)"
        txt24hPrice.text = "$\(model?.price_change_24h ?? 0.0)"
        txtLiquidityPriceTag.text = "$\(viewModel.details?.liquidity_score ?? 0)"
        txt24hPriceTag.text = "$\(model?.high_24h ?? 0.0)"
        txtMarketPriceTag.text = "$\(model?.market_cap ?? 0.0)"
        customizeChart()
    }
    
    func customizeChart() {
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<(viewModel.chartResponse?.prices?.count ?? 0) {
            let dataEntry = ChartDataEntry(x: viewModel.chartResponse?.prices?[i][1] ?? 0, y: Double(i))
            dataEntries.append(dataEntry)
        }
        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: model?.name ?? "")
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        chartView.data = lineChartData
    }
    
    func setConstraints() {
        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        scrollView.centerX(inView: view)
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.9).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: RM.shared.height(20)).isActive = true
        txtPrice.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, paddingLeft: RM.shared.width(10))
        txt24hPrice.anchor(right: contentView.rightAnchor, paddingTop: RM.shared.height(20))
        txt24hPrice.centerY(inView: txtPrice)
        chartView.anchor(top: txtPrice.bottomAnchor,left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: RM.shared.height(20),height: RM.shared.height(200))
        hStack.anchor(top: chartView.bottomAnchor,left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: RM.shared.height(20))
        txtDescriptionHeader.anchor(top: hStack.bottomAnchor,left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: RM.shared.height(20))
        txtDescription.anchor(top: txtDescriptionHeader.bottomAnchor,left: contentView.leftAnchor,bottom: scrollView.bottomAnchor, right: contentView.rightAnchor, paddingTop: RM.shared.height(10))
    }
    
    // MARK: - Api Call
    func initViewModel() {
        viewModel.fetchDetails(id: model?.id ?? "")
        viewModel.fetchChartData(id: model?.id ?? "", days: "30", currency: "usd")
    }
    
    // Data binding event observe - communication
    func observeEvent() {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        viewModel.eventHandlerForDetails = { [weak self] event in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch event {
                case .loading:
                    self.view.activityStartAnimating(activityColor: .white, backgroundColor: .gray)
                case .stopLoading:
                    // Indicator hide kardo
                    dispatchGroup.leave()
                    self.view.activityStopAnimating()
                case .dataLoaded:
                    print("Data loaded...")
                case .error(let error):
                    dispatchGroup.leave()
                    print(error?.localizedDescription ?? "")
                }
            }
        }
        
        dispatchGroup.enter()
        viewModel.eventHandler = { [weak self] (event) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch event {
                case .loading:
                    self.view.activityStartAnimating(activityColor: .white, backgroundColor: .gray)
                case .stopLoading:
                    // Indicator hide kardo
                    dispatchGroup.leave()
                    self.view.activityStopAnimating()
                case .dataLoaded:
                    print("Data loaded...")
                case .error(let error):
                    dispatchGroup.leave()
                    print(error?.localizedDescription ?? "")
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.initView()
            self.setData()
        }
    }
}
