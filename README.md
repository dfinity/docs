<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->

[![All Contributors](https://img.shields.io/badge/all_contributors-1-orange.svg?style=flat-square)](#contributors)

<!-- ALL-CONTRIBUTORS-BADGE:END -->

# （非公式） Dfinity 　ドキュメント翻訳プロジェクト

## 翻訳手順

翻訳の状況は、[翻訳の概要と進捗状況](https://github.com/Japan-DfinityInfoHub/docs/issues/17)の issues を確認してください。

### 手順 1: 翻訳を始める準備の準備

Dfinity のドキュメントは [AsciiDoc](https://azure.microsoft.com/ja-jp/products/visual-studio-code/) によって書かれており、[Antora](https://antora.org/) を用いてビルドされています。
ローカル環境でドキュメントをビルドして確認できるように、以下の手順で Antora をインストールします。

Antora のインストールには [Node](https://nodejs.org/ja/) が必要です。

Windows 10 の場合には [WSL2 上にインストール](https://docs.microsoft.com/ja-jp/windows/dev-environment/javascript/nodejs-on-wsl)することをお勧めします。

Mac OS の場合には [Homebrew でインストール](https://blog.proglus.jp/2004/)するのが良いと思います。

Node のインストールができたら、[Antora のインストール](https://docs.antora.org/antora/2.3/install/install-antora/)を行います。
ここではグローバル環境にインストールする手順を説明します。

```
$ npm i -g @antora/cli@2.3 @antora/site-generator-default@2.3
```

以下のコマンドでインストールできていることを確認します。

```
$ antora -v
```

`2.3.x` などのバージョン名が表示されれば OK です。

### 手順 2: 翻訳を始める準備

まずは、このリポジトリを右上から Fork してください。

そして、リポジトリをクローンします。`your` には、あなたの GitHub のユーザーネームを入れてください。

```
$ git clone https://github.com/your/docs
$ cd docs
```

翻訳作業を行うためのブランチを作成します。ここでは、例として `introduction/pages/welcome.adoc` を翻訳するためのブランチを作成します。

```
$ git checkout -b introduction/pages/welcome.adoc
```

これで、翻訳を始める準備は完了です。エディタを使って、翻訳箇所のファイルを編集します。

### 手順 3: 翻訳

[スタイルガイド](https://github.com/Japan-DfinityInfoHub/docs/blob/main/styleguide.md)に目を通してください。
わからないことがあれば [Discord](https://discord.gg/ewAxzfTURX) の#ドキュメント翻訳チャネルで質問してください。

エディタとしては [VSCode](https://azure.microsoft.com/ja-jp/products/visual-studio-code/) を推奨します。
[AsciiDoc の拡張機能](https://marketplace.visualstudio.com/items?itemName=asciidoctor.asciidoctor-vscode)を入れると少し幸せになれるかもしれません。

### 手順 4: 翻訳内容の確認

翻訳した文章を確認するために、手順 1 で導入した Antora を用いてローカルビルドします。

```
$ antora local-antora-playbook.yml
```

のコマンドを叩くと、ビルドが実行されます。
ビルド後、`build/site/docs` 以下の html ファイルを直接開きます。

```
open build/site/docs/introduction/welcome.html
```

ブラウザが開き、翻訳が反映されていることが確認できます。

### 手順 5: 翻訳内容のプルリクを出す

翻訳が終わったら、ローカルリポジトリにコミットしたあと、自分のリモートリポジトリにプッシュします。
なるべく[１つのコミットにまとめて](https://dev.classmethod.jp/articles/git-rebase-fixup/)いただければありがたいですが、難しければそのままでも OK です。

```
$ git add modules/introduction/pages/welcome.adoc
$ git commit -m "translated: introduction/pages/welcome.adoc"
$ git push origin introduction/pages/welcome.adoc
```

最後に、Github から[プルリクを出します](https://qiita.com/samurai_runner/items/7442521bce2d6ac9330b)。
このとき、出し先が Japan-DfinityInfoHub/docs になるようにします。
間違えて本家の dfinity/docs に出してしまわないように気をつけてください。

以上です！メンテナーがレビューをして問題なければマージされます。

## Contributors ✨

Special thanks to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://github.com/hoosan"><img src="https://avatars.githubusercontent.com/u/40290137?v=4" width="100px;" alt=""/><br /><sub><b>hoosan</b></sub></a></td>
  </tr>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

# Write code for the Internet Computer

You can get started right away by downloading the Internet Computer Software Development Kit (SDK) and cloning an existing sample project or by exploring the documentation. Check out the links below to begin building smart contract canisters to run on the Internet Computer:

- [_Get the SDK_](https://sdk.dfinity.org/docs/download.html) Download the SDK for the Internet Computer.
- [_Quick Start_](https://sdk.dfinity.org/docs/quickstart/quickstart-intro.html) Deploy your first app on the Internet Computer.
- [_Examples Repository_](https://github.com/dfinity/examples) Explore on your own in the examples repository.
- [_Language Guide_](https://sdk.dfinity.org/docs/language-guide/motoko.html) Explore the Motoko programming language.
- [_Videos_](https://sdk.dfinity.org/docs/videos-tutorials.html) Watch the _Building Applications for the Internet Computer: Fundamentals_ video series.

# Contributing to the documentation

The [Internet Computer blockchain](https://dfinity.org/developers) is removing the limitations from smart contract software with a network that scales its capacity with demand and serves interactive web content directly to end users.
If you are interested in learning more about the project, you can connect with other developers in the community through the [Developer Forum](https://forum.dfinity.org/) and follow us on social media for information about upcoming events and new developments.

If you would like to contribute to the documentation, see our [CONTRIBUTING](.github/CONTRIBUTING.md) and [CODE OF CONDUCT](.github/CODE_OF_CONDUCT.md) to get started.
