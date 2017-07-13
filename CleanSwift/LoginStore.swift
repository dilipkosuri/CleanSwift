//
//  LoginStore.swift
//  CleanSwift
//
//  Created by SGpad MBP 019 on 13/7/17.
//  Copyright (c) 2017 DILIP KOSURI. All rights reserved.
//

import Foundation

/*

 The LoginStore class implements the LoginStoreProtocol.

 The source for the data could be a database, cache, or a web service.

 You may remove these comments from the file.

 */

final class LoginStore: LoginStoreProtocol {
  func getData(_ completion: @escaping (Result<Entity>) -> Void) {
    // Simulates an asynchronous background thread that calls back on the main thread after 2 seconds
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      completion(Result.success(Entity()))
    }
  }
}
