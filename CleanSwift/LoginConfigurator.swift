//
//  LoginConfigurator.swift
//  CleanSwift
//
//  Created by SGpad MBP 019 on 13/7/17.
//  Copyright (c) 2017 DILIP KOSURI. All rights reserved.
//

import UIKit

// MARK: - Connect View, Interactor, and Presenter

extension LoginViewController {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    router.passDataToNextScene(segue: segue)
  }

  @IBAction func unwindToLogin(from segue: UIStoryboardSegue) {
    print("unwind...")
    router.passDataToNextScene(segue: segue)
  }
}

final class LoginConfigurator {

  // MARK: - Object lifecycle

  static let sharedInstance = LoginConfigurator()

  private init() {}

  // MARK: - Configuration

  func configure(viewController: LoginViewController) {
    let router = LoginRouter()
    router.viewController = viewController

    let presenter = LoginPresenter()
    presenter.viewController = viewController

    let interactor = LoginInteractor()
    interactor.presenter = presenter
    interactor.worker = LoginWorker(store: LoginStore())

    viewController.interactor = interactor
    viewController.router = router
  }
}
