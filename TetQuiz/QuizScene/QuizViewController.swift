//
//  ViewController.swift
//  TetQuiz
//
//  Created by Hoang Tung on 1/20/20.
//  Copyright © 2020 Hoang Tung. All rights reserved.
//

import UIKit

protocol QuizDisplayLogic {
    func displayFetchedQuestions(viewModel: Quiz.FetchQuestions.ViewModel)
}

class QuizViewController: UIViewController, QuizDisplayLogic {
    
    var interactor: QuizBusinessLogic?
    var router: (QuizRoutingLogic & QuizDataPassing)?
    
    let quizTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var questionsView: Quiz.FetchQuestions.ViewModel?

// MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?){
      super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
      configurator()
    }
    
    required init?(coder aDecoder: NSCoder){
      super.init(coder: aDecoder)
      configurator()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configurator()
        setup()
        setupLayout()
        setupFooter()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchQuestions()
    }
    
    // MARK: config VIP architechture
    func configurator() {
        let viewController = self
        let interactor = QuizInteractor()
        let presenter = QuizPresenter()
        let router = QuizRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: setup Quiz Table View
    
    func setup() {
        view.addSubview(quizTableView)
        quizTableView.delegate = self
        quizTableView.dataSource = self
    }

    func setupLayout() {
        quizTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        quizTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        quizTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        quizTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    func setupFooter() {
        let footer = QuizFooterView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.maxX, height: 100))
        quizTableView.tableFooterView = footer
        footer.finishButton.addTarget(self, action: #selector(routingToResult), for: .touchUpInside)
    }
    
    @objc func routingToResult() {
        router?.routeToResult()
    }
    
    // send data to QuizInteractor
    func fetchQuestions() {
        let request = Quiz.FetchQuestions.Request()
        interactor?.fetchQuestions(request: request)
    }
    
    // send index of selected Cell to QuizInteractor
    func selectCell(section: Int, cell: Int) {
        interactor?.selectCell(section: section, cell: cell)
    }
    
    // reset request
    func resetQuestions() {
        let request = Quiz.Reset.Request()
        interactor?.resetQuestions(request: request)
    }
    
    // receive data from QuizPresenter
    func displayFetchedQuestions(viewModel: Quiz.FetchQuestions.ViewModel) {
        questionsView = viewModel
        quizTableView.reloadData()
    }
}

extension QuizViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.maxX, height: 70))
        headerView.backgroundColor = .systemIndigo
        
        let label = UILabel()
        label.text = questionsView?.displayQuestions[section].section.question
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        label.frame = CGRect(x: 16, y: 0, width: headerView.frame.width - 32, height: headerView.frame.height)
        
        headerView.addSubview(label)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return questionsView?.displayQuestions.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionsView?.displayQuestions[section].cells.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = QuizTableViewCell()
        let dataCell = questionsView?.displayQuestions[indexPath[0]].cells[indexPath.row]
        cell.checkImageView.image = dataCell?.image
        cell.answerLabel.text = dataCell?.answer
        return cell
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        selectCell(section: indexPath[0], cell: indexPath.row)
    }
}
