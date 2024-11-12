import ComposableArchitecture
import SwiftUI

//@main
struct AppMVVM: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            AppViewModelView(viewModel: AppViewModel())
        }
    }
}

@main
struct AppTCA: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            AppReducerView(
                store: Store(
                    initialState: AppReducer.State(),
                    reducer: { AppReducer() }
                )
            )
        }
    }
}
