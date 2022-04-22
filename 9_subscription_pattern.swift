//
//  9_subscription_pattern.swift
//  SwiftCombineTutorial
//
//  Created by paige shin on 2022/04/23.
//


import Combine
import UIKit

class MyClass {
    
    var anInt: Int = 0 {
        didSet {
            print("didSet \(anInt)")
        }
    }
    
}

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let obj = MyClass()
        let pub = (0...2).publisher
        let subscriber = Subscribers.Assign(object: obj, keyPath: \MyClass.anInt)

        let cancellable = pub
            .print("⌘")
            .receive(subscriber: subscriber)

    }
    
}

