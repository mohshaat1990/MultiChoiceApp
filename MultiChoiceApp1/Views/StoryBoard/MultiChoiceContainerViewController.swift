//
//  MultiChoiceContainerViewController.swift
//  MultiChoiceApp1
//
//  Created by Mohamed Shaat on 1/25/21.
//  Copyright © 2021 Com. All rights reserved.
//

import UIKit
import RxSwift

class MultiChoiceContainerViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var pageLabel: UILabel!
    @IBOutlet weak var multiChoicesCollectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    private var multiChoiceContinerViewModel: MultiChoiceContinerViewModelDelegate =  MultiChoiceContinerViewModel()
     let disposeBag = DisposeBag()
    var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionViewCell()
        setupData()
        multiChoiceContinerViewModel.getQuestions()
        setCurrentPage(currentPage)
        enableButton(enable: false)
    }
    
    func setupData() {
        multiChoiceContinerViewModel.score.bind(to: scoreLabel.rx.text)
        multiChoiceContinerViewModel.questionsArr.bind(to: multiChoicesCollectionView.rx.items(cellIdentifier: QuestionCollectionViewCell.getCellIdentifier(),
                                                                                                   cellType: QuestionCollectionViewCell.self))
                  { [weak self] row, questionData, cell in
                    cell.questionCollectionViewCellDelegate = self
                   cell.configure(data: questionData)
                   
                  }.disposed(by: disposeBag)
    }
    
    func registerCollectionViewCell() {
        multiChoicesCollectionView.register(UINib(nibName: QuestionCollectionViewCell.getCellIdentifier(),
                                              bundle: nil),
                                        forCellWithReuseIdentifier: QuestionCollectionViewCell.getCellIdentifier())
    }
    
    func enableButton(enable: Bool) {
        nextButton.isUserInteractionEnabled = enable
         nextButton.alpha  = enable  ? 1.0 : 0.5
    }
    
    func setCurrentPage(_ page: Int) {
        pageLabel.text = "\(page)/\(multiChoiceContinerViewModel.questionsArr.value.count)"
    }
    
    @IBAction func nextAction(_ sender: Any) {
        currentPage = currentPage + 1
        enableButton(enable: false)
        if currentPage <= multiChoiceContinerViewModel.questionsArr.value.count {
          multiChoicesCollectionView.setContentOffset(CGPoint(x:  (currentPage - 1) * Int(view.frame.width), y: 0), animated: true)
            setCurrentPage(currentPage)
        } else {
            currentPage -= 1
        }
       
    }
    
    @IBAction func prevAction(_ sender: Any) {
        currentPage = currentPage - 1
        enableButton(enable: true)
        if currentPage >   0 {
            multiChoicesCollectionView.setContentOffset(CGPoint(x:  (currentPage - 1) * Int(view.frame.width), y: 0), animated: true)
            setCurrentPage(currentPage)
            
        } else {
            currentPage += 1
        }
        
    }
    
}


extension MultiChoiceContainerViewController: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in multiChoicesCollectionView.visibleCells {
            let indexPath = multiChoicesCollectionView.indexPath(for: cell)
            setCurrentPage(indexPath?.row ?? 0)
        }
    }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

            let frameSize = collectionView.frame.size
            return CGSize(width: view.frame.width, height: frameSize.height)
        }

}

extension MultiChoiceContainerViewController: QuestionCollectionViewCellDelegate {
    func didSelectAnswerFor(question: Question?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            self?.enableButton(enable: true)
            self?.multiChoiceContinerViewModel.didSelectAnswerFor(question: question)
       }
    }
}
