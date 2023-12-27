//
//  HistoryCell.swift
//  MathSolver
//
//  Created by Furkan Deniz Albaylar on 12.12.2023.
//

import UIKit
import SnapKit
import NeonSDK
import WebKit

class HistoryTableViewCell: NeonTableViewCell<History>, WKNavigationDelegate {
    private let dateLabel = UILabel()
    var webView = WKWebView()
    private let cellView = UIView()
    private var squareImage = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        // Date Label
        dateLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        dateLabel.textColor = .gray
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(10)
            make.right.left.equalTo(contentView).inset(20)
        }
        // CellView Settings
        cellView.clipsToBounds = true
        cellView.layer.cornerRadius = 20
        contentView.addSubview(cellView)
        cellView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom)
            make.left.right.equalTo(contentView)
            make.bottom.equalTo(contentView).offset(8)
        }
        //Square Image
        squareImage.image = UIImage(named: "image9")
        squareImage.contentMode = .scaleAspectFill
        cellView.addSubview(squareImage)
        squareImage.snp.makeConstraints { make in
            make.edges.equalTo(cellView).inset(UIEdgeInsets())
        }
        // WebView Set
        let webConfig = WKWebViewConfiguration()
        webConfig.preferences.javaScriptEnabled = true
        webView = WKWebView(frame: .zero, configuration: webConfig)
        webView.navigationDelegate = self
        webView.isOpaque = false
        webView.backgroundColor = .clear
        cellView.addSubview(webView)
        
        webView.snp.makeConstraints { make in
            make.top.equalTo(cellView.snp.top).offset(10)
            make.left.right.equalTo(cellView).inset(10)
            make.bottom.equalTo(cellView.snp.bottom).inset(10)
        }
    }
    // Configure Functions 
    override func configure(with item: History) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateLabel.text = dateFormatter.string(from: item.date)
        WebViewHelper.loadLatex(item.questionCore, in: webView)
    }
}





