//
//  ScoreCardViewController.swift
//  Routes
//
//  Created by Bernard Laughlin on 8/18/21.
//

import UIKit
import RealmSwift

protocol updateScoreDelegate {
    func updateScore(scores: [Int])
}

class ScoreCardViewController: UIViewController {
    

    let items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12","13", "14", "15", "16", "17", "18",]
    let realm = try! Realm()

    @IBOutlet weak var scoreStepper: UIStepper!
    @IBOutlet weak var basketLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var totalScore: UILabel!
    @IBOutlet weak var steppy: UIStepper!
    @IBOutlet var myCollectionView: BasketCollectionView!
    
    var delegate: updateScoreDelegate?
    var score: Int = 0
    var scores: [Int] = []
    
    var currentBucket: String = "0"
    var index: Int = 0


    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        self.score = scores[self.index]
        self.scoreLabel.text = String(score)
        self.totalScore.text = "Total: \(String(scores.reduce(0, +)))"
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goToMap))
        print("BUCKET IS,", currentBucket.suffix(2))
        self.index = Int(self.currentBucket.suffix(2))! - 1
        print("Int IS,", index)
        self.steppy.value = Double(scores[self.index])
        self.score = scores[self.index]
        self.basketLabel.text = self.currentBucket
        self.scoreLabel.text = String(score)
        self.totalScore.text = "Total: \(String(scores.reduce(0, +)))"
        print("SCORE is ", self.scores)
        self.myCollectionView.scoreArray = self.scores
        self.myCollectionView.viewController = self
    }
    

    
    func changeBuckets() {
        
    }
    
    @IBAction func stepperPressed(_ sender: UIStepper) {

        self.scoreLabel.text = Int(sender.value).description
        self.score = Int(sender.value)
        self.scores[index] = score
        self.myCollectionView.scoreArray = self.scores
        self.myCollectionView.reloadData()
        self.totalScore.text = "Total: \(String(scores.reduce(0, +)))"

    }
    
    func resetScores(){
        for index in 0...(scores.count - 1){
            scores[index] = 0
        }
        self.myCollectionView.scoreArray = scores
        self.myCollectionView.reloadData()
    }
    
    @IBAction func saveScoreButtonPressed(_ sender: UIButton) {

        let newScore = Score()
        newScore.date = Date()
        for score in self.scores {
            newScore.scores.append(score)
        }
        do {
            try realm.write {
                realm.add(newScore)
                resetScores()
                self.performSegue(withIdentifier: "showScoreHistory", sender: self)
            }
        } catch {
            print("Error saving scores, \(error)")
        }
    }
    
    @IBAction func goToSavedScores(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "showScoreHistory", sender: self)

//        let controller = ScoreTableViewController()
//        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func goToMap() {
//        let mapController = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        delegate?.updateScore(scores: self.scores)
        self.navigationController?.popViewController(animated: true)

//        navigationController?.pushViewController(mapController, animated: false)
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showScore" {
//            let secondVC: MapViewController = segue.destination as! MapViewController
//            secondVC.delegate = self
//        }
//    }
    
    
//    @objc func chooseTrails() {
//        let controller = RoutesViewController()
//        controller.delegate = self
//        navigationController?.pushViewController(controller, animated: true)
//    }

    
    
}

extension ScoreCardViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "basketCell", for: indexPath) as! CollectionViewCell
        cell.myLabel.text = self.items[indexPath.item]
        cell.myLabel.tintColor = .blue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
    
}

    
