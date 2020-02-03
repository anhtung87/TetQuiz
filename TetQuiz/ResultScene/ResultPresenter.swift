//
//  ResultPresenter.swift
//  TetQuiz
//
//  Created by Hoang Tung on 1/31/20.
//  Copyright © 2020 Hoang Tung. All rights reserved.
//

import Foundation

protocol ResultPresentationLogic {
    func presentResult(response: Result.Response)
}

class ResultPresenter: ResultPresentationLogic {
    var viewController: ResultDisplayLogic?
    
    func presentResult(response: Result.Response) {
        let resultString = String(response.rightAnswerNumber) + " / " + String(response.totalQuestionsNumber)
        viewController?.showResult(resultString: Result.ViewModel(content: resultString))
    }
}
