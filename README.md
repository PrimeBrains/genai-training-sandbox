# genai-training-sandbox

生成AI新人研修（エンジニア職向け・半日）のハンズオン用サンドボックスです。
小さな経費精算サービス（Java / Spring Boot / Gradle）と、GitHub Issues によるタスク管理の練習場が入っています。

## この研修でやること

「生成AI = Webチャット」だと思っていませんか？
Claude Code のようなエージェント型AIは、Issue を読み、ブランチを切り、調査し、コードを直し、PR を出すところまで自走します。
このリポジトリで、それをあなたの手で体験します。

## 事前セットアップ（研修当日までに）

1. **JDK 21** をインストール（例: [Temurin 21](https://adoptium.net/)）
2. **Git** と **GitHub CLI (gh)** をインストールし、`gh auth login` で認証
3. **Claude Code** をインストール: https://claude.com/claude-code
4. 動作確認:

```bash
git clone <このリポジトリのURL>
cd genai-training-sandbox
./gradlew test   # 初回は依存ダウンロードで数分かかります。テストが「落ちる」のは仕様です（研修の課題）
```

`BUILD FAILED`（テスト失敗）まで進めばセットアップ成功です。当日はここから始めます。

## プロジェクト構成

```
src/main/java/com/example/training/   # 経費精算サービス（バグあり）
src/test/java/com/example/training/   # 単体テスト（一部が落ちる状態）
docs/research/                        # 調査レポートの置き場
scripts/                              # 運営用スクリプト（受講者は使いません）
CLAUDE.md                             # Claude Code への作業ルール
```

## 進め方

このリポジトリの Issues にタスクが積んであります。Claude Code に「次にやるべきタスクを提案して」と話しかけるところから始めてください。
作業ルールは `CLAUDE.md` にあり、Claude Code はそれを読んで Issue 駆動で動きます。

## 研修後も

このリポジトリは持ち帰りOKです。自由に Issue を足して、Claude Code との開発を続けてみてください。
