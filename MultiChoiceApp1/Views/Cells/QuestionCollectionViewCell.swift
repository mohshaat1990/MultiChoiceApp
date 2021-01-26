//
//  CollectionViewQurstionCell.swift
//  MultiChoiceApp1
//
//  Created by Mohamed Shaat on 1/25/21.
//  Copyright © 2021 Com. All rights reserved.
//

import UIKit

class QuestionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var questionLabel: UILabel!
    var answers = [Answer]()
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // Initialization code
    }

}
extension QuestionCollectionViewCell: ConfigurableCell {
   
    func configure(data: Question) {
    
    }
    
}

extension QuestionCollectionViewCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        answers.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = answers[indexPath.row].name
        return cell
    }
    
}
