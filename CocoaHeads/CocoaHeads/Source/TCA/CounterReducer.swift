import ComposableArchitecture
import SwiftUI

@Reducer
struct CounterReducer {

    @ObservableState
    struct State: Equatable, Identifiable {
        var id = UUID()
        var count: Int = 0
    }

    enum Action: Equatable {
        case decrement
        case increment
    }

    var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case .decrement:
                state.count -= 1
                return .none

            case .increment:
                state.count += 1
                return .none
            }
        }
    }
}
struct CounterReducerView: View {

    let store: StoreOf<CounterReducer>

    var body: some View {
        VStack {
            HStack {
                Button("-") { store.send(.decrement) }
                Text("\(store.count)")
                Button("+") { store.send(.increment) }
            }
        }
        .font(.largeTitle)
    }
}

#Preview {
    CounterReducerView(
        store: Store(
            initialState: CounterReducer.State(),
            reducer: { CounterReducer() }
        )
    )
}

