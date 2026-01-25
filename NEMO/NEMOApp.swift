import SwiftUI
import Combine

@main
struct NEMOApp: App {
    @StateObject private var launchState = LaunchState()
    var body: some Scene {
        WindowGroup {
            if launchState.isActive {
                LaunchView(isActive: $launchState.isActive)
            } else {
                MainView()
            }
        }
    }
}

@MainActor
class LaunchState: ObservableObject {
    @Published var isActive = true
}

