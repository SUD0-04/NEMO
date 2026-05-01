import SwiftUI
import AVFoundation
import Photos
import Combine

struct PreView: View {
    @Binding var isActive: Bool
    @State private var page: Int = 0
    @State private var welcomeTextIndex: Int = 0
    @State private var hasRequestedCameraPermission = false // Track if permission requested
    @State private var hasRequestedPhotoPermission = false // Track if photo permission requested

    let totalPages = 4
    private let indicatorBottomPadding: CGFloat = 90
    private let welcomeTexts = [
        "환영합니다.",
        "Welcome",
        "ようこそ",
        "Bienvenue",
        "Willkommen",
        "Bienvenido",
        "Benvenuto",
        "Bem-vindo",
        "欢迎",
        "Добро пожаловать"
    ]
    private let welcomeTimer = Timer.publish(every: 3.5, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            TabView(selection: $page) {
                // First page replaced with custom content
                VStack(spacing: 24) {
                    Spacer()
                    Text(welcomeTexts[welcomeTextIndex])
                        .font(.system(size: 75, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .lineLimit(1)
                        .minimumScaleFactor(0.35)
                        .padding(.horizontal, 24)
                        .contentTransition(.opacity)
                        .animation(.easeInOut(duration: 0.65), value: welcomeTextIndex)
                    Text("정방형의 세계속으로")
                        .font(.title3.weight(.medium))
                        .foregroundColor(.white.opacity(0.8))
                    Spacer()
                }
                .tag(0)
                .onReceive(welcomeTimer) { _ in
                    guard page == 0 else { return }
                    welcomeTextIndex = (welcomeTextIndex + 1) % welcomeTexts.count
                }
                // Other pages unchanged
                ForEach(1..<totalPages, id: \.self) { index in
                    previewPage(for: index)
                    .tag(index)
                }
            }
            .gesture(DragGesture().onChanged { _ in }.onEnded { _ in })
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .padding(.bottom, indicatorBottomPadding)
            
            VStack {
                Spacer()
                Button(action: {
                    if page == 0 {
                        // First page: request camera permission, then advance on completion
                        let status = AVCaptureDevice.authorizationStatus(for: .video)
                        if status == .notDetermined && !hasRequestedCameraPermission {
                            hasRequestedCameraPermission = true
                            AVCaptureDevice.requestAccess(for: .video) { _ in
                                DispatchQueue.main.async {
                                    requestPhotoPermissionIfNeeded {
                                        withAnimation { page = min(page + 1, totalPages - 1) }
                                    }
                                }
                            }
                        } else {
                            requestPhotoPermissionIfNeeded {
                                withAnimation { page = min(page + 1, totalPages - 1) }
                            }
                        }
                    } else if page < totalPages - 1 {
                        // Middle pages: advance to next page
                        withAnimation { page += 1 }
                    } else {
                        // Last page: dismiss
                        isActive = false
                    }
                }) {
                    Text(page == totalPages - 1 ? "촬영하기" : (page == 0 ? "시작하기" : "다음"))
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 14)
                        .glassEffect(.regular.interactive(), in: .capsule)
                        .overlay(
                            Capsule()
                                .stroke(Color.white.opacity(0.35), lineWidth: 0.75)
                        )
                }
                .padding(.bottom, 24)
            }
        }
    }

    @ViewBuilder
    private func previewPage(for index: Int) -> some View {
        if index == 2 {
            VStack(spacing: 24) {
                Image("FilmsforPRE")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .frame(height: 300, alignment: .top)
                    .scaleEffect(1.45)
                    .padding(.top, 28)
                    .padding(.horizontal, -48)
                    .zIndex(0)

                Spacer(minLength: 28)

                previewText(for: index)
                    .zIndex(1)

                Spacer(minLength: 80)
            }
            .padding(.horizontal, 30)
            .clipped()
        } else {
            VStack(spacing: 24) {
                Image(systemName: "photo.on.rectangle.angled")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                    .foregroundColor(.white)
                previewText(for: index)
            }
            .padding(.horizontal, 30)
        }
    }

    private func previewText(for index: Int) -> some View {
        VStack(spacing: 24) {
            Text(previewTitle(for: index))
                .font(.title.bold())
                .foregroundColor(.white)
            Text(previewDescription(for: index))
                .multilineTextAlignment(.center)
                .foregroundColor(.white.opacity(0.7))
        }
    }

    // 각 페이지별 타이틀/설명 예시 (적절히 수정 가능)
    func previewTitle(for index: Int) -> String {
        switch index {
        case 1: return "정방형의 매력"
        case 2: return "순간을 기억하는 필름"
        case 3: return "AMUSEI (Beta)"
        default: return ""
        }
    }

    func previewDescription(for index: Int) -> String {
        switch index {
        case 1: return "예술은 제약에서 살고, 자유에서 죽는다.\n - 레오나르도 다빈치 - "
        case 2: return "사진은 찍는 순간 완성되는 것이 아니라,\n현상되는 순간 다시 태어난다.\n - 인셀 아담스 - "
        case 3: return "텅 빈 여백을 채워주는 손안의 작명가\n(Apple Intelligence를 통해 구현될 예정)"
        default: return ""
        }
    }

    private func requestPhotoPermissionIfNeeded(_ completion: @escaping () -> Void) {
        let status = PHPhotoLibrary.authorizationStatus(for: .addOnly)
        if status == .notDetermined && !hasRequestedPhotoPermission {
            hasRequestedPhotoPermission = true
            PHPhotoLibrary.requestAuthorization(for: .addOnly) { _ in
                DispatchQueue.main.async {
                    completion()
                }
            }
        } else {
            completion()
        }
    }
}

#Preview {
    PreView(isActive: .constant(true))
}
