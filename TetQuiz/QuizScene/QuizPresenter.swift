//
//  QuizPresenter.swift
//  TetQuiz
//
//  Created by Hoang Tung on 1/20/20.
//  Copyright © 2020 Hoang Tung. All rights reserved.
//

import UIKit

protocol QuizPresentationLogic {
    func presentFetchedQuestions(response: Quiz.FetchQuestions.Response)
    func presentNewQuestions(response: Quiz.Reset.Response)
}

class QuizPresenter: QuizPresentationLogic {
    var viewController: QuizDisplayLogic?
    
    func presentFetchedQuestions(response: Quiz.FetchQuestions.Response) {
        let displayQuestions = response.questions.map { (question) -> Quiz.FetchQuestions.ViewModel.DisplayQuestion in
            let questionSection = Quiz.FetchQuestions.ViewModel.DisplayQuestion.Section(question: question.question)
            let answerCells = question.answers.enumerated().map { (index, answer) -> Quiz.FetchQuestions.ViewModel.DisplayQuestion.Cell in
                if index == question.userAnswers {
                    return Quiz.FetchQuestions.ViewModel.DisplayQuestion.Cell(
                        answer: answer, image: UIImage(named: "checked")!)
                }
                return Quiz.FetchQuestions.ViewModel.DisplayQuestion.Cell(
                    answer: answer, image: UIImage(named: "unchecked")!)
            }
            let display = Quiz.FetchQuestions.ViewModel.DisplayQuestion(section: questionSection, cells: answerCells)
            return display
        }
        let viewModel = Quiz.FetchQuestions.ViewModel(displayQuestions: displayQuestions)
        viewController?.displayFetchedQuestions(viewModel: viewModel)
    }
    
    func presentNewQuestions(response: Quiz.Reset.Response) {
        let response = Quiz.FetchQuestions.Response(questions: response.questions)
        presentFetchedQuestions(response: response)
    }
}
