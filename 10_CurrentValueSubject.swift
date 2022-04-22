//
//  10_CurrentValueSubject.swift
//  SwiftCombineTutorial
//
//  Created by paige shin on 2022/04/23.
//

import Foundation
import Combine
import UIKit

// Subject - Publisher that you can continously send new values down

// CurrentValueSubject
// Used like a var with a Publisher stream attached


struct User {
    var id: Int
    var name: String
}

let currentUserId = CurrentValueSubject<Int, Never>(1000)
let userNames = CurrentValueSubject<[String], Never>(["Bob, Susan", "Luise"])
let currentUser = CurrentValueSubject<User, Never>(User(id: 1, name: "Bob"))

class ViewController: UIViewController {
    
    var subscriontions: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // get the value for currentUserID
        print("currentUserId \(currentUserId.value)") // currentUserId 1000

        // subscribe to Subject
        userNames.sink {
            print("completion \($0)")
        } receiveValue: { value in
            print("Receive Value \(value)")
        }
        .store(in: &subscriontions)
        
        // passing down new values with Subject
        currentUserId.send(1) // Receive Value 1
        currentUserId.send(2) // Receive Value 2
        
        // sending completion finished with Subject
        currentUserId.send(completion: .finished) // Completion Finished
        currentUserId.send(3) // not occuring

    }
    
}


