import Observation
import SwiftUI

@Observable
class CounterViewModel {

    struct State: Equatable, Identifiable {
        var id = UUID()
        var count: Int = 0
    }

    var id: UUID { state.id }
    private(set) var state: State

    init(state: State = State()) {
        self.state = state
    }

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

    let viewModel: CounterViewModel

    var body: some View {
        VStack {
            HStack {
                Button("-") { viewModel.send(.decrement) }
                Text("\(viewModel.state.count)")
                Button("+") { viewModel.send(.increment) }
            }
        }
        .font(.largeTitle)
    }
}

#Preview {
    CounterViewModelView(viewModel: CounterViewModel())
}

