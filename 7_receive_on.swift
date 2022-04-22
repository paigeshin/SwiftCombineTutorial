//
//  7_receive_on.swift
//  SwiftCombineTutorial
//
//  Created by paige shin on 2022/04/23.
//

import Foundation
import Combine
import UIKit


class ViewController: UIViewController {
    
    let intSubject = PassthroughSubject<Int, Never>()
    var subscription: AnyCancellable?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subscription = intSubject
        
        
            .sink { value in
                print("receive value \(value)")
                /// Checking Thread
                print(Thread.current)
            }
        
        intSubject.send(1)
        
        DispatchQueue.global().async {
            self.intSubject.send(2)
        }
        
    }
    
}




/// Specify Thread
class ViewController: UIViewController {
    
    let intSubject = PassthroughSubject<Int, Never>()
    var subscription: Set<AnyCancellable> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        intSubject
            .map { $0 }
            .receive(on: DispatchQueue.main)
            .sink { value in
                print("receive value \(value)")
                /// Checking Thread
                print(Thread.current)
            }
            .store(in: &subscription)
        
        intSubject.send(1)
        
        DispatchQueue.global().async {
            self.intSubject.send(2)
        }
        
    }
    
}

