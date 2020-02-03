//
//  QuizInteractor.swift
//  TetQuiz
//
//  Created by Hoang Tung on 1/20/20.
//  Copyright © 2020 Hoang Tung. All rights reserved.
//

import Foundation

protocol QuizBusinessLogic {
    func fetchQuestions(request: Quiz.FetchQuestions.Request)
    func selectCell(section: Int, cell: Int)
    func resetQuestions(request: Quiz.Reset.Request)
}

protocol QuizDataStore {
    var questions: [Question]? { get set }
}

class QuizInteractor: QuizBusinessLogic, QuizDataStore {
    var questions: [Question]? = quiz
    
    var presenter: QuizPresentationLogic?
    
    func fetchQuestions(request: Quiz.FetchQuestions.Request) {
        let response = Quiz.FetchQuestions.Response(questions: questions!)
        presenter!.presentFetchedQuestions(response: response)
    }
    
    func selectCell(section: Int, cell: Int) {
        questions![section].userAnswers = cell
        let response = Quiz.FetchQuestions.Response(questions: questions!)
        presenter!.presentFetchedQuestions(response: response)
    }
    
    func resetQuestions(request: Quiz.Reset.Request) {
        questions = quiz
        let response = Quiz.Reset.Response(questions: questions!)
        presenter!.presentNewQuestions(response: response)
    }
}
