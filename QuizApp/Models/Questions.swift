//
//  Questions.swift
//  QuizApp
//
//  Created by Dharmik Kalathiya on 2024-03-24.
//  Copyright © 2024 Priyanshi. All rights reserved.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

// MARK: - Welcome
struct QuestionsResponse: Codable {
    let responseCode: Int
    let results: [Questions]

    enum CodingKeys: String, CodingKey {
        case responseCode = "response_code"
        case results
    }
}

// MARK: - Result
struct Questions: Codable {
    let type: TypeEnum
    let difficulty: Difficulty
    let category, question, correctAnswer: String
    let incorrectAnswers: [String]

    enum CodingKeys: String, CodingKey {
        case type, difficulty, category, question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
}

enum Difficulty: String, Codable {
    case easy = "easy"
    case medium = "medium"
    case hard = "hard"
    
//    var baseURL: String {
//        return "https://opentdb.com/api.php"
//    }
//    
//    var path: String {
//        switch self {
//        case .easy:
//            "?amount=20&difficulty=easy"
//        case .medium:
//            "?amount=20&difficulty=medium"
//        case .hard:
//            "?amount=20&difficulty=hard"
//        }
//    }
//    
//    var url: URL? {
//        return URL(string: baseURL+path)
//    }
}

enum TypeEnum: String, Codable {
    case boolean = "boolean"
    case multiple = "multiple"
}
