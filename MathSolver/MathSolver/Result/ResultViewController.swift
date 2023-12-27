//
//  ResultViewController.swift
//  MathSolver
//
//  Created by Furkan Deniz Albaylar on 8.12.2023.
//
import UIKit
import SnapKit
import SwiftUI
import NeonSDK
import WebKit

class ResultViewController: UIViewController, WKNavigationDelegate {
    var webView = WKWebView()
    var resultText: String?
    var solvingLabel = UILabel()
    let plusImage = UIImageView()
    let containerView = UIView()
    let responseLabel = UILabel()
    let resultButton = CustomButton(title: "Show Solving Steps", font: Font.custom(size: 17, fontWeight: .SemiBold))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        displayResult()
        getSolvingResultFromChatGPT()
    }
    private func setupUI() {
        // BackGround Image View
        let backgroundImage = UIImage(named: "backGroundColor")
        let backgroundImageView = UIImageView(frame: view.bounds)
        backgroundImageView.image = backgroundImage
        backgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
        // Right Side Ball View
        let rightSide = UIImageView()
        rightSide.image = UIImage(named: "sideBall")
        view.addSubview(rightSide)
        rightSide.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.left.equalToSuperview().offset(21)
            make.right.equalToSuperview().inset(319)
            make.height.equalTo(view.snp.height).multipliedBy(0.09)
        }
        // Left Side Ball View
        let leftSide = UIImageView()
        leftSide.image = UIImage(named: "sideBall")
        view.addSubview(leftSide)
        leftSide.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.left.equalToSuperview().offset(319)
            make.right.equalToSuperview().inset(21)
            make.height.equalTo(view.snp.height).multipliedBy(0.09)
        }
        // Plus Image View
        plusImage.image = UIImage(named: "CenterImage")
        plusImage.layer.zPosition = 1
        plusImage.isHidden = false
        view.addSubview(plusImage)
        plusImage.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(145)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(176)
            make.height.equalTo(100)
        }
        // Container View
        view.addSubview(containerView)
        containerView.layer.cornerRadius = 38
        containerView.backgroundColor = .white
        containerView.clipsToBounds = true
        containerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(248)
            make.right.left.equalToSuperview().inset(26)
            make.bottom.equalToSuperview().inset(250)
            
        }
        // Web View
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.preferences.javaScriptEnabled = true
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        containerView.addSubview(webView)
        webView.navigationDelegate = self
        webView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(49)
            make.left.right.equalTo(containerView).inset(18)
            make.height.equalTo(70)
        }
        // Response Label
        responseLabel.textAlignment = .left
        responseLabel.numberOfLines = 0
        responseLabel.font = Font.custom(size: 32, fontWeight: .Medium)
        containerView.addSubview(responseLabel)
        responseLabel.snp.makeConstraints { make in
            make.top.equalTo(webView.snp.bottom).offset(5)
            make.left.right.equalTo(containerView).inset(20)
        }
        // Solving Label
        solvingLabel.textAlignment = .center
        solvingLabel.numberOfLines = 0
        solvingLabel.font = Font.custom(size: 22, fontWeight: .Bold)
        solvingLabel.text = "Solving..."
        containerView.addSubview(solvingLabel)
        solvingLabel.snp.makeConstraints { make in
            make.top.equalTo(responseLabel.snp.bottom).offset(7)
            make.left.right.equalTo(containerView).inset(20)
        }
        // Result Button
        resultButton.isHidden = true
        containerView.addSubview(resultButton)
        resultButton.snp.makeConstraints { make in
            make.top.equalTo(responseLabel.snp.bottom).offset(15)
            make.right.left.equalToSuperview().inset(57)
            make.height.equalTo(60)
        }
        // Bottom Image View
        let bottomImageView = UIImageView()
        bottomImageView.image = UIImage(named: "bottomImage")
        view.addSubview(bottomImageView)
        bottomImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(627)
            make.right.left.equalToSuperview()
        }
    }
    
    private func displayResult() {
        if let resultText = resultText {
            // String -> Latex
            WebViewHelper.loadLatex(resultText, in: webView)
        } else {
            responseLabel.text = "No result available."
        }
    }
    // Result From ChatGPT
    private func getSolvingResultFromChatGPT() {
        guard let questionText = resultText else {
            responseLabel.text = "No question provided."
            return
        }
        NetworkManager.shared.fetchChatGPTResponse(for: questionText) { [weak self] result in
            switch result {
            case .success(let chatResponse):
                // Core Data Save Proces
                CoreDataManager.saveData(container: "CoreData",
                                        entity: "Entity",
                                        attributeDict: ["questionCore" : questionText,
                                                        "date" : Date()])
                // UI Updates
                self?.extractAndDisplayResult(from: chatResponse)
                self?.solvingLabel.text = "Solved"
                self?.updateConstraints()
                self?.plusImage.isHidden = true
                self?.resultButton.isHidden = false
            case .failure:
                self?.solvingLabel.text = "Error in getting response."
            }
        }
    }
    // Updated Constraints when datas come.
    private func updateConstraints() {
        webView.snp.removeConstraints()
        solvingLabel.snp.removeConstraints()
        responseLabel.snp.removeConstraints()
        resultButton.snp.removeConstraints()
        containerView.snp.removeConstraints()
        // Solving Label
        solvingLabel.textAlignment = .left
        solvingLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(15)
            make.left.right.equalTo(containerView).inset(37) 
        }
        // WebView
        webView.snp.makeConstraints { make in
            make.top.equalTo(solvingLabel.snp.bottom).offset(15)
            make.left.right.equalTo(containerView).inset(37)
            make.height.equalTo(76)
        }
        // Response Label
        responseLabel.snp.makeConstraints { make in
            make.top.equalTo(webView.snp.bottom).offset(15)
            make.left.right.equalTo(containerView).inset(37)
        }
        // Result Button
        resultButton.addTarget(self, action: #selector(resultButtonTapped), for: .touchUpInside)
        resultButton.snp.makeConstraints { make in
            make.top.equalTo(responseLabel.snp.bottom).offset(15)
            make.left.right.equalTo(containerView).inset(37)
            make.height.equalTo(60)
        }
        // Container View
        containerView.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(20)
            make.top.equalToSuperview().offset(221)
            make.height.equalTo(323)
        }
        containerView.layoutIfNeeded()
    }
    
    private func extractAndDisplayResult(from chatResponse: String) {
        self.responseLabel.text = chatResponse
    }
    // Result Button Tapped Functions
    @objc func resultButtonTapped(){
        let detailView = DetailViewController()
        detailView.modalPresentationStyle = .fullScreen
        detailView.questionText = resultText
        detailView.solution = responseLabel.text
        present(detailView, animated: true)
    }
    
}



