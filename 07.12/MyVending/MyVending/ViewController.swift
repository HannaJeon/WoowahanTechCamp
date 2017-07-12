//
//  ViewController.swift
//  MyVending
//
//  Created by woowabrothers on 2017. 7. 12..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var vendingMachine = VendingMachine()
    let pizza1 = Pizza(restaurant: "피자헛", capacity: 50, price: 20000, foodName: "콤비네이션피자", extraCheese: true)
    let pizza2 = Pizza(restaurant: "피자헛", capacity: 30, price: 20000, foodName: "페퍼로니피자", extraCheese: false)
    let pizza3 = Pizza(restaurant: "미스터피자", capacity: 80, price: 20000, foodName: "콤비네이션피자", extraCheese: false)
    let pizza4 = Pizza(restaurant: "미스터피자", capacity: 40, price: 20000, foodName: "페퍼로니피자", extraCheese: true)
    
    @IBOutlet weak var pizzaHutLabel: UILabel!
    @IBOutlet var foodNameLabels: [UILabel]!
    @IBOutlet var capacityLabels: [UILabel]!
    @IBOutlet var addButtons: [UIButton]!
    
    var buttonTag = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButtons.forEach{ $0.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside) }
        NotificationCenter.default.addObserver(self, selector: #selector(setLabel), name: NSNotification.Name(rawValue: "addProduct"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addButtonAction(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            vendingMachine.addProduct(food: pizza1)
        case 2:
            vendingMachine.addProduct(food: pizza2)
        default:
            print("unknown")
        }
        buttonTag = sender.tag-1
    }
    
    func setLabel(_ notification: Notification) {
        let stock = notification.userInfo as! [String:[String:Int]]
        
        for brand in stock {
            if String(describing: brand.key) == pizzaHutLabel.text! {
                let val = brand.value[foodNameLabels[buttonTag].text!]
                capacityLabels[buttonTag].text = String(describing: val!)
            }
        }
    }
    
    func setInstance(vendingMachine: VendingMachine) {
        self.vendingMachine = vendingMachine
    }
    
    func addStock() {
        vendingMachine.addProduct(food: pizza1)
        vendingMachine.addProduct(food: pizza2)
        vendingMachine.addProduct(food: pizza3)
        vendingMachine.addProduct(food: pizza4)
    }

}

