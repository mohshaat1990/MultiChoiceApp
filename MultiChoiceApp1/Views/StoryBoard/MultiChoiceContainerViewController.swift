//
//  MultiChoiceContainerViewController.swift
//  MultiChoiceApp1
//
//  Created by Mohamed Shaat on 1/25/21.
//  Copyright © 2021 Com. All rights reserved.
//

import UIKit

class MultiChoiceContainerViewController: UIViewController {

    @IBOutlet weak var pageLabel: UILabel!
    @IBOutlet weak var multiChoicesCollectionView: UICollectionView!
    var currentPage = 1
    var numberOfPages = 20
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionViewCell()
        setCurrentPage(1)
    }
    
    func registerCollectionViewCell() {
        multiChoicesCollectionView.register(UINib(nibName: QuestionCollectionViewCell.getCellIdentifier(),
                                              bundle: nil),
                                        forCellWithReuseIdentifier: QuestionCollectionViewCell.getCellIdentifier())
    }
    
    func setCurrentPage(_ page: Int) {
        pageLabel.text = "\(page)/\(numberOfPages)"
    }
    
    @IBAction func nextAction(_ sender: Any) {
        currentPage = currentPage + 1
        if currentPage <= numberOfPages {
        multiChoicesCollectionView.setContentOffset(CGPoint(x:  currentPage * Int(view.frame.width), y: 0), animated: true)
            setCurrentPage(currentPage)
        } else {
            currentPage -= 1
        }
       
    }
    
    @IBAction func prevAction(_ sender: Any) {
        currentPage = currentPage - 1
        if currentPage >   0 {
            multiChoicesCollectionView.setContentOffset(CGPoint(x:  currentPage * Int(view.frame.width), y: 0), animated: true)
            setCurrentPage(currentPage)
            
        } else {
            currentPage += 1
        }
        
    }
    
}


extension MultiChoiceContainerViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfPages
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        for cell in multiChoicesCollectionView.visibleCells {
            let indexPath = multiChoicesCollectionView.indexPath(for: cell)
            setCurrentPage(indexPath?.row ?? 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuestionCollectionViewCell.getCellIdentifier(), for: indexPath) as? QuestionCollectionViewCell{
        
            cell.questionLabel.text = "fdzf"
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return 0
    }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

            let frameSize = collectionView.frame.size
            return CGSize(width: view.frame.width, height: frameSize.height)
        }

}
