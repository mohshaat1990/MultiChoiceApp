//
//  BaseClass.swift
//
//  Created by Mohamed Shaat on 1/25/21
//  Copyright (c) . All rights reserved.
//

import Foundation


 struct QuestionsResponse: Codable {

  // MARK: Declaration for string constants to be used to decode and also serialize.
 enum CodingKeys: String, CodingKey {
    case questions = "data"
  }
    public var questions: [Question]?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        questions = try container.decodeIfPresent([Question].self, forKey: .questions)
    }

}
