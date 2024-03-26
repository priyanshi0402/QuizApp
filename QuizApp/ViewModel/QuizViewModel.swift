//
//  QuizViewModel.swift
//  QuizApp
//
//  Created by Dharmik Kalathiya on 2024-03-24.
//  Copyright © 2024 Priyanshi. All rights reserved.
//

import Foundation
import Combine

enum APIEndPoint {
    case easyLevel
    case mediumLevel
    case hardLevel
    
    var baseURL: String {
        return "https://opentdb.com/api.php"
    }
    
    var path: String {
        switch self {
        case .easyLevel:
            "?amount=20&difficulty=easy"
        case .mediumLevel:
            "?amount=20&difficulty=medium"
        case .hardLevel:
            "?amount=20&difficulty=hard"
        }
    }
    
    var url: URL? {
        return URL(string: baseURL+path)
    }
    
}

class QuizViewModel {
    
    private var quizPublisher: AnyPublisher<QuestionsResponse, Error>?
    var cancellables = Set<AnyCancellable>()
    
    var questions = CurrentValueSubject<[Questions], Never>([])
    
    func fetchQuiz(level: Difficulty = .easy) {
        
        var url: URL? = APIEndPoint.easyLevel.url
        
        switch level {
        case .easy:
            url = APIEndPoint.easyLevel.url
        case .medium:
            url = APIEndPoint.mediumLevel.url
        case .hard:
            url = APIEndPoint.hardLevel.url
        }
        
        guard let url = url else { return }
        
        quizPublisher = URLSession.shared.dataTaskPublisher(for: url)
            .map({$0.data})
            .decode(type: QuestionsResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
        quizPublisher?.sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
            case .failure(let failure):
                print("Error fetching quiz: \(failure.localizedDescription)")
            }
        }, receiveValue: { questionResponse in
            self.questions.value = questionResponse.results
        })
        .store(in: &cancellables)
        
    }
}
