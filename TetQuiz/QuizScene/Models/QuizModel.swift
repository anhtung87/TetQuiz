//
//  Quiz.swift
//  TetQuiz
//
//  Created by Hoang Tung on 1/20/20.
//  Copyright © 2020 Hoang Tung. All rights reserved.
//

import UIKit

enum Quiz {
    // MARK: Use cases
    enum FetchQuestions {
        struct Request {
        }
        
        struct Response {
            var questions: [Question]
        }
        
        struct ViewModel {
            struct DisplayQuestion {
                struct Section {
                    var question: String
                }
                
                struct Cell {
                    var answer: String
                    var image: UIImage
                }
                
                var section: Section
                var cells: [Cell]
            }
            
            var displayQuestions: [DisplayQuestion]
        }
    }
    
    enum Reset {
        struct Request {
        }
        
        struct Response {
            var questions: [Question]
        }
        
        struct ViewModel {
            struct DisplayQuestion {
                struct Section {
                    var question: String
                }
                
                struct Cell {
                    var answer: String
                    var image: UIImage
                }
                
                var section: Section
                var cells: [Cell]
            }
            
            var displayQuestions: [DisplayQuestion]
        }
    }
}

struct Question {
    let question: String
    let answers: [String]
    var userAnswers: Int?
    let rightAnswer: Int
}
