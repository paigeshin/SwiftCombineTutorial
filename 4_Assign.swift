
/////////////////// ARTICLE 3
/// assign(to: on:)


let myRange = (0...2)

class MyClass {
    var anInt: Int = 0 {
        didSet {
            print("anInt was set to: \(anInt)")
        }
    }
}

class ViewController: UIViewController {
    
    var subscription: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let obj = MyClass()
        
         subscription = myRange.publisher
            .map{ $0 * 10 }
            .assign(to: \.anInt, on: obj)
        
    }
    
}
 


class ViewController: UIViewController, UITextFieldDelegate {
    
    var label = UILabel()
    var textField: UITextField!
    
    var textMessage = CurrentValueSubject<String, Never>("Hello world")
    
    var subscriptions = Set<AnyCancellable>()
    
    override func loadView() {
        super.loadView()
        
        let view = UIView()
        view.backgroundColor = .white
        
        textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.text = textMessage.value
        view.addSubview(textField)
        
        label = UILabel()
        view.addSubview(label)
        // label.text = textMessage.value
        textMessage
            .compactMap { $0 }
            .map { "You Typed: \($0)" }
            .assign(to: \.text, on: label)
            .store(in: &subscriptions)
        
        self.view = view
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: margins.topAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            textField.leadingAnchor.constraint(equalTo: margins.trailingAnchor),
            label.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            label.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10)
        ])
        
        textField.addTarget(self, action: #selector(updateText), for: .editingChanged)
        
    }
    
    @objc func updateText() {
        self.textMessage.value = textField.text ?? ""
    }
    
}


