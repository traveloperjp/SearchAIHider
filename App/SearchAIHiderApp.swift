import SwiftUI
#if os(macOS)
import AppKit
#endif

@main
struct SearchAIHiderApp: App {
    #if os(macOS)
    @NSApplicationDelegateAdaptor(SetupAppDelegate.self) private var appDelegate
    #endif

    var body: some Scene {
        WindowGroup {
            SetupView()
                #if os(macOS)
                .frame(minWidth: 420, minHeight: 450)
                #endif
        }
        #if os(macOS)
        .defaultSize(width: 820, height: 535)
        #endif
    }
}

#if os(macOS)
private final class SetupAppDelegate: NSObject, NSApplicationDelegate {
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        true
    }
}
#endif

private struct SetupView: View {
    @State private var showsAnswer = false
    private let accent = Color(red: 0.08, green: 0.43, blue: 0.46)

    private var settingsPath: String {
        #if os(macOS)
        return "Safari → 設定 → 機能拡張"
        #else
        if #available(iOS 18, *) {
            return "設定 → アプリ → Safari → 機能拡張"
        }
        return "設定 → Safari → 機能拡張"
        #endif
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                VStack(alignment: .leading, spacing: 9) {
                    Label("Search AI Hider", systemImage: "magnifyingglass")
                        .font(.headline)
                        .foregroundStyle(.tint)
                    Text("Safari の AI 回答枠を非表示に")
                        .font(.largeTitle.bold())
                        .accessibilityAddTraits(.isHeader)
                    Text("Google と Bing の検索結果で、AI 回答枠を隠します。")
                        .foregroundStyle(.secondary)
                }
                .fixedSize(horizontal: false, vertical: true)

                ViewThatFits(in: .horizontal) {
                    HStack(alignment: .top, spacing: 16) {
                        preview.frame(minWidth: 315)
                        setupGuide.frame(minWidth: 290)
                    }
                    VStack(alignment: .leading, spacing: 14) {
                        preview
                        setupGuide
                    }
                }

                Label("フィルタリングは端末内で行われます。", systemImage: "lock.shield")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: 740, alignment: .leading)
            .padding(.horizontal, 22)
            .padding(.vertical, 28)
            .frame(maxWidth: .infinity)
        }
        .background(accent.opacity(0.06).ignoresSafeArea())
        .tint(accent)
    }

    private var preview: some View {
        card {
            Label("検索結果のプレビュー", systemImage: "text.magnifyingglass")
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
            Toggle("プレビューで AI 回答を表示", isOn: $showsAnswer)
                .font(.subheadline)
                .toggleStyle(.switch)

            VStack(alignment: .leading, spacing: 8) {
                Label("空はなぜ青い？", systemImage: "magnifyingglass")
                    .font(.subheadline.weight(.semibold))
                Divider()
                if showsAnswer {
                    Label("AI 回答の例", systemImage: "sparkles")
                        .font(.subheadline)
                        .padding(8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(accent.opacity(0.14), in: RoundedRectangle(cornerRadius: 8))
                }
                Text("空が青く見えるしくみ")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.tint)
                Text("通常の検索結果の例")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(11)
            .background(Color.primary.opacity(0.045), in: RoundedRectangle(cornerRadius: 10))

            Text("これは表示例です。拡張機能のオン・オフは Safari の設定で変更します。")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    private var setupGuide: some View {
        card {
            Label("Safari で有効にする", systemImage: "safari")
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
            step(1, settingsPath)
            step(2, "「Search AI Hider」をオンにします。")
            step(3, "Safari で Google または Bing の検索結果を再読み込みします。")
        }
    }

    private func card<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 11, content: content)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .background(.background, in: RoundedRectangle(cornerRadius: 16))
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(Color.primary.opacity(0.08))
                    .allowsHitTesting(false)
            }
    }

    private func step(_ number: Int, _ instruction: String) -> some View {
        HStack(alignment: .top, spacing: 9) {
            Text(number.formatted())
                .font(.caption.bold())
                .foregroundStyle(.tint)
                .frame(width: 21, height: 21)
                .background(accent.opacity(0.12), in: Circle())
            Text(instruction)
                .font(.subheadline)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}
