import SwiftUI
import Combine

@main
struct NEMOApp: App {
    @StateObject private var launchState = LaunchState()

    var body: some Scene {
        WindowGroup {
            switch launchState.phase {
            case .launch:
                LaunchPhaseView(launchState: launchState)
            case .preview:
                PreviewPhaseView(launchState: launchState)
            case .main:
                MainView()
            }
        }
    }
}

struct LaunchPhaseView: View {
    @ObservedObject var launchState: LaunchState
    @State private var launchViewIsActive = true

    var body: some View {
        LaunchView(isActive: $launchViewIsActive)
            .onChange(of: launchViewIsActive, { oldValue, newValue in
                if !newValue {
                    launchState.phase = .preview
                }
            })
    }
}

struct PreviewPhaseView: View {
    @ObservedObject var launchState: LaunchState
    @State private var previewViewIsActive = true

    var body: some View {
        PreView(isActive: $previewViewIsActive)
            .onChange(of: previewViewIsActive, { oldValue, newValue in
                if !newValue {
                    launchState.phase = .main
                }
            })
    }
}

@MainActor
class LaunchState: ObservableObject {
    enum LaunchPhase {
        case launch, preview, main
    }
    @Published var phase: LaunchPhase = .launch
}

