//
//  12_Current_VS_Passthrough.swift
//  SwiftCombineTutorial
//
//  Created by paige shin on 2022/04/23.
//

import Combine
import UIKit


class ViewModel {
    
    let userNames = CurrentValueSubject<[String], Never>(["Bill"])
    let newUserNameEntered = PassthroughSubject<String, Never>()
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        // create publisher stream that updates user names whenever a newUserNameEntered has a new value
        
        newUserNameEntered.sink { _ in
            
        } receiveValue: { value in
//            self.userNames.value.append(value)
//            print(self.userNames.value)
            self.userNames.send(self.userNames.value + [value])
        }
        .store(in: &subscriptions)

        
        userNames.sink { users in
            print("user names changed to \(users)")
        }
        .store(in: &subscriptions)
        
    }
    
    
}


class ViewController: UIViewController {
    
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.newUserNameEntered.send("Hello")
        
    }
    
}

