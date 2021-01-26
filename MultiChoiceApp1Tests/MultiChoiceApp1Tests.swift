//
//  MultiChoiceApp1Tests.swift
//  MultiChoiceApp1Tests
//
//  Created by Mohamed Shaat on 1/26/21.
//  Copyright © 2021 Com. All rights reserved.
//

import XCTest
import SwiftUI
import RxSwift

class MultiChoiceApp1Tests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testScore() {
       let multiChoiceContinerViewModel = MultiChoiceContinerViewModel()
        let questionsData = FileHelper.getData(name: "questionsTest") as Data
               let decoder = JSONDecoder()
               do {
                   let questions = try decoder.decode(QuestionsResponse.self, from: questionsData)
                let disposeBag = DisposeBag()
            multiChoiceContinerViewModel.questionsArr.accept(questions.questions ?? [])
                        let promise = expectation(description: "testScore")
                multiChoiceContinerViewModel.score.subscribe(onNext: { [weak self] (score) in
                    if score != "" {
                       XCTAssertEqual(score, "Score: 0/2")
                        promise.fulfill()
                    }
                         
                      }).disposed(by: disposeBag)
                multiChoiceContinerViewModel.calculateScore()
                wait(for: [promise], timeout: 5.0)

               } catch let error {
                  XCTAssert(false)
               }
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
