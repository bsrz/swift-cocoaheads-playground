import ComposableArchitecture
import SwiftUI

@Reducer
struct AppReducer {

    @ObservableState
    struct State: Equatable {
        var counterList = CounterListReducer.State()
    }

    enum Action {
        case counterList(CounterListReducer.Action)
    }

    var body: some ReducerOf<Self> {
        Scope(state: \.counterList, action: \.counterList) { CounterListReducer() }
    }
}

struct AppReducerView: View {

    let store: StoreOf<AppReducer>

    var body: some View {
        NavigationStack {
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
