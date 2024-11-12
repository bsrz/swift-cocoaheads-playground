import Observation
import SwiftUI

@Observable
class CounterViewModel {

    struct State: Equatable {
        var count: Int = 0
    }

    private(set) var state = State()

    enum Action {
        case decrement
        case increment
    }

    func send(_ action: Action) {
        switch action {
        case .decrement:
            state.count -= 1

        case .increment:
            state.count += 1
        }
    }
}

struct CounterViewModelView: View {

    @State var viewModel = CounterViewModel()

    var body: some View {
        VStack {
            HStack {
                Button("-") { viewModel.send(.decrement) }
                Text("\(viewModel.state.count)")
                Button("+") { viewModel.send(.increment) }
            }
        }
    }
}

#Preview {
    CounterViewModelView()
}

