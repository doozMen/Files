// swift-tools-version:5.5

///  Files
///  Copyright (c) John Sundell 2017
///  Licensed under the MIT license. See LICENSE file.

import PackageDescription

let package = Package(
  name: "Files",
  platforms: [.macOS(.v11)],
  products: [
    .library(name: "Files", targets: ["Files"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.1.4"),
  ],
  targets: [
    .target(
      name: "Files",
      dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser")],
      path: "Sources"),
    .testTarget(
      name: "FilesTests",
      dependencies: ["Files"]),
  ])
