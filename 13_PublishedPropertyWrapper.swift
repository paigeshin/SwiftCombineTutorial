//
//  13_PublishedPropertyWrapper.swift
//  SwiftCombineTutorial
//
//  Created by paige shin on 2022/04/23.
//

/*
 
 @Published property wrapper
 adds a Publisher to a property
 
 - use `@Published` for class properties not structures.
 
 */


import Combine
import Foundation
import UIKit

class ViewModel {
    
    // use @Published to create publisher
    // var userNames = CurrentValueSubject<[String], Never>(["Bill"])
    @Published var userNames: [String] = ["Bill"] // make it eaiser to create publisher

    
    let newUserNameEntered = PassthroughSubject<String, Never>()
    
    var subscriptions: Set<AnyCancellable> = []
    
    init() {
    
        $userNames.sink { value in
            /// Still Old One 
            print("receive value \(value) with \(self.userNames)") // receive value ["Bill", "Susan"] with ["Bill"]
            /// Documentation: When the property changes, publishing occurs in the property's `willSet` block, meaning subscribers receive the new value before it's actually set on the property,
        }.store(in: &subscriptions) // type erased
    
        newUserNameEntered.sink { value in
            self.userNames.append(value)
        }
        .store(in: &subscriptions)
    
    }
    
}

class ViewController: UIViewController {
    
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.newUserNameEntered.send("Susan")
        
    }
    
}

