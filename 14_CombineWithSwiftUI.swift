//
//  14_CombineWithSwiftuI.swift
//  SwiftCombineTutorial
//
//  Created by paige shin on 2022/04/23.
//

import Combine
import SwiftUI

class ViewModel: ObservableObject {
    
    @Published var userNames = ["Bill", "Susan", "Bob"]
    let userNamesSubject = CurrentValueSubject<[String], Never>(["Bill", "Susan", "Bob"])
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        // subscribe to publisher
        $userNames
            .sink { values in
                print("usernames - last \(self.userNames) - value received \(values)")
            }
            .store(in: &subscriptions)
    
        userNamesSubject.sink { values in
            print("usernamesSubject - last \(self.userNamesSubject.value) - value received - \(values)")
            // All Views Will Be Updated
            self.objectWillChange.send()
        }
        .store(in: &subscriptions)
    }
    
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewModel = ViewModel()

        viewModel.objectWillChange.send()
        //viewModel.objectWillChange.send()

        let anyCancellable: AnyCancellable = viewModel.objectWillChange.sink { _ in
            print("objectWillChange was sent")
        }

        viewModel.userNames.append("Karen")
    }
    
}
