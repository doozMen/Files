//
//  File.swift
//  
//
//  Created by Stijn Willems on 22/01/2024.
//

import Foundation

/// Use in swift concurrency contex
///
/// ```swift
/// // Usage
/// async {
///     let filePath = "path/to/your/file.txt"
///     if let fileHandler = FileHandler(path: filePath) {
///         try await fileHandler.write(data: Data("Hello, world!".utf8))
///         let data = try await fileHandler.read()
///         print(String(decoding: data, as: UTF8.self))
///     }
/// }
/// ```
/// > Note: This code was added based on a conversation with ChatGPT: https://chat.openai.com/share/43015252-6372-4cef-93da-c0d461df678a
public actor FileActor {
  private let fileHandle: FileHandle
  
  public init(url: URL, kind: Kind = .updating) throws {
    let handle: FileHandle
    switch kind {
    case .updating:
      handle = try FileHandle(forUpdating: url)
    case .writing:
      handle = try FileHandle(forWritingTo: url)
    case .reading:
      handle = try FileHandle(forReadingFrom: url)
    }
    self.fileHandle = handle
  }
  
  /// See Foundation FileHandle init
  /// ```swift
  ///  switch kind {
  ///   case .updating:
  ///     handle = try FileHandle(forUpdating: url)
  ///   case .writing:
  ///    handle = try FileHandle(forWritingTo: url)
  ///   case .reading:
  ///     handle = try FileHandle(forReadingFrom: url)
  /// }
  /// ```
  public enum Kind {
    case updating, writing, reading
  }
  
  public init(fileHandle: FileHandle) {
    self.fileHandle = fileHandle
  }
  
  deinit {
    try? fileHandle.close()
  }
  
  func write(data: Data) async throws {
    try fileHandle.write(contentsOf: data)
  }
  
  func read() async throws -> Data {
    return try fileHandle.readToEnd() ?? Data()
  }
}
