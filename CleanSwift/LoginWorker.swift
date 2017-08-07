//
//  LoginWorker.swift
//  CleanSwift
//
//  Created by DILIP KOSURI on 13/7/17.
//  Copyright (c) 2017 DILIP KOSURI. All rights reserved.
//

import UIKit

protocol LoginStoreProtocol {
  func getData(_ completion: @escaping (Result<Entity>) -> Void)
}

final class LoginWorker {

  var store: LoginStoreProtocol

  init(store: LoginStoreProtocol) {
    self.store = store
  }

  // MARK: - Business Logic

  func doSomeWork(_ completion: @escaping (Result<Entity>) -> Void) {
    // NOTE: Do the work
    store.getData {
      // The worker may perform some small business logic before returning the result to the Interactor
      completion($0)
    }
  }
}
