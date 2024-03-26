//
//  QuizQuestionsVC.swift
//  QuizApp
//
//  Created by Dharmik Kalathiya on 2024-03-24.
//  Copyright © 2024 Priyanshi. All rights reserved.
//

import UIKit

class QuizQuestionsVC: UIViewController {
    
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedLevel: Difficulty = .easy
    private let viewModel = QuizViewModel()
    private var progressTimer: Timer!
    private var progressCount = 0.10

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showNavigationBar()
        
        self.setupCollectionView()
        self.fetchQuestions()
        self.bindViewModel()
//        self.setupProgressBar()
        
    }

}

// MARK: - Setup Views

extension QuizQuestionsVC {
    
    private func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.registerCell(ofType: QuestionsCollectionViewCell.self)
    }
    
    private func setupProgressBar() {
        switch self.selectedLevel {
        case .easy: self.progressCount = 0.10
        case .medium: self.progressCount = 0.07
        case .hard: self.progressCount = 0.05
        }
        self.progressBar.progress = 0.0
        self.progressTimer = Timer.scheduledTimer(timeInterval: progressCount, target: self, selector: #selector(self.updateProgressView), userInfo: nil, repeats: true)
    }
    
    private func scrollToNextQuestion() {
        progressTimer.invalidate()
        
        let visibleRect = CGRect(origin: self.collectionView.contentOffset, size: self.collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath = self.collectionView.indexPathForItem(at: visiblePoint)
        let currentQuestionIndex = (visibleIndexPath?.row ?? 0)+1
        
        if self.viewModel.questions.value.count == currentQuestionIndex  {
            debugPrint("All Question has been done.")
            self.navigateBackViewController()
            return
        }
        
        self.collectionView.scrollToItem(at: IndexPath(row: (visibleIndexPath?.row ?? 0)+1, section: 0), at: .right, animated: true)
        
        self.setupProgressBar()
    }
    
    @objc func updateProgressView() {
        
        progressBar.progress += 0.01
        progressBar.setProgress(progressBar.progress, animated: true)
        
        if(progressBar.progress == 1.0) {
            self.scrollToNextQuestion()
        }
        
    }
}


// MARK: - Call APIs
extension QuizQuestionsVC {
    
    private func fetchQuestions() {
        viewModel.fetchQuiz(level: selectedLevel)
    }
    
    private func bindViewModel() {
        viewModel.questions
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
                if self?.viewModel.questions.value.count != 0 {
                    self?.setupProgressBar()
                    self?.lblCount.isHidden = false
                    self?.lblCount.text = "1/\(self?.viewModel.questions.value.count ?? 0)"
                }
                
            }
            .store(in: &viewModel.cancellables)
    }
}

extension QuizQuestionsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.questions.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueCell(ofType: QuestionsCollectionViewCell.self, forIndexPath: indexPath) else { return UICollectionViewCell() }
        let data = viewModel.questions.value[indexPath.row]
        cell.lblTitle.text = data.question
        cell.question = data
        self.lblCount.text = "\(indexPath.item+1)/\(self.viewModel.questions.value.count)"
        cell.delegate = self
                
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
        
}

extension QuizQuestionsVC: SelectOptionDelegate {
    
    func didSelectOption(_ option: String) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.scrollToNextQuestion()
        }
    }
    
}
