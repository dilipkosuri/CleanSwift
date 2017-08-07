// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation
import UIKit
import CustomSegue
import LocationPicker
import SlackTextViewController

// swiftlint:disable file_length
// swiftlint:disable line_length
// swiftlint:disable type_body_length

protocol StoryboardSceneType {
  static var storyboardName: String { get }
}

extension StoryboardSceneType {
  static func storyboard() -> UIStoryboard {
    return UIStoryboard(name: self.storyboardName, bundle: NSBundle(forClass: BundleToken.self))
  }

  static func initialViewController() -> UIViewController {
    guard let vc = storyboard().instantiateInitialViewController() else {
      fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
    }
    return vc
  }
}

extension StoryboardSceneType where Self: RawRepresentable, Self.RawValue == String {
  func viewController() -> UIViewController {
    return Self.storyboard().instantiateViewControllerWithIdentifier(self.rawValue)
  }
  static func viewController(identifier: Self) -> UIViewController {
    return identifier.viewController()
  }
}

protocol StoryboardSegueType: RawRepresentable { }

extension UIViewController {
  func performSegue<S: StoryboardSegueType where S.RawValue == String>(segue: S, sender: AnyObject? = nil) {
    performSegueWithIdentifier(segue.rawValue, sender: sender)
  }
}

enum XCTStoryboardsScene {
  enum AdditionalImport: String, StoryboardSceneType {
    static let storyboardName = "AdditionalImport"

    static func initialViewController() -> LocationPicker.LocationPickerViewController {
      guard let vc = storyboard().instantiateInitialViewController() as? LocationPicker.LocationPickerViewController else {
        fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
      }
      return vc
    }

    case PublicScene = "public"
    static func instantiatePublic() -> SlackTextViewController.SLKTextViewController {
      guard let vc = XCTStoryboardsScene.AdditionalImport.PublicScene.viewController() as? SlackTextViewController.SLKTextViewController
      else {
        fatalError("ViewController 'public' is not of the expected class SlackTextViewController.SLKTextViewController.")
      }
      return vc
    }
  }
  enum Anonymous: StoryboardSceneType {
    static let storyboardName = "Anonymous"

    static func initialViewController() -> UINavigationController {
      guard let vc = storyboard().instantiateInitialViewController() as? UINavigationController else {
        fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
      }
      return vc
    }
  }
  enum Dependency: String, StoryboardSceneType {
    static let storyboardName = "Dependency"

    case DependentScene = "Dependent"
    static func instantiateDependent() -> UIViewController {
      return XCTStoryboardsScene.Dependency.DependentScene.viewController()
    }
  }
  enum Message: String, StoryboardSceneType {
    static let storyboardName = "Message"

    case ComposerScene = "Composer"
    static func instantiateComposer() -> UIViewController {
      return XCTStoryboardsScene.Message.ComposerScene.viewController()
    }

    case MessagesListScene = "MessagesList"
    static func instantiateMessagesList() -> UITableViewController {
      guard let vc = XCTStoryboardsScene.Message.MessagesListScene.viewController() as? UITableViewController
      else {
        fatalError("ViewController 'MessagesList' is not of the expected class UITableViewController.")
      }
      return vc
    }

    case NavCtrlScene = "NavCtrl"
    static func instantiateNavCtrl() -> UINavigationController {
      guard let vc = XCTStoryboardsScene.Message.NavCtrlScene.viewController() as? UINavigationController
      else {
        fatalError("ViewController 'NavCtrl' is not of the expected class UINavigationController.")
      }
      return vc
    }

    case URLChooserScene = "URLChooser"
    static func instantiateURLChooser() -> XXPickerViewController {
      guard let vc = XCTStoryboardsScene.Message.URLChooserScene.viewController() as? XXPickerViewController
      else {
        fatalError("ViewController 'URLChooser' is not of the expected class XXPickerViewController.")
      }
      return vc
    }
  }
  enum Placeholder: String, StoryboardSceneType {
    static let storyboardName = "Placeholder"

    case NavigationScene = "Navigation"
    static func instantiateNavigation() -> UINavigationController {
      guard let vc = XCTStoryboardsScene.Placeholder.NavigationScene.viewController() as? UINavigationController
      else {
        fatalError("ViewController 'Navigation' is not of the expected class UINavigationController.")
      }
      return vc
    }
  }
  enum Wizard: String, StoryboardSceneType {
    static let storyboardName = "Wizard"

    static func initialViewController() -> CreateAccViewController {
      guard let vc = storyboard().instantiateInitialViewController() as? CreateAccViewController else {
        fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
      }
      return vc
    }

    case Accept_CGUScene = "Accept-CGU"
    static func instantiateAcceptCGU() -> UIViewController {
      return XCTStoryboardsScene.Wizard.Accept_CGUScene.viewController()
    }

    case CreateAccountScene = "CreateAccount"
    static func instantiateCreateAccount() -> CreateAccViewController {
      guard let vc = XCTStoryboardsScene.Wizard.CreateAccountScene.viewController() as? CreateAccViewController
      else {
        fatalError("ViewController 'CreateAccount' is not of the expected class CreateAccViewController.")
      }
      return vc
    }

    case PreferencesScene = "Preferences"
    static func instantiatePreferences() -> UITableViewController {
      guard let vc = XCTStoryboardsScene.Wizard.PreferencesScene.viewController() as? UITableViewController
      else {
        fatalError("ViewController 'Preferences' is not of the expected class UITableViewController.")
      }
      return vc
    }

    case Validate_PasswordScene = "Validate_Password"
    static func instantiateValidatePassword() -> UIViewController {
      return XCTStoryboardsScene.Wizard.Validate_PasswordScene.viewController()
    }
  }
}

enum XCTStoryboardsSegue {
  enum AdditionalImport: String, StoryboardSegueType {
    case Private = "private"
  }
  enum Message: String, StoryboardSegueType {
    case CustomBack
    case Embed
    case NonCustom
    case Show_NavCtrl = "Show-NavCtrl"
  }
  enum Wizard: String, StoryboardSegueType {
    case ShowPassword
  }
}

private final class BundleToken {}
