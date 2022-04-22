//
//  8_URLSession.swift
//  SwiftCombineTutorial
//
//  Created by paige shin on 2022/04/23.
//


import UIKit
import Combine

class ViewController: UIViewController {
    
    var subscriptions: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        URLSession.shared.dataTaskPublisher(for: URL(string: "https://jsonplaceholder.typicode.com/")!)
            .map { result in
                print(Thread.current.isMainThread)
            }
//            .subscribe(on: DispatchQueue.main) // publisher on main => this doesn't work with dataTaskPublisher
            .receive(on: DispatchQueue.main) // subscriber on main
            .sink { _ in
        
            } receiveValue: { value in
                print(value)
                print(Thread.current.isMainThread)
            }
            .store(in: &subscriptions)

    }
    
}

