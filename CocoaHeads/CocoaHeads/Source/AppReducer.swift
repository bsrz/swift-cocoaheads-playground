import ComposableArchitecture
import SwiftUI

@Reducer
struct AppReducer {

    @ObservableState
    struct State: Equatable {
        var counterList = CounterListReducer.State()
        var total: Int = 0
    }

    enum Action {
        case counterList(CounterListReducer.Action)
    }

    var body: some ReducerOf<Self> {
        Scope(state: \.counterList, action: \.counterList) { CounterListReducer() }
        Reduce<State, Action> { state, action in
            switch action {
            case .counterList(.counters(.element(id: _, action: .decrement))):
                state.total -= 1
                return .none

            case .counterList(.counters(.element(id: _, action: .increment))):
                state.total += 1
                return .none

            default:
                return .none
            }
        }
    }
}

struct AppReducerView: View {

    let store: StoreOf<AppReducer>

    var body: some View {
        NavigationStack {
            Text("total: \(store.total)")
            CounterListReducerView(store: store.scope(state: \.counterList, action: \.counterList))
        }
        .font(.largeTitle)
    }
}

#Preview {
    AppReducerView(
        store: Store(
            initialState: AppReducer.State(),
            reducer: { AppReducer() }
        )
    )
}
