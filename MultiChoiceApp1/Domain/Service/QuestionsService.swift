//
//  QuestionsService.swift
//  MultiChoiceApp1
//
//  Created by Mohamed Shaat on 1/25/21.
//  Copyright © 2021 Com. All rights reserved.
//

import Foundation

class QuestionsService {
    
    class func getQuestions(completion: @escaping ([Question], Error?) -> Void) {
        let questionsData = FileHelper.getData(name: "questions") as Data
        let decoder = JSONDecoder()
        do {
            let questions = try decoder.decode(QuestionsResponse.self, from: questionsData)
            completion(questions.questions ?? [], nil)
        } catch let error {
            completion([], error)
        }
    }
    
}
