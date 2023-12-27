//
//  DetailViewController.swift
//  MathSolver
//
//  Created by Furkan Deniz Albaylar on 10.12.2023.
//

import UIKit
import SnapKit
import WebKit
import NeonSDK

class DetailViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    var webQuestionView : WKWebView!
    var questionText: String?
    var solution : String?
    var activityIndicator: UIActivityIndicatorView!
    let solutionView = UIView()
    let stepBystepView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActivityIndicator()
        fetchNewQueryResult()
        loadQustionIntoWebView(latex: questionText ?? "")
    }

    private func setupUI() {
        view.backgroundColor = .onboardingBackColor
        // Line View
        let lineView = UIView()
        lineView.backgroundColor = .lightGray
        view.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(47)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        // Back Button
        let backButton = UIButton()
        backButton.setImage(UIImage(named: "backIcon"), for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        view.addSubview(backButton)
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(9)
            make.left.equalToSuperview().inset(7)
            make.height.equalTo(24)
            make.width.equalTo(18)
        }
        // Solution Top View
        let solutionNickLabel = UILabel()
        solutionNickLabel.text = "Solution"
        solutionNickLabel.font = Font.custom(size: 17, fontWeight: .SemiBold)
        solutionNickLabel.textAlignment = .center
        view.addSubview(solutionNickLabel)
        solutionNickLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(9)
            make.right.left.equalToSuperview().inset(130)
        }
        // Question View
        let questionView = UIView()
        view.addSubview(questionView)
        questionView.backgroundColor = .white
        questionView.layer.cornerRadius = 20
        questionView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(24)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(view.bounds.height * 0.2)
        }
        // Question Name Label
        let questionNameLabel = UILabel()
        questionNameLabel.text = "Question"
        questionNameLabel.font = Font.custom(size:22, fontWeight: .Bold)
        questionNameLabel.textAlignment = .left
        questionView.addSubview(questionNameLabel)
        questionNameLabel.snp.makeConstraints { make in
            make.top.equalTo(questionView.snp.top).offset(18)
            make.right.left.equalTo(questionView).inset(18)
        }
        // Web Qustion
        let webQuestionConfiguration = WKWebViewConfiguration()
        webQuestionConfiguration.preferences.javaScriptEnabled = true
        webQuestionView = WKWebView(frame: .zero, configuration: webQuestionConfiguration)
        webQuestionView.navigationDelegate = self
        webQuestionView.layer.cornerRadius = 20
        questionView.addSubview(webQuestionView)
        webQuestionView.snp.makeConstraints { make in
            make.top.equalTo(questionNameLabel.snp.bottom).offset(9)
            make.right.left.equalTo(questionView).inset(18)
            make.height.equalTo(questionView.snp.height).multipliedBy(0.5) 
        }
        // Solution View
        view.addSubview(solutionView)
        solutionView.backgroundColor = .white
        solutionView.layer.cornerRadius = 20
        solutionView.snp.makeConstraints { make in
            make.top.equalTo(questionView.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(124)
        }
        // Solution Name Label
        let solutionNameLabel = UILabel()
        solutionNameLabel.text = "Solution"
        solutionNameLabel.font = Font.custom(size:22, fontWeight: .Bold)
        solutionNameLabel.textAlignment = .left
        solutionView.addSubview(solutionNameLabel)
        solutionNameLabel.snp.makeConstraints { make in
            make.top.equalTo(solutionView.snp.top).offset(18)
            make.right.left.equalTo(questionView).inset(18)
        }
        // Solution Label
        let solutionLabel = UILabel()
        solutionLabel.text = solution
        solutionLabel.font = Font.custom(size:32, fontWeight: .Medium)
        solutionView.addSubview(solutionLabel)
        solutionLabel.snp.makeConstraints { make in
            make.top.equalTo(solutionNameLabel.snp.bottom).offset(18)
            make.right.left.equalTo(questionView).inset(18)
        }
        // Step By Step View
        view.addSubview(stepBystepView)
        stepBystepView.backgroundColor = .white
        stepBystepView.layer.cornerRadius = 20
        stepBystepView.snp.makeConstraints { make in
            make.top.equalTo(solutionView.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(84)
        }
        // Web View Configuration
        let stepbyStepName = UILabel()
        stepbyStepName.text = "Solving Steps"
        stepbyStepName.font = Font.custom(size:22, fontWeight: .Bold)
        stepbyStepName.textAlignment = .left
        stepBystepView.addSubview(stepbyStepName)
        stepbyStepName.snp.makeConstraints { make in
            make.top.equalTo(stepBystepView.snp.top).offset(18)
            make.right.left.equalTo(questionView).inset(18)
        }
        // Web Configuration
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.preferences.javaScriptEnabled = true
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        webView.layer.cornerRadius = 20
        stepBystepView.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.top.equalTo(stepbyStepName.snp.bottom).offset(18)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(questionView.snp.height).multipliedBy(1.3)
        }
    }
    //Activity Indicator
    private func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        solutionView.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(stepBystepView)
            make.width.height.equalTo(40)
        }
        activityIndicator.startAnimating()
    }
    // We set question text.
    private func configureWithSolutionText(_ solutionText: String) {
        questionText = solutionText
    }
    // Load Latex Form
    private func loadQustionIntoWebView(latex: String) {
        WebViewHelper.displayLatex(latex, in: webQuestionView)
    }
    // Parse Format to WebView
    private func parseAndFormatSteps(from answer: String) -> String {
        let steps = answer.components(separatedBy: .newlines)
            .filter { $0.contains("Step-") }
            .joined(separator: " \\\\ ")
        return steps
    }
    // New Fetch to DetailView -
    // Diffrent Query
    private func fetchNewQueryResult() {
        guard let question = questionText else { return }
        activityIndicator.startAnimating()
        
        NetworkManager.shared.fetchMathSteps(for: question) { [weak self] result in
            guard let self = self else { return }
            self.activityIndicator.stopAnimating()
            
            switch result {
            case .success(let response):
                let formattedSteps = self.parseAndFormatSteps(from: response)
                DispatchQueue.main.async {
                    // Formatted WebView sent to the Latex
                    WebViewHelper.loadLatexContent(formattedSteps, in: self.webView)
                }
                print(response)
            case .failure(let error):
                print("Hata oluştu: \(error.localizedDescription)")
            }
        }
    }
    // Go back Function
    @objc func goBack(){
        self.dismiss(animated: true)
    }
}

