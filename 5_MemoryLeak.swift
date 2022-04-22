//import UIKit
//import Combine
//
//
///////////////////// ARTICLE 4 - Memory Leak
//

struct User {
    let name: String
    let id: Int
}

// one way
class ViewModel {

    var user = CurrentValueSubject<User, Never>(User(name: "Bob", id: 1))
    var userID: Int = 1 {
        didSet {
            print("userId changed \(userID)")
        }
    }

    var subscriptions = Set<AnyCancellable>()

    init() {
        user
            .map(\.id)
//            .assign(to: \.userID, on: self)
            .sink(receiveValue: { [weak self] value in
                self?.userID = value
            })
            .store(in: &subscriptions)
    }

    deinit {
        print("deinit")
    }

}

// second way
class ViewModel {

    var user = CurrentValueSubject<User, Never>(User(name: "Bob", id: 1))
    @Published var userID: Int = 1 {
        didSet {
            print("userId changed \(userID)")
        }
    }

    init() {
        user
            .map(\.id)
            .assign(to: &$userID)
    }

    deinit {
        print("deinit")
    }

}


class ViewController: UIViewController {

    var viewModel: ViewModel? = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel?.user.send(User(name: "Billy", id: 2))
        print(viewModel?.userID) // 2
        viewModel = nil // deinit is called

        
    }

}


