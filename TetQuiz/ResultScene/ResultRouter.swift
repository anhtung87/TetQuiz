//
//  ResultRouter.swift
//  TetQuiz
//
//  Created by Hoang Tung on 1/31/20.
//  Copyright © 2020 Hoang Tung. All rights reserved.
//

import Foundation

protocol ResultRoutingLogic {
    func routeToQuizScene()
}

protocol ResultDataPassing {
    var dataStore: ResultDataStore? { get }
}

class ResultRouter: ResultRoutingLogic, ResultDataPassing {
    var dataStore: ResultDataStore?
    weak var viewController: ResultViewController?
    
    func routeToQuizScene() {
        dataStore!.dataStore = quiz
        let index = viewController!.navigationController!.viewControllers.count - 2
        let destinationVC = viewController?.navigationController?.viewControllers[index] as! QuizViewController
        var destinationDS = destinationVC.router!.dataStore!
        navigateToQuizScene()
        passingDataToQuiz(source: dataStore!, target: &destinationDS)
    }
    
    func navigateToQuizScene() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func passingDataToQuiz(source: ResultDataStore, target: inout QuizDataStore) {
        target.questions = source.dataStore
    }
}
