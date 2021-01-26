//
//  CollectionViewQurstionCell.swift
//  MultiChoiceApp1
//
//  Created by Mohamed Shaat on 1/25/21.
//  Copyright © 2021 Com. All rights reserved.
//

import UIKit

protocol  QuestionCollectionViewCellDelegate {
    func didSelectAnswerFor(question: Question?)
}
class QuestionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var questionLabel: UILabel!
    var question:Question?
     var questionCollectionViewCellDelegate: QuestionCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // Initialization code
    }

}
extension QuestionCollectionViewCell: ConfigurableCell {
   
    func configure(data: Question) {
        self.questionLabel.text = data.question ?? ""
        self.question =  data
        self.tableView.reloadData()
    }
    
}

extension QuestionCollectionViewCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        question?.answers?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell")!
        let answer = question?.answers?[indexPath.row]
        if question?.trueAnswer == false && question?.userAnswerId == answer?.id {
            cell.backgroundColor = UIColor.red
        } else if question?.trueAnswer == true &&  question?.userAnswerId == answer?.id  {
            cell.backgroundColor = UIColor.green
        } else {
              cell.backgroundColor = UIColor.white
        }
        cell.selectionStyle = .none
        cell.textLabel?.text =  answer?.name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let answer = question?.answers?[indexPath.row]
        guard question?.trueAnswer == nil else {
            
            return
        }
        question?.userAnswerId = answer?.id
        questionCollectionViewCellDelegate?.didSelectAnswerFor(question: question)
    }
    
}
