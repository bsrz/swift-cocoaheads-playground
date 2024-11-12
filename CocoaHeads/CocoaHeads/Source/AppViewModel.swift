import Observation
import SwiftUI

@Observable
class AppViewModel {

    struct State {
        var counterList: CounterListViewModel
    }

    private(set) var state = State(counterList: CounterListViewModel())
}

struct AppViewModelView: View {

    let viewModel: AppViewModel

    var body: some View {
        NavigationStack {
            CounterListViewModelView(viewModel: viewModel.state.counterList)
        }
        .font(.largeTitle)
    }
}

#Preview {
    AppViewModelView(viewModel: AppViewModel())
}
