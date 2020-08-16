# README

## もっと、お金に、楽しさを！

<img width="1440" alt="householdExpenses_zaimhome" src="https://user-images.githubusercontent.com/62828568/90330631-466acd80-dfe9-11ea-9550-6bcc24eb35e4.png">

![ruby](https://img.shields.io/badge/-Ruby-red)
![rspec](https://img.shields.io/badge/-RSpec-rgb(220,20,60))

## アプリケーション名

_HouseholdExp_  
（既存の家計簿アプリに、個人のメールアドレス/パスワードでログインして、希望月毎の情報を抽出/表示するツール）  
※Household Expenses ＝ 家計簿

## 概要

Web版 Zaimをスクレイピングして、家計簿の入力履歴を表示するコマンドラインツールです。

## 工夫した点

- デザイン
  - 見やすくするため、日ごとの履歴を、縦長の形式で表示しています。
  - キャラクターの顔文字を用いる事でユーザーが親しみを持ちやすくしています。 
- 機能
  - 「メールアドレス/パスワード/対象月」を、1行入力するだけで、ツールが自動で判断して情報を表示します。
  - RSpecでテストを行い、条件分岐に漏れがないか検討しています。
  - ヘッドレスブラウザを採用し、ブラウザが立ち上がらないようにしています。
  
#### フローダイアグラム
<img width="485" alt="householdExpenses_conditional branch" src="https://user-images.githubusercontent.com/62828568/90330204-eb83a700-dfe5-11ea-86a2-07f28ed50ce2.png">

#### テスト結果
<img width="622" alt="householdExpenses_rspec" src="https://user-images.githubusercontent.com/62828568/90330334-f8ed6100-dfe6-11ea-8391-be91683824cc.png">

## 動作確認方法の説明書

```
# リポジトリのクローンを行ってください。
$ git clone https://github.com/RYgithub1/householdExp.git

# 対象のディレクトリに遷移してインストールします。
$ cd householdExp
$ bundle install

# コマンドラインでインプットデータ入力（メールアドレス パスワード 年月）します。
$ bundle exec exe/householdExp zaim mail password yyyymm
(例)$ bundle exec exe/householdExp zaim householdExpenses316@gmail.com expense3 202008

- テスト用アカウント
  - メールアドレス：householdExpenses316@gmail.com
  - パスワード   ：expense3
  - データ入力月：202008
```

## 内容

#### 記録有り(202008)
<img width="890" alt="householdExpenses_202008v1" src="https://user-images.githubusercontent.com/62828568/90330451-b8daae00-dfe7-11ea-80dc-7163834d1e08.png">
<img width="977" alt="householdExpenses_202008v2" src="https://user-images.githubusercontent.com/62828568/90330466-dad43080-dfe7-11ea-85c8-4ff29bf572d0.png">

#### ブラウザ画面--記録有り(202008)
<img width="1062" alt="householdExpenses_zaim08" src="https://user-images.githubusercontent.com/62828568/90330584-d0666680-dfe8-11ea-80e0-f12f529df1fe.png">

#### 記録なし(202007)
<img width="882" alt="householdExpenses_202007" src="https://user-images.githubusercontent.com/62828568/90330517-2edf1500-dfe8-11ea-9bfd-691e85df6cfc.png">

#### ブラウザ画面--記録なし(202007)
<img width="1070" alt="householdExpenses_zaim07" src="https://user-images.githubusercontent.com/62828568/90330592-df4d1900-dfe8-11ea-93c1-b40ef86c46ca.png">

## 開発環境

- Verasion
  - Ruby（2.5.1）
  - RSpec（3.9）
- License
  - [MIT License]

## 開発者

- 製作者：R.O.
