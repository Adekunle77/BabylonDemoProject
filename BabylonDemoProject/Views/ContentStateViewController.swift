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
    
    let model = ContentStateViewModel()
    private var showViewController: UIViewController?
    weak var delegate: ContentStateErrorDelegate?
    var testString = String()
    private var state: State?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self
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
        case loadingView = "loadingView"
        case errorView = "errorView"
        case postView = "postView"
    }
    
}

extension ContentStateViewController: ContentStateViewModelDelegate {
    func didUpdateWithError(error: Error) {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ErrorViewVC") as? ErrorViewController else { return }
    
        viewController.error = error.localizedDescription
        print(error.localizedDescription)
        self.present(viewController, animated: false, completion: nil)
    }
    
    func didUpdateWithData() {
        let postViewVC = PostsViewController()
        transtion(to: .render(postViewVC), identifiers: .postView)
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




