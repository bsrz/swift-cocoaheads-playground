import ComposableArchitecture
import SwiftUI

@Reducer
struct CounterListReducer {

    @ObservableState
    struct State: Equatable {
        var counters: IdentifiedArrayOf<CounterReducer.State> = []
    }

    enum Action {
        case add
        case remove(UUID)
        case counters(IdentifiedActionOf<CounterReducer>)
    }

    @Dependency(\.uuid) var uuid

    var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case .add:
                state.counters.append(CounterReducer.State(id: uuid()))
                return .none

            case .remove(let id):
                state.counters.remove(id: id)
                return .none

            default:
                return .none
            }
        }
        .forEach(\.counters, action: \.counters) { CounterReducer() }
    }
}

struct CounterListReducerView: View {

    let store: StoreOf<CounterListReducer>

    var body: some View {
        List {
            ForEach(store.scope(state: \.counters, action: \.counters)) { childStore in
                HStack {
                    Spacer()
                    CounterReducerView(store: childStore)
                    Spacer()
                    Button {
                        store.send(.remove(childStore.state.id))
                    } label: {
                        Image(systemName: "trash")
                    }
                }
            }
        }
        .buttonStyle(.plain)
        .font(.largeTitle)
        .navigationTitle("TCA Counter List")
        .toolbar {
            ToolbarItem {
                Button {
                    store.send(.add)
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        CounterListReducerView(
            store: Store(
                initialState: CounterListReducer.State(),
                reducer: { CounterListReducer() }
            )
        )
    }
}

