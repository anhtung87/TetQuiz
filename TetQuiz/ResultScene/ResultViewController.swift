//
//  ResultViewController.swift
//  TetQuiz
//
//  Created by Hoang Tung on 1/31/20.
//  Copyright © 2020 Hoang Tung. All rights reserved.
//

import UIKit

protocol ResultDisplayLogic {
    func showResult(resultString: Result.ViewModel)
}

class ResultViewController: UIViewController, ResultDisplayLogic {
    
    var interactor: ResultBusinessLogic?
    var router: (ResultRoutingLogic & ResultDataPassing)?
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let resultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Kết quả"
        label.font = .systemFont(ofSize: 32)
        label.textAlignment = .center
        label.textColor = .systemBlue
        return label
    }()
    
    let pointLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 40)
        label.textAlignment = .center
        label.textColor = .systemPink
        return label
    }()
    
    let replayButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Chơi lại", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        return button
    }()
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
      super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
      configurator()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
      super.init(coder: aDecoder)
      configurator()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponent()
        setupLayout()
        setupNavigationItems()
        setupFuction()
    }
    
    // MARK: View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      getQuestions()
    }
    
    func getQuestions() {
        let request = Result.Request()
        interactor?.getQuestions(request: request)
    }
    
    func configurator() {
        let viewController = self
        let interactor = ResultInteractor()
        let presenter = ResultPresenter()
        let router = ResultRouter()
        viewController.router = router
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    func setupComponent() {
        view.addSubview(containerView)
        containerView.addSubview(resultLabel)
        containerView.addSubview(pointLabel)
        containerView.addSubview(replayButton)
    }
    
    func setupNavigationItems() {
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    func setupLayout() {
        containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        resultLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 0).isActive = true
        resultLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 300).isActive = true
        resultLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1).isActive = true
        resultLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 36).isActive = true
        
        pointLabel.centerXAnchor.constraint(equalTo: resultLabel.centerXAnchor, constant: 0).isActive = true
        pointLabel.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 16).isActive = true
        pointLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1).isActive = true
        pointLabel.heightAnchor.constraint(equalTo: resultLabel.heightAnchor, multiplier: 1).isActive = true

        replayButton.centerXAnchor.constraint(equalTo: resultLabel.centerXAnchor, constant: 0).isActive = true
        replayButton.topAnchor.constraint(equalTo: pointLabel.bottomAnchor, constant: 200).isActive = true
        replayButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.33).isActive = true
        replayButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func showResult(resultString: Result.ViewModel) {
        pointLabel.text = resultString.content
    }
    
    func setupFuction() {
        replayButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
    }
    
    @objc func popVC() {
        router?.routeToQuizScene()
    }
}
