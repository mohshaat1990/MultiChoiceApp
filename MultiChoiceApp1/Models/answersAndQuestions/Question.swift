//
//  Question.swift
//
//  Created by Mohamed Shaat on 1/25/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct Question: Codable {
    
    enum CodingKeys: String, CodingKey {
        case answers = "answers"
        case trueAnswerId = "trueAnswerId"
        case  question = "question"
        case id = "id"
        case userAnswerId  = "userAnswerId"
    }
    
    // MARK: Properties
    public var answers: [Answer]?
    public var trueAnswerId: Int?
    public var question: String?
    public var userAnswerId:Int?
    public var trueAnswer: Bool?
    public var id: Int?
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        question = try container.decodeIfPresent(String.self, forKey: .question)
        answers = try container.decodeIfPresent([Answer].self, forKey: .answers)
        id =  try container.decodeIfPresent(Int.self, forKey: .id)
        trueAnswerId =  try container.decodeIfPresent(Int.self, forKey: .trueAnswerId)
        userAnswerId = try container.decodeIfPresent(Int.self, forKey: .userAnswerId)
    }
    
}
