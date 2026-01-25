import SwiftUI

struct LaunchView: View {
    @Binding var isActive: Bool
    @State private var opacity: Double = 1.0

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 8) {
                Text("kaan")
                    .font(.custom("Futura", size: 80))
                    .fontWeight(.bold)
                    .tracking(28)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                Text("나만의 정방형 사진기")
                    .font(.system(size: 15))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
            }
        }
        .opacity(opacity)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                withAnimation(.easeOut(duration: 1.0)) {
                    opacity = 0.0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    isActive = false
                }
            }
        }
    }
}

#Preview {
    LaunchView(isActive: .constant(true))
}
