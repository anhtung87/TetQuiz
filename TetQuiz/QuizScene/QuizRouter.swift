//
//  QuizRouter.swift
//  TetQuiz
//
//  Created by Hoang Tung on 1/31/20.
//  Copyright © 2020 Hoang Tung. All rights reserved.
//

import Foundation

protocol QuizRoutingLogic {
    func routeToResult()
}

protocol QuizDataPassing {
    var dataStore: QuizDataStore? { get set }
}

class QuizRouter: QuizRoutingLogic, QuizDataPassing {
    weak var viewController: QuizViewController?
    var dataStore: QuizDataStore?
    
    func routeToResult() {
        let resultVC = ResultViewController()
        viewController?.navigationController?.pushViewController(resultVC, animated: true)
        var target = resultVC.router!.dataStore!
        passDataToResult(source: dataStore!, target: &target)
    }
    
    func passDataToResult(source: QuizDataStore, target: inout ResultDataStore) {
        target.dataStore = source.questions
    }
}
