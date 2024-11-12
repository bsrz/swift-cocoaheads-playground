import Observation
import SwiftUI

@Observable
class AppViewModel {

    struct State {
        var counterList: CounterListViewModel

        var total: Int {
            counterList.state.counters.map(\.state.count).reduce(into: 0) { runningTotal, element in
                runningTotal += element
            }
        }
    }

    private(set) var state = State(counterList: CounterListViewModel())
}

struct AppViewModelView: View {

    let viewModel: AppViewModel

    var body: some View {
        NavigationStack {
            VStack {
                Text("total: \(viewModel.state.total)")
                CounterListViewModelView(viewModel: viewModel.state.counterList)
            }
        }
        .font(.largeTitle)
    }
}

#Preview {
    AppViewModelView(viewModel: AppViewModel())
}
