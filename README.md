# QiitaArticleSearchApp

52歳未経験男性が0からカリキュラム内で作成したオリジナルアプリ

# DEMO
TOPページの[新着一覧]から[記事の検索]  
![gif](https://user-images.githubusercontent.com/67039960/86338511-63dc1600-bc8d-11ea-8174-c05076b9f4c7.gif)


[検索記事]から[お気に入り登録]まで  
![gif (1)](https://user-images.githubusercontent.com/67039960/86338670-8e2dd380-bc8d-11ea-9492-f946626ce672.gif)


# Features
QiitaのJSONデータ取得  
パースして一覧表示  
Webページ画面遷移  
検索機能  
検索記事一覧画面遷移  
検索記事Webページ画面遷移  
検索記事お気に入り保存機能  
お気に入り記事一覧から削除編集機能  
Firebaseサービスを利用したリモートプッシュ通知機能  

現在、AppStoreへリリースへ向けガイドライン4.2と格闘中。

# Requirement

platform :ios9.0　以上  
'Alamofire', '~> 4.9.1'   

詳細はProfileを参照ください  
https://github.com/programmingjapan/QiitaArticleSearchApp/blob/master/Podfile


# Note
下記環境で動作確認済です。  
- Xcode バージョン11.5(11E608c)  
- Swiftライブラリ依存管理 Cocoapods バージョン 1.9.2  

一度目のビルド中に "no such module 'alamofire"のエラーメッセージが表示場合がありますが、ビルドが成功するとエラーは解消され、問題なくシミュレータが起動されます。

