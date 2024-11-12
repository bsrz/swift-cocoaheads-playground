import Observation
import SwiftUI

@Observable
class CounterListViewModel {

    struct State {
        var counters: [CounterViewModel] = []
    }

    private(set) var state: State

    init(state: State = State()) {
        self.state = state
    }

    enum Action {
        case add
        case remove(UUID)
    }

    func send(_ action: Action) {
        switch action {
        case .add:
            state.counters.append(CounterViewModel())

        case .remove(let uuid):
            state.counters.removeAll { $0.id == uuid }
        }
    }
}

struct CounterListViewModelView: View {

    let viewModel: CounterListViewModel

    var body: some View {
        List {
            ForEach(viewModel.state.counters, id: \.id) { childViewModel in
                HStack {
                    Spacer()
                    CounterViewModelView(viewModel: childViewModel)
                    Spacer()
                    Button {
                        viewModel.send(.remove(childViewModel.id))
                    } label: {
                        Image(systemName: "trash")
                    }
                }
            }
        }
        .buttonStyle(.plain)
        .font(.largeTitle)
        .navigationTitle("MVVM Counter List")
        .toolbar {
            ToolbarItem {
                Button {
                    viewModel.send(.add)
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        CounterListViewModelView(viewModel: CounterListViewModel())
    }
}

