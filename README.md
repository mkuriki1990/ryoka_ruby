# ryoka_ruby
北海道大学恵迪寮寮歌集アプリに掲載している歌に
ルビを振った PDF を作成するための TeX テンプレートと生成スクリプト. 

* README.md : このファイル
* howto.md : ルビの付け方を説明したファイル
* template_A5.tex : A5 サイズ用のページサイズテンプレート
* template_B6.tex : B6 サイズ用のページサイズテンプレート
* document_B6.tex : B6 サイズ用の本文のテンプレート
* mkruby.rb : Template の tex ファイルにルビ付きの txt ファイルを埋め込むスクリプト
* ryoka2ruby.sh : GNU sed を用いて漢字の周りに TeX トークン \ruby{漢字}{} を追加するスクリプト
