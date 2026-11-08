# Search AI Hider

Google の「AI による概要」と Bing の Copilot 回答枠を非表示にする、Mac・iPhone・iPad 向け Safari コンテンツブロッカーです。

Search AI Hider hides AI answer panels on Google and Bing search results in Safari on macOS, iOS, and iPadOS.

- 対応環境は macOS 13.3 かつ Safari 16.4 以降、iOS・iPadOS 16.4 以降です。
- 対象は `google.com`、`google.co.jp`、`bing.com`（`www` を含む）の `/search?…` です。
- Safari が端末内で `Blocker/blockerList.json` の `css-display-none` を適用します。検索サービス側の AI 回答の生成や取得は続きます。
- Mac の設定案内は Dock に表示されません。案内を閉じても Safari の拡張は使えます。

[有効化とサポート](SUPPORT.md) · [プライバシーポリシー](PRIVACY.md) · [リリース](https://github.com/traveloperjp/SearchAIHider/releases)

## ソースからビルド

1. `SearchAIHider.xcodeproj` を Xcode で開きます。
2. `Signing.xcconfig` の `APP_BUNDLE_ID` を自分の Apple Developer チームで使用できる値に変更します。拡張の ID には `.blocker` が付きます。
3. **Search AI Hider (Mac)** または **Search AI Hider (iPhone and iPad)** のスキームを選びます。アプリとコンテンツブロッカーの両ターゲットで同じ開発チームを設定します。
4. Mac または接続した iPhone・iPad を実行先に選び、Xcode から起動します。Safari の機能拡張設定で **Search AI Hider** をオンにします。

Xcode プロジェクトは同梱しています。プロジェクトの構成を変更する場合は `project.yml` を編集し、XcodeGen で再生成できます。

## フィルター

Google は回答枠を含む `#rcnt > .M8OgIe` と回答要素 `#eKIzJc` などを対象にします。Bing は `#copans_container` などを含む回答カードを対象にします。CSS は検索サービスの DOM に依存するため、表示が変わった場合はルールの更新が必要になることがあります。

Mac の Safari で、Google の「お」と Bing の「why is the sky blue」の検索結果を確認し、AI 回答枠が非表示になり、通常リンクが表示されることを検証しました。

フィルター調査の参考にした資料は [Stevo’s AI Blocklist](https://github.com/Stevoisiak/Stevos-AI-Blocklist) と [AI Overview Hider for Google](https://github.com/insin/ai-overview-hider-for-google) です。ライセンスは [MIT](LICENSE) です。
