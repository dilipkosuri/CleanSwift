//
//  LoginViewController.swift
//  CleanSwift
//
//  Created by DILIP KOSURI on 13/7/17.
//  Copyright (c) 2017 DILIP KOSURI. All rights reserved.
//

import UIKit
import Foundation

protocol LoginViewControllerInterface: class {
  func displaySomething(viewModel: Login.Something.ViewModel)
}

final class LoginViewController: UIViewController, LoginViewControllerInterface {
  var interactor: LoginInteractorInterface!
  var router: LoginRouter!
    
    // MARK: IBOutlet
    
    @IBOutlet weak var name_textfield: UITextField!
    @IBOutlet weak var favorite_textfield: UITextField!
    @IBOutlet weak var more_info_text: UIButton!
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var disclaimer_text_label: UILabel!
    
  // MARK: - Object lifecycle

  override func awakeFromNib() {
    super.awakeFromNib()
    LoginConfigurator.sharedInstance.configure(viewController: self)
  }

  // MARK: - View lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    doSomethingOnLoad()
    // Method: connectContainerElements can be used to assign the values based on locale.
    connectContainerElements()
  }
    
  // MARK: - Event handling
    
    func connectContainerElements(){
      name_textfield.text = L10n.lEnterNameText.string
      favorite_textfield.text = L10n.lEnterFavoriteMovieText.string
      disclaimer_text_label.text = L10n.lDisclaimerText.string
      more_info_text.titleLabel?.text = L10n.lMoreInfoText.string
      translateButton.titleLabel?.text = L10n.lFrenchLocaleText.string
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
