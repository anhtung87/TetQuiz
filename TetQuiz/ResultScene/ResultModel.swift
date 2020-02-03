//
//  ResultModel.swift
//  TetQuiz
//
//  Created by Hoang Tung on 2/3/20.
//  Copyright © 2020 Hoang Tung. All rights reserved.
//

import Foundation

enum Result {
    struct Request {
    }
    
    struct Response {
        var rightAnswerNumber: Int
        var totalQuestionsNumber: Int
    }
    
    struct ViewModel {
        var content: String
    }
}
