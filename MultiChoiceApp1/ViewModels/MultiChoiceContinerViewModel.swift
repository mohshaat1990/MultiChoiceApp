//
//  MultiChoiceContinerViewModel.swift
//  MultiChoiceApp1
//
//  Created by Mohamed Shaat on 1/25/21.
//  Copyright © 2021 Com. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol MultiChoiceContinerViewModelDelegate {
    var questionsArr: BehaviorRelay<[Question]> { set get }
    var score:BehaviorRelay<String> { set get }
    func getQuestions()
    func didSelectAnswerFor(question: Question?)
}

class MultiChoiceContinerViewModel: MultiChoiceContinerViewModelDelegate {
    var score =  BehaviorRelay<String>(value: "")
    var questionsArr =  BehaviorRelay<[Question]>(value: [])
    
    func didSelectAnswerFor(question: Question?)  {
        var questionsArrValues = questionsArr.value
        questionsArrValues[(question?.id!)! - 1].trueAnswer = checkAnswer(question: question)
        questionsArrValues[(question?.id!)! - 1].userAnswerId = question?.userAnswerId
        self.questionsArr.accept(questionsArrValues)
        calculateScore()
    }
    
    private func checkAnswer(question: Question?) -> Bool {
      return question?.userAnswerId == question?.trueAnswerId
    }
    
     func getQuestions() {
        QuestionsService.getQuestions(){ [weak self] (questions, error) in
            
            if error == nil {
                self?.questionsArr.accept(questions)
            }
        }
    }
    
     func calculateScore()  {
        let validQuestions  = questionsArr.value.filter {$0.trueAnswer == true}
        self.score.accept("Score: \(validQuestions.count)/\(questionsArr.value.count)")
    }
}
