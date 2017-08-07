// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation
import Cocoa
import PrefsWindowController

// swiftlint:disable file_length
// swiftlint:disable line_length
// swiftlint:disable type_body_length

protocol StoryboardSceneType {
  static var storyboardName: String { get }
}

extension StoryboardSceneType {
  static func storyboard() -> NSStoryboard {
    return NSStoryboard(name: self.storyboardName, bundle: NSBundle(forClass: BundleToken.self))
  }

  static func initialController() -> AnyObject {
    guard let controller = storyboard().instantiateInitialController()
    else {
      fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
    }
    return controller
  }
}

extension StoryboardSceneType where Self: RawRepresentable, Self.RawValue == String {
  func controller() -> AnyObject {
    return Self.storyboard().instantiateControllerWithIdentifier(self.rawValue)
  }
  static func controller(identifier: Self) -> AnyObject {
    return identifier.controller()
  }
}

protocol StoryboardSegueType: RawRepresentable { }

extension NSWindowController {
  func performSegue<S: StoryboardSegueType where S.RawValue == String>(segue: S, sender: AnyObject? = nil) {
    performSegueWithIdentifier(segue.rawValue, sender: sender)
  }
}

extension NSViewController {
  func performSegue<S: StoryboardSegueType where S.RawValue == String>(segue: S, sender: AnyObject? = nil) {
    performSegueWithIdentifier(segue.rawValue, sender: sender)
  }
}

enum StoryboardScene {
  enum AdditionalImport: String, StoryboardSceneType {
    static let storyboardName = "AdditionalImport"

    case PrivateScene = "private"
    static func instantiatePrivate() -> PrefsWindowController.DBPrefsWindowController {
      guard let vc = StoryboardScene.AdditionalImport.PrivateScene.controller() as? PrefsWindowController.DBPrefsWindowController
      else {
        fatalError("ViewController 'private' is not of the expected class PrefsWindowController.DBPrefsWindowController.")
      }
      return vc
    }
  }
  enum Anonymous: StoryboardSceneType {
    static let storyboardName = "Anonymous"
  }
  enum Dependency: String, StoryboardSceneType {
    static let storyboardName = "Dependency"

    case DependentScene = "Dependent"
    static func instantiateDependent() -> NSViewController {
      guard let vc = StoryboardScene.Dependency.DependentScene.controller() as? NSViewController
      else {
        fatalError("ViewController 'Dependent' is not of the expected class NSViewController.")
      }
      return vc
    }
  }
  enum Message: String, StoryboardSceneType {
    static let storyboardName = "Message"

    case MessageDetailsScene = "MessageDetails"
    static func instantiateMessageDetails() -> NSViewController {
      guard let vc = StoryboardScene.Message.MessageDetailsScene.controller() as? NSViewController
      else {
        fatalError("ViewController 'MessageDetails' is not of the expected class NSViewController.")
      }
      return vc
    }

    case MessageListScene = "MessageList"
    static func instantiateMessageList() -> NSViewController {
      guard let vc = StoryboardScene.Message.MessageListScene.controller() as? NSViewController
      else {
        fatalError("ViewController 'MessageList' is not of the expected class NSViewController.")
      }
      return vc
    }

    case MessageListFooterScene = "MessageListFooter"
    static func instantiateMessageListFooter() -> NSViewController {
      guard let vc = StoryboardScene.Message.MessageListFooterScene.controller() as? NSViewController
      else {
        fatalError("ViewController 'MessageListFooter' is not of the expected class NSViewController.")
      }
      return vc
    }

    case MessagesTabScene = "MessagesTab"
    static func instantiateMessagesTab() -> CustomTabViewController {
      guard let vc = StoryboardScene.Message.MessagesTabScene.controller() as? CustomTabViewController
      else {
        fatalError("ViewController 'MessagesTab' is not of the expected class CustomTabViewController.")
      }
      return vc
    }

    case SplitMessagesScene = "SplitMessages"
    static func instantiateSplitMessages() -> NSSplitViewController {
      guard let vc = StoryboardScene.Message.SplitMessagesScene.controller() as? NSSplitViewController
      else {
        fatalError("ViewController 'SplitMessages' is not of the expected class NSSplitViewController.")
      }
      return vc
    }

    case WindowCtrlScene = "WindowCtrl"
    static func instantiateWindowCtrl() -> NSWindowController {
      guard let vc = StoryboardScene.Message.WindowCtrlScene.controller() as? NSWindowController
      else {
        fatalError("ViewController 'WindowCtrl' is not of the expected class NSWindowController.")
      }
      return vc
    }
  }
  enum Placeholder: String, StoryboardSceneType {
    static let storyboardName = "Placeholder"

    case DependentScene = "Dependent"
    static func instantiateDependent() -> NSControllerPlaceholder {
      guard let vc = StoryboardScene.Placeholder.DependentScene.controller() as? NSControllerPlaceholder
      else {
        fatalError("ViewController 'Dependent' is not of the expected class NSControllerPlaceholder.")
      }
      return vc
    }

    case WindowScene = "Window"
    static func instantiateWindow() -> NSWindowController {
      guard let vc = StoryboardScene.Placeholder.WindowScene.controller() as? NSWindowController
      else {
        fatalError("ViewController 'Window' is not of the expected class NSWindowController.")
      }
      return vc
    }
  }
}

enum StoryboardSegue {
  enum Message: String, StoryboardSegueType {
    case Embed
    case Modal
    case Popover
    case Sheet
    case Show
    case Public = "public"
  }
}

private final class BundleToken {}
