//
//  LoginInteractor.swift
//  CleanSwift
//
//  Created by SGpad MBP 019 on 13/7/17.
//  Copyright (c) 2017 DILIP KOSURI. All rights reserved.
//

import UIKit

protocol LoginInteractorInterface {
  func doSomething(request: Login.Something.Request)
  var model: Entity? { get }
}

final class LoginInteractor: LoginInteractorInterface {
  var presenter: LoginPresenterInterface!
  var worker: LoginWorker?
  var model: Entity?

  // MARK: - Business logic

  func doSomething(request: Login.Something.Request) {
    worker?.doSomeWork { [weak self] in
      if case let Result.success(data) = $0 {
        // If the result was successful, we keep the data so that we can deliver it to another view controller through the router.
        self?.model = data
      }

      // NOTE: Pass the result to the Presenter. This is done by creating a response model with the result from the worker. The response could contain a type like UserResult enum (as declared in the SCB Easy project) with the result as an associated value.
      let response = Login.Something.Response()
      self?.presenter.presentSomething(response: response)
    }
  }
}
