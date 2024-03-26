//
//  QuestionsCollectionViewCell.swift
//  QuizApp
//
//  Created by Dharmik Kalathiya on 2024-03-24.
//  Copyright © 2024 Priyanshi. All rights reserved.
//

import UIKit

protocol SelectOptionDelegate: AnyObject {
    func didSelectOption(_ option: String)
}

class QuestionsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblTitle: UILabel!
    
    weak var delegate: SelectOptionDelegate?
    
    var options: [String] = []
    var question: Questions? {
        didSet {
            self.setupOptions()
            self.tblView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupTableView()
    }
    
    override var accessibilityLabel: String? {
            get {
                return lblTitle.text
            }
            set {
                // Ignore setting accessibility label for this view
            }
        }
    
    override var accessibilityTraits: UIAccessibilityTraits {
            get {
                return .staticText
            }
            set {
                // Ignore setting accessibility traits for this view
            }
        }

}

extension QuestionsCollectionViewCell {
    
    func setupTableView() {
        self.tblView.dataSource = self
        self.tblView.delegate = self
        
        self.tblView.registerCell(ofType: QuizOptionsTableViewCell.self)
        
//        self.tblView.isAccessibilityElement = true
//        self.tblView.accessibilityTraits = .button
//        self.tblView.accessibilityLabel = "Question"
//        self.tblView.accessibilityHint = "Double tap to answer"
    }
    
    func setupOptions() {
        var options = self.question?.incorrectAnswers ?? []
        options.append(self.question?.correctAnswer ?? "")
        options.shuffle()
        self.options = options
    }
        
}

extension QuestionsCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(ofType: QuizOptionsTableViewCell.self, forIndexPath: indexPath) else { return UITableViewCell() }
        let option = self.options[indexPath.row]
        cell.lblOptions.text = option
        cell.lblOptions.backgroundColor = .systemGray6
        cell.isAccessibilityElement = true // Enable VoiceOver accessibility for table view cells
                cell.accessibilityTraits = .button
        cell.lblOptions.isAccessibilityElement = true
        
//        debugPrint(#function)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let correctAnswer = self.question?.correctAnswer ?? ""
        let option = self.options[indexPath.row]
        
        if let cell = tableView.cellForRow(at: indexPath) as? QuizOptionsTableViewCell {
            if correctAnswer == option {
                cell.lblOptions.backgroundColor = .green
            } else {
                cell.lblOptions.backgroundColor = .red
            }
        }
        
        self.delegate?.didSelectOption(option)
        
    }
    
}
