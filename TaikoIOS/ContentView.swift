import SwiftUI

struct ContentView: View {
    @State private var calculator = Calculator()
    private let rows = [
        ["AC", "±", "%", "÷"],
        ["7", "8", "9", "×"],
        ["4", "5", "6", "−"],
        ["1", "2", "3", "+"],
        ["0", ".", "="]
    ]

    var body: some View {
        GeometryReader { geometry in
            let width = min(geometry.size.width - 32, 420)
            let keyWidth = (width - 36) / 4
            let keyHeight = max(30, min(keyWidth, (geometry.size.height - 150) / 5 - 12))

            VStack(spacing: 12) {
                HStack {
                    Text("Máy tính")
                        .font(.headline)
                        .foregroundStyle(.gray)
                    Spacer()
                }
                Spacer(minLength: 0)
                Text(calculator.display)
                    .font(.system(size: 72, weight: .light, design: .rounded))
                    .minimumScaleFactor(0.25)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.bottom, 12)
                    .accessibilityLabel("Kết quả")
                    .accessibilityValue(calculator.display)

                ForEach(rows, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { key in
                            Button {
                                calculator.press(key)
                            } label: {
                                Text(key)
                                    .font(.system(size: 30, weight: .medium, design: .rounded))
                                    .frame(width: key == "0" ? keyWidth * 2 + 12 : keyWidth,
                                           height: keyHeight)
                                    .background(color(for: key), in: Capsule())
                                    .foregroundStyle(["AC", "±", "%"].contains(key) ? Color.black : Color.white)
                            }
                            .buttonStyle(.plain)
                            .accessibilityLabel(label(for: key))
                        }
                    }
                }
            }
            .frame(width: width)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(Color.black.ignoresSafeArea())
        .preferredColorScheme(.dark)
    }

    private func color(for key: String) -> Color {
        if ["÷", "×", "−", "+", "="].contains(key) { return .orange }
        if ["AC", "±", "%"].contains(key) { return Color(white: 0.7) }
        return Color(white: 0.19)
    }

    private func label(for key: String) -> String {
        ["AC": "Xóa tất cả", "±": "Đổi dấu", "%": "Phần trăm",
         "÷": "Chia", "×": "Nhân", "−": "Trừ", "+": "Cộng",
         "=": "Bằng", ".": "Dấu thập phân"][key] ?? key
    }
}
