//
//  StockManagerViewController.swift
//  JuiceMaker
//
//  Created by yun on 2021/06/17.
//

import UIKit

class StockManagerViewController: UIViewController, LabelUpdatable {
    // MARK: - Properties
    private let stepperMaximumValue: Double = 30
    private let fruitStore: FruitStore = FruitStore.shared
    
    // MARK: - IBOutlets
    @IBOutlet weak var strawberryStepper: UIStepper!
    @IBOutlet weak var bananaStepper: UIStepper!
    @IBOutlet weak var pineappleStepper: UIStepper!
    @IBOutlet weak var kiwiStepper: UIStepper!
    @IBOutlet weak var mangoStepper: UIStepper!
    
    @IBOutlet weak var stawberryStockLabel: UILabel!
    @IBOutlet weak var bananaStockLabel: UILabel!
    @IBOutlet weak var pineappleStockLabel: UILabel!
    @IBOutlet weak var kiwiStockLabel: UILabel!
    @IBOutlet weak var mangoStockLabel: UILabel!
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initStepperMaximumValue()
        initStepperWithTag()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLabelsText(of: fruitStore)
        initStepperValue()
    }
    
    // MARK: - Methods
    func initStepperWithTag() {
        strawberryStepper.tag = Fruit.strawberry.fruitTag
        bananaStepper.tag = Fruit.banana.fruitTag
        pineappleStepper.tag = Fruit.pineapple.fruitTag
        kiwiStepper.tag = Fruit.kiwi.fruitTag
        mangoStepper.tag = Fruit.mango.fruitTag
    }
    
    private func initStepperMaximumValue() {
        strawberryStepper.maximumValue = stepperMaximumValue
        bananaStepper.maximumValue =
            stepperMaximumValue
        pineappleStepper.maximumValue = stepperMaximumValue
        kiwiStepper.maximumValue = stepperMaximumValue
        mangoStepper.maximumValue = stepperMaximumValue
    }
    
    func getLabel(on fruit: Fruit) -> UILabel {
        switch fruit {
            case .strawberry: return stawberryStockLabel
            case .banana: return bananaStockLabel
            case .pineapple: return pineappleStockLabel
            case .kiwi: return kiwiStockLabel
            case .mango: return mangoStockLabel
        }
    }
    
    private func initStepperValue() {
        do {
            strawberryStepper.value = try fruitStore.getDoubleValueOfStocks(of: .strawberry)
            bananaStepper.value = try fruitStore.getDoubleValueOfStocks(of: .banana)
            pineappleStepper.value = try fruitStore.getDoubleValueOfStocks(of: .pineapple)
            kiwiStepper.value = try fruitStore.getDoubleValueOfStocks(of: .kiwi)
            mangoStepper.value = try fruitStore.getDoubleValueOfStocks(of: .mango)
        } catch {
            fatalError("알 수 없는 오류")
        }
    }
    
    @IBAction func touchUpDismissButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func updateLabelAndStock(of fruitName: Fruit, to senderValue: Double) {
        let changedValue = Int(senderValue)
        let label = getLabel(on: fruitName)
        
        guard changedValue >= 0 else {
            return
        }
        
        fruitStore.updateStock(of: fruitName, count: UInt(changedValue))
        label.text = changedValue.description
    }
    
    // MARK: - IBActions
    @IBAction func changeFruitStock(_ sender: UIStepper) {
        guard let fruitName = Fruit(rawValue: sender.tag) else {
            return
        }
        updateLabelAndStock(of: fruitName, to: sender.value)
    }
}