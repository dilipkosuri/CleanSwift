//
// SwiftGen
// Copyright (c) 2015 Olivier Halligon
// MIT Licence
//

import Foundation
import XCTest
import PathKit

private let colorCode: (String) -> String =
  ProcessInfo().environment["XcodeColors"] == "YES" ? { "\u{001b}[\($0);" } : { _ in "" }
private let (msgColor, reset) = (colorCode("fg250,0,0"), colorCode(""))
private let okCode = (num: colorCode("fg127,127,127"),
                      code: colorCode(""))
private let koCode = (num: colorCode("fg127,127,127") + colorCode("bg127,0,0"),
                      code: colorCode("fg250,250,250") + colorCode("bg127,0,0"))

func diff(_ result: String, _ expected: String) -> String? {
  guard result != expected else { return nil }
  var firstDiff: Int? = nil
  let nl = CharacterSet.newlines
  let lhsLines = result.components(separatedBy: nl)
  let rhsLines = expected.components(separatedBy: nl)

  for (idx, pair) in zip(lhsLines, rhsLines).enumerated() {
    if pair.0 != pair.1 {
      firstDiff = idx
      break
    }
  }
  if let badLineIdx = firstDiff {
    let slice = { (lines: [String], context: Int) -> ArraySlice<String> in
      let start = max(0, badLineIdx-context)
      let end = min(badLineIdx+context, lines.count-1)
      return lines[start...end]
    }
    let addLineNumbers = { (slice: ArraySlice) -> [String] in
      slice.enumerated().map { (idx: Int, line: String) in
        let num = idx + slice.startIndex
        let lineNum = "\(num+1)".padding(toLength: 3, withPad: " ", startingAt: 0) + "|"
        let clr = num == badLineIdx ? koCode : okCode
        return "\(clr.num)\(lineNum)\(reset)\(clr.code)\(line)\(reset)"
      }
    }
    let lhsNum = addLineNumbers(slice(lhsLines, 4)).joined(separator: "\n")
    let rhsNum = addLineNumbers(slice(rhsLines, 4)).joined(separator: "\n")
    return [
      "\(msgColor)Mismatch at line \(badLineIdx)\(reset)",
      ">>>>>> result",
      "\(lhsNum)",
      "======",
      "\(rhsNum)",
      "<<<<<< expected"
    ].joined(separator: "\n")
  }
  return nil
}

func XCTDiffStrings(_ result: String, _ expected: String, file: StaticString = #file, line: UInt = #line) {
  guard let error = diff(result, expected) else { return }
  XCTFail(error, file: file, line: line)
}

class Fixtures {
  enum Directory: String {
    case colors = "Colors"
    case fonts = "Fonts"
    case images = "Images"
    case storyboardsiOS = "Storyboards-iOS"
    case storyboardsMacOS = "Storyboards-macOS"
    case strings = "Strings"
  }

  private static let testBundle = Bundle(for: Fixtures.self)
  private init() {}

  static func directory(sub: Directory? = nil) -> Path {
    guard let rsrcURL = testBundle.resourceURL else {
      fatalError("Unable to find resource directory URL")
    }
    let rsrc = Path(rsrcURL.path) + "Fixtures"

    guard let dir = sub else { return rsrc }
    return rsrc + dir.rawValue
  }

  static func path(for name: String, sub: Directory) -> Path {
    return path(for: name, subDirectory: "Fixtures/\(sub.rawValue)")
  }

  private static func path(for name: String, subDirectory: String) -> Path {
    guard let path = testBundle.path(forResource: name, ofType: "", inDirectory: subDirectory) else {
      fatalError("Unable to find fixture \"\(name)\"")
    }
    return Path(path)
  }

  static func template(for name: String) -> String {
    return string(for: name, subDirectory: "templates")
  }

  static func output(for name: String, sub: Directory) -> String {
    return string(for: name, subDirectory: "Expected/\(sub.rawValue)")
  }

  private static func string(for name: String, subDirectory: String) -> String {
    do {
      return try path(for: name, subDirectory: subDirectory).read()
    } catch let e {
      fatalError("Unable to load fixture content: \(e)")
    }
  }
}
