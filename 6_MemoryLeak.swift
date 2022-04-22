//
//  6_MemoryLeak.swift
//  SwiftCombineTutorial
//
//  Created by paige shin on 2022/04/23.
//


import SwiftUI
import Combine
/// The assign(to:) operator manages the life cycle of the subscription, canceling the subscription automaticallyt when the Published instance deinitializes. Because of this, the assign(tp: ) operator doesn't return an AnyCancellable that you're responsible for like assign(to: on:) does.
/// No Memory Leaks


class MyModel: ObservableObject {
    
    @Published var lastUpdated = Date() {
        didSet {
            print("lastUpdated: \(lastUpdated)")
        }
    }
    
    var anyCancel: AnyCancellable?
    
    init() {
        Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
            .assign(to: &$lastUpdated)
        anyCancel = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
            .sink { [weak self] _ in
                print(self?.lastUpdated)
            }
         // inout &, access publisher of @Published
    }
    
    deinit {
        print("MyModel deinit")
    }
    
}

struct ClockView: View {
    
    @StateObject var clockModel = MyModel()
    
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter
    }
    
    var body: some View {
        Text(dateFormatter.string(from: clockModel.lastUpdated))
            .font(.largeTitle)
            .fixedSize()
            .padding(50)
    }
    
}

