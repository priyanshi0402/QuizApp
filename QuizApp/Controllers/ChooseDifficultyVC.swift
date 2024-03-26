//
//  ViewController.swift
//  QuizApp
//
//  Created by Priyanshi Bhikadiya on 2024-03-24.
//

import UIKit

class ChooseDifficultyVC: UIViewController {

    @IBOutlet weak var btnHard: UIButton!
    @IBOutlet weak var btnMedium: UIButton!
    @IBOutlet weak var btnEasy: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

//MARK: - Button Actions
extension ChooseDifficultyVC {
    
    @IBAction func btnEsayClicked(_ sender: Any) {
        let quizVc = StoryboardScene.Main.quizQuestionsVC.instantiate()
        quizVc.selectedLevel = .easy
        self.pushVc(vc: quizVc)
    }
    
    @IBAction func btnMediumClicked(_ sender: Any) {
        let quizVc = StoryboardScene.Main.quizQuestionsVC.instantiate()
        quizVc.selectedLevel = .medium
        self.pushVc(vc: quizVc)
        
    }
    
    @IBAction func btnHardClicked(_ sender: Any) {
        let quizVc = StoryboardScene.Main.quizQuestionsVC.instantiate()
        quizVc.selectedLevel = .hard
        self.pushVc(vc: quizVc)
    }
}
