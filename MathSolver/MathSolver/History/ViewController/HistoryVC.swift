//
//  HistoryVC.swift
//  MathSolver
//
//  Created by Furkan Deniz Albaylar on 12.12.2023.
//

import UIKit
import NeonSDK

class HistoryVC: UIViewController {
    
    var expressions: [History] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    func setupUI(){
        view.backgroundColor = .white
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
        // History Top Label
        let historyNickLabel = UILabel()
        historyNickLabel.text = "History"
        historyNickLabel.font = Font.custom(size: 17, fontWeight: .SemiBold)
        historyNickLabel.textAlignment = .center
        view.addSubview(historyNickLabel)
        
        historyNickLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.right.left.equalToSuperview().inset(130)
        }
        CoreDataManager.fetchDatas(container: "CoreData", entity: "Entity") { [weak self] data in
                guard let self = self else { return }
                if let question = data.value(forKey: "questionCore") as? String,
                   let date = data.value(forKey: "date") as? Date {
                    let historyItem = History(date: date, questionCore: question)
                    self.expressions.insert(historyItem, at: 0)
                }
            }
        // Neon Table View
        let tableView = NeonTableView<History, HistoryTableViewCell>(objects: expressions, heightForRows: 150)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(5)
            make.left.right.bottom.equalToSuperview()
        }
        tableView.didSelect = { [weak self] history, indexPath in
        }
    // Trailing to tableView
        tableView.trailingSwipeActions = [
            SwipeAction(title: "Sil", color: .red) { [weak self] history, indexPath in
                CoreDataManager.deleteData(container: "CoreData", entity: "Entity", searchKey: "questionCore", searchValue: history.questionCore)

                DispatchQueue.main.async {
                    self?.expressions.remove(at: indexPath.row)
                    tableView.objects = self?.expressions ?? []

                    print("Date: \(history.date)")
                }
            }
        ]
        // Leading to tableView
        tableView.leadingSwipeActions = [
            SwipeAction(title: "Düzenle", color: .blue) { [weak self] history, indexPath in
                // TODO:
            }
        ]
    }
    // Go back
    @objc func goBack(){
        self.dismiss(animated: true)
    }
}


