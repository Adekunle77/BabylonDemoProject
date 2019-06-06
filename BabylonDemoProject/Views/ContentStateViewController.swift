//
//  ContentStateViewController.swift
//  BabylonDemoProject
//
//  Created by Ade Adegoke on 10/05/2019.
//  Copyright © 2019 AKA. All rights reserved.
//

import UIKit

protocol ContentStateErrorDelegate: class {
    func displayErrorMessage(error: Error)
}


class ContentStateViewController: UIViewController {

    var model = ContentStateViewModel()
    private var showViewController: UIViewController?
    weak var delegate: ContentStateErrorDelegate?
    private var state: State?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //model = ContentStateViewModel()
        self.model.delegate = self
        self.model.getPosts()
        if state == nil {
            transtion(to: .loading, identifiers: .loadingView)
        }
    }

    
    func transtion(to newState: State, identifiers: Identifiers ) {
        showViewController?.remove()
        let vc = viewController(for: newState)
        add(vc)
        showViewController = vc
        state = newState
        self.performSegue(withIdentifier: identifiers.rawValue, sender: nil)
        
    }
    
    enum Identifiers: String {
        case loadingView
        case errorView
        case postView
    }
    
}

extension ContentStateViewController: ContentStateViewModelDelegate {
    func didUpdateWithError(error: Error) {
        guard let viewController = UIStoryboard(
            name: "Main",
            bundle: nil).instantiateViewController(
            withIdentifier: "ErrorViewVC")  as? ErrorViewController else { return }

        viewController.error = error.localizedDescription
       // self.present(viewController, animated: false, completion: nil)
        transtion(to: .render(viewController), identifiers: .errorView)
    }
    
    func didUpdateWithData() {
        guard let viewController = UIStoryboard(
            name: "Main",
            bundle: nil).instantiateViewController(
                withIdentifier: "PostViewVC") as? PostsViewController else { return }
        transtion(to: .render(viewController), identifiers: .postView)
    }
}

extension ContentStateViewController {
    enum State {
        case loading
        case failed
        case render(UIViewController)
    }
}

private extension ContentStateViewController {
    func viewController(for state: State) -> UIViewController {
        switch state {
        case .loading:
            return LoadingViewController()
        case .render(let viewController):
            return viewController
        case .failed:
            return ErrorViewController()
        }
    }
}




