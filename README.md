# ryoka_ruby
北海道大学恵迪寮寮歌集アプリに掲載している歌に
ルビを振った PDF を作成するための TeX テンプレートと生成スクリプト. 

* template_A5.tex : A5 サイズ用のテンプレート. 
* template_B6.tex : B6 サイズ用のテンプレート. 
* mkruby.rb : Templete の tex ファイルにルビ付きの txt ファイルを埋め込むスクリプト. 
* ryoka2ruby.sh : GNU sed を用いて漢字の周りに TeX トークン \ruby{漢字}{} を追加するスクリプト. 
