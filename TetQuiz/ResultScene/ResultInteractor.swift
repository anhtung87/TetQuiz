//
//  ResultInteractor.swift
//  TetQuiz
//
//  Created by Hoang Tung on 1/31/20.
//  Copyright © 2020 Hoang Tung. All rights reserved.
//

import Foundation

protocol ResultBusinessLogic {
    func getQuestions(request: Result.Request)
}

protocol ResultDataStore {
    var dataStore: [Question]! { get set }
}

class ResultInteractor: ResultBusinessLogic, ResultDataStore {
    var dataStore: [Question]!
    var presenter: ResultPresentationLogic?
    
    func getQuestions(request: Result.Request) {
        let rightQuestions = dataStore?.filter { (question) -> Bool in
            question.userAnswers == question.rightAnswer
        }
        let response = Result.Response(rightAnswerNumber: rightQuestions!.count, totalQuestionsNumber: dataStore!.count)
        presenter?.presentResult(response: response)
    }
}
