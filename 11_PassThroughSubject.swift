//
//  11_PassThroughSubject.swift
//  SwiftCombineTutorial
//
//  Created by paige shin on 2022/04/23.
//

import Combine
import UIKit

// Subject - Publisher that you can continuosly send new values down

// PassthroughSubject
// use for starting action/process, equivalent to func
// It doesn't hold a value


let newUserNameEntered = PassthroughSubject<String, Never>()

class ViewController: UIViewController {
    
    let newUserNameEntered = PassthroughSubject<String, Never>()
    var subscriptions: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get the value for newUserNameEntered
        // does not hold a value newUserNameEntered.value
        
        // subscribe to Subject
        newUserNameEntered
            .sink {
                print($0)
            } receiveValue: { value in
                print("receive value \(value)")
            }.store(in: &subscriptions)

        // passing down new values with Subject
        newUserNameEntered.send("Bob")
        
        // sending completion finished with Subject
        newUserNameEntered.send(completion: .finished)
        newUserNameEntered.send("New") // Not getting passed
        
    }
    
}

