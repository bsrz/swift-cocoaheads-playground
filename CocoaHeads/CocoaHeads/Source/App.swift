import SwiftUI

@main
struct App: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            AppViewModelView(viewModel: AppViewModel())
        }
    }
}
