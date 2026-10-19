# TaikoIOS

Máy tính SwiftUI dành cho iPhone/iPad, iOS 16 trở lên. Hỗ trợ cộng, trừ, nhân, chia, số thập phân, đổi dấu, phần trăm (chia cho 100), AC và nhấn dấu bằng lặp lại. Phép tính nối tiếp thực hiện từ trái sang phải; chia cho 0 hiển thị “Lỗi”.

## Build và tải IPA bằng GitHub Actions

1. Đẩy dự án lên nhánh `main` của GitHub.
2. Mở tab **Actions**, chọn **Build iOS IPA (unsigned)**. Workflow tự chạy khi đẩy lên `main`; cũng có thể chọn **Run workflow** để chạy lại.
3. Chờ job `build` thành công. Trong phần **Artifacts** của lần chạy, tải `TaikoIOS-unsigned-ipa`.
4. Giải nén tệp tải về để lấy `TaikoIOS-unsigned.ipa`.

**IPA này chưa ký.** Cần ký bằng chứng chỉ và provisioning profile phù hợp trước khi cài lên thiết bị. Workflow không tạo IPA sẵn sàng cho TestFlight/App Store và không cần mật khẩu Apple ID hay chứng chỉ để build. Không đưa khóa ký hoặc mật khẩu vào repository.

Workflow dùng runner `macos-15` và Xcode mặc định của runner. GitHub cần cho phép Actions trên repository; thời gian chạy phụ thuộc hạn mức/tính phí của tài khoản. Artifact được giữ 14 ngày.

## Phát triển

- Sửa giao diện trong `TaikoIOS/ContentView.swift`.
- Trên Mac, mở `TaikoIOS.xcodeproj` bằng Xcode 16 trở lên, chọn scheme `TaikoIOS` và một simulator để chạy. Để cài trực tiếp lên thiết bị bằng Xcode, cấu hình Signing & Capabilities bằng tài khoản và bundle identifier của bạn.
- Bundle identifier mẫu: `com.example.TaikoIOS`; đổi sang identifier riêng trước khi cấu hình phân phối chính thức.
- Trên Linux/Codex, có thể chỉnh sửa mã và workflow. Build, chạy app và xác minh bằng iOS Simulator cần macOS/Xcode.

Không có phụ thuộc bên thứ ba. Workflow chạy 17 ca kiểm thử logic máy tính trước khi build. Workflow xác minh archive dành cho thiết bị, kiến trúc arm64 và cấu trúc ZIP của IPA; các bước này không thay thế kiểm thử giao diện trên thiết bị.
