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
        navigateToQuizScene()
    }
    
    func navigateToQuizScene() {
        let index = viewController!.navigationController!.viewControllers.count - 2
        let destinationVC = viewController?.navigationController?.viewControllers[index] as! QuizViewController
        destinationVC.resetQuestions()
        viewController?.navigationController?.popViewController(animated: true)
    }
}
