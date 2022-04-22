/////////////////// ARTICLE 2

/***
 Publishers that will pass a limited number of values
 ***/

class ViewController: UIViewController {
    
    let foodbank = ["apple", "bread", "orange", "milk"].publisher
    var subscription: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscription = foodbank.sink(receiveCompletion: { completion in
            print("completion: \(completion)")
        }, receiveValue: { foodItem in
            print("receive item \(foodItem)")
        })
    }
    
}



