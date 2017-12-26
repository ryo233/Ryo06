//
//  QuestionViewController.swift
//  Ryo06
//
//  Created by Ryo on 2017/12/25.
//  Copyright © 2017年 Ryo. All rights reserved.
//

import UIKit
import GameplayKit
class QuestionViewController: UIViewController {
    let questions = [Question(description: "如果朋友生病住院，你探望時覺得送下面哪種花最適合？", choices: ["白色百合花", "紫色鬱金香", "黃色玫瑰花"]), Question(description: "和父母爭吵過後，你會主動道歉？", choices: ["不是", "不確定", "是的"]), Question(description: "給臥室裝窗簾，你會選擇下列哪種顏色的窗簾？", choices: ["粉色", "淺藍色", "米白色"]), Question(description: "你的知心好友有多少個？", choices: ["0個", "1~3個", "3個以上"]), Question(description: "以下幾種小動物，你最喜歡的是？", choices: ["金魚", "波斯貓", "鸚鵡"]), Question(description: "坐在火車上，有陌生人來搭訕，你會？", choices: ["冷漠以對，隨口應付", "不確定", "微笑面對，熱心回答"]), Question(description: "你獨自到郊外旅遊，突然迷路了，你會？", choices: ["報警", "向附近村民尋求幫忙", "向路人詢問出路"]), Question(description: "如果家裡只剩下三種吃的東西，飢餓時你會選擇哪一個？", choices: ["饅頭", "漢堡", "牛肉拉麵"]), Question(description: "你燒得一手好菜？", choices: ["是的", "不確定", "不是"]), Question(description: "如果有朋友，凌晨一點左右，打電話找你聊天，你會？", choices: ["關機", "接電話，坦白說自己想睡", "陪他聊天，想睡時再説"])]
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var answerLabels: [UILabel]!
    @IBAction func choiceButtonPress(_ sender: UIButton) {
        if sender.tag == 0{
            grade = grade + 1
        }else if sender.tag == 1{
            grade = grade + 2
        }else if sender.tag == 2{
            grade = grade + 3
        }
        nextQuestion()
    }
    func nextQuestion(){
        questionNumber = questionNumber + 1
        if questionNumber < questions.count {
            updateUI()
        }
    }
    var questionNumber = 0
    var grade = 0
    let number = GKShuffledDistribution(lowestValue: 0, highestValue: 9)
    func updateUI() {
        let question = questions[number.nextInt()]
        questionLabel.text = question.description
        countLabel.text = "\(questionNumber + 1)"
        var i = 0
        for label in answerLabels{
            label.text = question.choices[i]
            i = i + 1
        }
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if questionNumber < questions.count{
            return false
        }else{
            return true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToMultipleChoicePage(segue: UIStoryboardSegue) {
        questionNumber = 0
        grade = 0
        updateUI()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let controller = segue.destination as! ResultViewController
        controller.grade = grade
    }
    

}
