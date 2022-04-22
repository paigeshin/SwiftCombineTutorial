/***
 - Two Publishers are used together
 - Handle Error
 ***/

let calendar = Calendar.current
let endDate = calendar.date(byAdding: .second, value: 2, to: Date())!
func throwAtEndDate(foodItem: String, date: Date) throws -> String {
    if date < endDate {
        return "\(foodItem) at \(date)"
    }
    throw MyError()
}




struct MyError: Error {}

class ViewController: UIViewController {
    
    let foodbank = ["apple", "bread", "orange", "milk"].publisher
    var subscription: AnyCancellable?
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        subscription = foodbank.zip(timer)
            .tryMap({ foodItem, timestamp in
                try throwAtEndDate(foodItem: foodItem, date: timestamp)
            })
            .sink(receiveCompletion: { completion in
                print("completion: \(completion)")
                switch completion {
                case .finished:
                    print("completion: finished")
                case .failure(let error):
                    print("completion with failure: \(error.localizedDescription)")
                    
                }
            }, receiveValue: { result in
                print("receive item: \(result)")
            })
        
    }
    
}
 
