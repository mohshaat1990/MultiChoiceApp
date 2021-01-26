//
//  BaseClass.swift
//
//  Created by Mohamed Shaat on 1/25/21
//  Copyright (c) . All rights reserved.
//

import Foundation


public struct QuestionsResponse: Codable {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let answers = "answers"
    static let trueAnswerId = "trueAnswerId"
    static let question = "question"
  }
    public var question: [Question]?

}
