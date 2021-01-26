//
//  Answers.swift
//
//  Created by Mohamed Shaat on 1/25/21
//  Copyright (c) . All rights reserved.
//

import Foundation

public struct Answer: Codable {
  // MARK: Properties
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
    
  public var id: Int?
  public var name: String?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
    }

}
