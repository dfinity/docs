# 翻訳スタイルガイド

Dfinity のドキュメントを日本語へ翻訳するためのスタイルガイドです。翻訳開始前に必ず読んでください。

もし、わからないことや質問等がある場合は [Discord](https://discord.gg/Q4XnFPstQn) の#🗒-ドキュメント翻訳 チャンネルで質問してください。

翻訳スタイルガイドの改訂案がある場合は、issues を立てるか、プルリクエストを送ってください。

## 文体

敬体（ですます調）を使って翻訳してください。

敬体の参考記事:

[ですます？である？文章の〈敬体〉と〈常体〉の使い分けを考える](https://blog.gururimichi.com/entry/2015/08/25/222628#:~:text=%E5%8F%A3%E8%AA%9E%E6%96%87%E4%BD%93%E3%81%AE%E4%B8%80%E3%80%82,%E7%94%A8%E3%81%84%E3%82%8B%E6%99%AE%E9%80%9A%E3%81%AE%E6%96%87%E7%AB%A0%E6%A7%98%E5%BC%8F%E3%80%82&text=%E8%BE%9E%E6%9B%B8%E3%82%92%E8%A6%8B%E3%82%8B%E3%81%A8%E3%80%81%E3%81%9D%E3%82%8C%E3%81%9E%E3%82%8C,%E6%9B%B8%E3%81%8D%E6%96%B9%E3%81%8C%E3%80%88%E6%95%AC%E4%BD%93%E3%80%89%E3%80%82)

## 半角と全角のスペース（これは努力目標で良いです）

なるべく半角と全角が切り替わる箇所にスペースをいれてください。

例外として、約物（特に句読点 。, 、）と直接隣接している場合は英単語と和文の間のスペースはいれないでください。

良い例:

```
スタイルシートをアプリケーションへ追加するために、`pages/_app.js`␣内で␣CSS␣ファイルをインポートしてみましょう。

パッケージを**活用**することで␣API␣エンドポイントに␣[CORS␣設定](https://developer.mozilla.org/ja/docs/Web/HTTP/CORS)をできます。

```

悪い例:

```
スタイルシートをアプリケーションへ追加するために、`pages/_app.js`内でCSSファイルをインポートしてみましょう。

パッケージを␣**活用**␣することで␣API␣エンドポイントに␣[CORS␣設定␣](https://developer.mozilla.org/ja/docs/Web/HTTP/CORS)␣をできます。
```

## 英語原文をコメントアウト

Dfinity 本家のドキュメントに更新があった場合に追従が容易なように、英語原文は文章全体を以下のようにコメントアウトしてください。
コメントアウトするときは、必ず`////`を前後の行に挿入するようにしてください。

元の文

```
[[for-first-timers]]
== For: First-Timers
The Internet Computer is a blockchain that runs at web speed with unbounded capacity.

As a crash course in blockchain history, Bitcoin created digital gold. Then, in the next step of the evolution, Ethereum developed smart contracts and pioneered DeFi and NFT use cases.

The Internet Computer is the third major blockchain innovation — a blockchain that scales smart contract computation, runs them at web speed, processes and stores data efficiently, and provides powerful software frameworks to developers. By making this possible, the Internet Computer enables the complete reimagination of how systems and apps operate.

Interested in learning more? Check out the following resources:

* link:https://www.youtube.com/watch?v=YWHTNr8RZHg&list=PLuhDt1vhGcrf4DgKZecU3ar_RA1cB0vUT&index=17&ab_channel=DFINITY[Primer to the Internet Computer], a high-level overview of the Internet Computer in under 10 minutes
* link:https://medium.com/dfinity[The Internet Computer Review], our blog covering updates for the Internet Computer
* link:https://thereboot.com/[The Reboot], our tech publication exploring issues with the current internet

Follow us on the official link:https://twitter.com/dfinity[DFINITY Twitter] for the latest updates.
```

翻訳後

```
[[for-first-timers]]
== はじめての方へ
Internet Computer は、ウェブスピードで動作するブロックチェーンであり、その容量に限界がありません。

ブロックチェーンの歴史を簡単に振り返りましょう。まず Bitcoin によりデジタルゴールドが生み出され、その次の進化として、 Ethereum がスマートコントラクトを開発し DeFi と NFT のユースケースを開拓しました。

Internet Computer は、ブロックチェーンの3つ目の大きなイノベーションであり、スマートコントラクトをスケーリングし、ウェブスピードで実行し、データを効率的に処理・保存し、強力なソフトウェアフレームワークを開発者に提供するブロックチェーンです。
これらを可能にすることで、 Internet Computer は、システムやアプリの運用方法を再定義します。

もっと詳しく知りたいですか？以下の資料をご覧ください。

* link:https://www.youtube.com/watch?v=YWHTNr8RZHg&list=PLuhDt1vhGcrf4DgKZecU3ar_RA1cB0vUT&index=17&ab_channel=DFINITY[Internet Computer入門(英語)]: Internet Computer の概要を10分で説明
* link:https://medium.com/dfinity[The Internet Computer Review]: Internet Computer の最新情報をお届けするブログ
* link:https://thereboot.com/[The Reboot]: 現在のインターネットの問題点を探る技術資料

公式 link:https://twitter.com/dfinity[DFINITY Twitter] で最新情報をお届けします。
////
[[for-first-timers]]
== For: First-Timers
The Internet Computer is a blockchain that runs at web speed with unbounded capacity.

As a crash course in blockchain history, Bitcoin created digital gold. Then, in the next step of the evolution, Ethereum developed smart contracts and pioneered DeFi and NFT use cases.

The Internet Computer is the third major blockchain innovation — a blockchain that scales smart contract computation, runs them at web speed, processes and stores data efficiently, and provides powerful software frameworks to developers. By making this possible, the Internet Computer enables the complete reimagination of how systems and apps operate.

Interested in learning more? Check out the following resources:

* link:https://www.youtube.com/watch?v=YWHTNr8RZHg&list=PLuhDt1vhGcrf4DgKZecU3ar_RA1cB0vUT&index=17&ab_channel=DFINITY[Primer to the Internet Computer], a high-level overview of the Internet Computer in under 10 minutes
* link:https://medium.com/dfinity[The Internet Computer Review], our blog covering updates for the Internet Computer
* link:https://thereboot.com/[The Reboot], our tech publication exploring issues with the current internet

Follow us on the official link:https://twitter.com/dfinity[DFINITY Twitter] for the latest updates.
////

```

なお、セクションタイトルの上で`[[]]`によって指定している

```
[[for-first-timers]]
```

は ID であり、訳さずにそのままにしてください。

## コードブロック

コードブロックのコメントも翻訳してください。コードブロック内にコードを追加したり、独自のコメントを入れないでください。

良い例:

```
npx create-next-app
# または
yarn create next-app
```

悪い例:

```
// Reactを作成するコマンド
npx create-next-app
# or
yarn create next-app

```

## 内部リンク

内部リンクがある場合は、別のページにリンクする文章は翻訳しても構いません。しかし URL は変えないでください。

良い例:

```
詳細は、[デプロイメントのドキュメント](/docs/deployment.md)をご覧ください。
```

悪い例:

```
詳細は、[デプロイメントのドキュメント](/docs/デプロイメント.md)をご覧ください。
```

## 用語集

用語の翻訳に一貫性を持たせるための用語集です。随時追加します。

| 用語             | 和訳              |
| ---------------- | ----------------- |
| xx documentation | xx のドキュメント |

## 原文のままの方がいいと判断された用語

原文のままの方がいい例として、以下があります。もし、翻訳するべきか分からない場合は Discord で質問してください。

- Dfinity で頻出の用語の場合
- 原文の方がニュアンスを伝えやすい場合
- 日本語に訳すものが見当たらない場合

| 用語              |
| ----------------- |
| Dfinity           |
| Internet Computer |
| Canister          |

## 参考

[GatsbyJS 翻訳スタイルガイド](https://github.com/gatsbyjs/gatsby-ja/blob/master/style-guide.md)
