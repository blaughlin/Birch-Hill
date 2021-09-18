//
//  BasketCollectionView.swift
//  Routes
//
//  Created by Bernard Laughlin on 8/24/21.
//

import UIKit
import RealmSwift



class BasketCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    weak var viewController:ScoreCardViewController?


    var scoreArray: [Int] = []

    private var labels = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12","13", "14", "15", "16", "17", "18"]
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.dataSource = self
        self.delegate = self
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return labels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "basketCell", for: indexPath as IndexPath) as! BasketCollectionViewCell
        print("ScoreArray", scoreArray)
        if let vc = self.viewController {
            print("Current Bucket is: ", vc.index)
            cell.setLabel(label: String(scoreArray[indexPath.row]), bucket: labels[indexPath.row])
            cell.layer.cornerRadius = 10
            if vc.index == indexPath.row {
                print("YES WE HAVE A MATCH")
                cell.backgroundColor = .systemYellow
            } else {
                cell.backgroundColor = .systemGray6
                cell.alpha = 0.5
            }
    //        cell.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        }
        return cell


    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfSections section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: (collectionView.frame.size.width/5)-5,
            height: (collectionView.frame.size.width/5)-5
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("Selected section \(indexPath.section) and row \(indexPath.row)")
//        if let cell = collectionView.cellForItem(at: indexPath) as? BasketCollectionViewCell {
//            cell.backgroundColor = .green }
        if let vc = self.viewController {
            // make use of the reference to the view controller here
            print("Chaning Text")
            vc.basketLabel.text = "Basket " + String(indexPath.row + 1)
            vc.index = indexPath.row
            vc.score = vc.scores[vc.index]
            vc.scoreLabel.text = String(vc.score)
            vc.steppy.value = Double(vc.scores[vc.index])
            collectionView.reloadData()
        }
    }

}


extension BasketCollectionView: updateScoreDelegate {
    func updateScore(scores: [Int]) {
        self.scoreArray = scores
    }
}
