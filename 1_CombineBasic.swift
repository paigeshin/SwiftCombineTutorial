import UIKit
import Combine

///////////////// ARTICLE 1

/*
 ==== Subscription ===

How to create a subscription?
 -> sink { completion: , receiveValue: }
 -> assign(to: on:)
 -> assign
 
 How to stop a data stream?
 -> subscription.cancel()
 -> subscription = nil
 -> error will cancel subscription with failure
 
 sequence pubisher, one-shot publisher
 -> finish automatically when done
 
 ---- Multithreading in combine ----
 -> receive on
 -> subscribe to
 -> where is multithreading built in? - urlsession
 
 */

/***
 1. Basic Publisher Subscriber Example with Operator
 ***/


let data = [1, 2, 3, 4, 5].publisher
    .sink { i in
        print(i)
    }

let timer = Timer.publish(every: 0.5, on: .main, in: .common)
let text = "".publisher
let notification = NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)

let currentValue = CurrentValueSubject<String, Never>("currentValue")
let passThrough = PassthroughSubject<String, Never>()
let just = Just(3)

class ViewController: UIViewController {

    var subscriptions: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        [1, 2, 3, 4, 5].publisher
            .sink { i in
                print(i)
            }
            .store(in: &subscriptions)

        "".publisher
            .sink { text in
                print(text)
            }
            .store(in: &subscriptions)
    }

}



class ViewController: UIViewController {

    var subscription: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()
        subscription =
        
        Timer.publish(every: 0.5, on: .main, in: .common)
            .autoconnect()   Start Firing
            .throttle(for: .seconds(5), scheduler: DispatchQueue.main, latest: true)
            .scan(0, { lastResult, publisher in
                return lastResult + 1
            })   Operator
            .removeDuplicates()   Operator, Don't allow the duplicate value
            .filter( {count in
                return count < 6
            })   Operator, if count is larger than 6, this value will never get passed
            .sink { completion in
                print("data stream completion \(completion)")
            } receiveValue: { timestamp in
                print("receive value: \(timestamp)")
            }

        // One Way To Cancel
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            self.subscription?.cancel()
            print("Canceled...")
        }

        // Second Way To Cancel
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            self.subscription = nil
            print("Canceled...")
        }
    }


}
 

