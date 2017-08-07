// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

import Foundation

// swiftlint:disable file_length
// swiftlint:disable line_length

// swiftlint:disable type_body_length
enum L10n {
  /// Remarque: Les détails saisis ici ne seront pas sauvegardés à la sortie
  case lDisclaimerText
  /// Entrez votre film préféré
  case lEnterFavoriteMovieText
  /// Entrez votre nom ici
  case lEnterNameText
  /// Traduire en français
  case lFrenchLocaleText
  /// Plus d'information
  case lMoreInfoText
}
// swiftlint:enable type_body_length

extension L10n: CustomStringConvertible {
  var description: String { return self.string }

  var string: String {
    switch self {
      case .lDisclaimerText:
        return L10n.tr(key: "l_disclaimer_text")
      case .lEnterFavoriteMovieText:
        return L10n.tr(key: "l_enter_favorite_movie_text")
      case .lEnterNameText:
        return L10n.tr(key: "l_enter_name_text")
      case .lFrenchLocaleText:
        return L10n.tr(key: "l_french_locale_text")
      case .lMoreInfoText:
        return L10n.tr(key: "l_more_info_text")
    }
  }

  private static func tr(key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

func tr(_ key: L10n) -> String {
  return key.string
}

private final class BundleToken {}
