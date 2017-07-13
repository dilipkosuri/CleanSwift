//
//  LoginViewController.swift
//  CleanSwift
//
//  Created by SGpad MBP 019 on 13/7/17.
//  Copyright (c) 2017 DILIP KOSURI. All rights reserved.
//

import UIKit

protocol LoginViewControllerInterface: class {
  func displaySomething(viewModel: Login.Something.ViewModel)
}

final class LoginViewController: UIViewController, LoginViewControllerInterface {
  var interactor: LoginInteractorInterface!
  var router: LoginRouter!

  // MARK: - Object lifecycle

  override func awakeFromNib() {
    super.awakeFromNib()
    LoginConfigurator.sharedInstance.configure(viewController: self)
  }

  // MARK: - View lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    doSomethingOnLoad()
  }

  // MARK: - Event handling

  func doSomethingOnLoad() {
    // NOTE: Ask the Interactor to do some work

    let request = Login.Something.Request()
    interactor.doSomething(request: request)
  }

  // MARK: - Display logic

  func displaySomething(viewModel: Login.Something.ViewModel) {
    // NOTE: Display the result from the Presenter

    // nameTextField.text = viewModel.name
  }
}
