import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "music.note")
                .font(.system(size: 64))
                .foregroundStyle(.indigo)
                .accessibilityHidden(true)

            Text("TaikoIOS")
                .font(.largeTitle.bold())

            Text("Ứng dụng đầu tiên của bạn đã sẵn sàng để phát triển.")
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
        }
        .padding(32)
    }
}
