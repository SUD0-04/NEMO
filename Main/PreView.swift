import SwiftUI
import AVFoundation
import Photos

struct PreView: View {
    @Binding var isActive: Bool
    @State private var page: Int = 0
    @State private var hasRequestedCameraPermission = false // Track if permission requested
    @State private var hasRequestedPhotoPermission = false // Track if photo permission requested

    let totalPages = 4
    private let indicatorBottomPadding: CGFloat = 90

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            TabView(selection: $page) {
                // First page replaced with custom content
                VStack(spacing: 24) {
                    Spacer()
                    Text("환영합니다.")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                    Text("정방형의 세계속으로")
                        .font(.title3.weight(.medium))
                        .foregroundColor(.white.opacity(0.8))
                    Spacer()
                }
                .tag(0)
                // Other pages unchanged
                ForEach(1..<totalPages, id: \.self) { index in
                    VStack(spacing: 24) {
                        Image(systemName: "photo.on.rectangle.angled")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 120)
                            .foregroundColor(.white)
                        Text(previewTitle(for: index))
                            .font(.title.bold())
                            .foregroundColor(.white)
                        Text(previewDescription(for: index))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white.opacity(0.7))
                    }
                    .padding(.horizontal, 30)
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
                    Text(page == totalPages - 1 ? "시작하기" : (page == 0 ? "촬영하기" : "다음"))
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

    // 각 페이지별 타이틀/설명 예시 (적절히 수정 가능)
    func previewTitle(for index: Int) -> String {
        switch index {
        case 1: return "필름처럼 저장"
        case 2: return "갤러리로 관리"
        case 3: return "감성 필터 지원"
        default: return ""
        }
    }

    func previewDescription(for index: Int) -> String {
        switch index {
        case 1: return "촬영한 사진을 필름처럼 한눈에 저장하고 관리할 수 있습니다."
        case 2: return "나만의 갤러리에서 추억을 관리하세요."
        case 3: return "다양한 감성 필터로 색다른 느낌을 더해보세요."
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
