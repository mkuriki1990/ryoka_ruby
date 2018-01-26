# 恵迪寮寮歌へのルビ振りプロジェクト
北海道大学恵迪寮寮歌集アプリに掲載している歌に
ルビを振った PDF を作成するための TeX テンプレートと生成スクリプト及び生成物. 

ルビを降った編集済みの TeX ファイルと PDF ファイルなどの成果物は worked ディレクトリ内にある. 

## 作業協力方法
* tex ディレクトリにある任意のファイルを howto.md を参考にしてフリガナを追記する. 
* pull request を送る. 

## 含まれるもの
* README.md : このファイル
* howto.md : ルビの付け方を説明したファイル
* tex/ : ルビを振る準備が完了した TeX ファイルを入れるディレクトリ
* worked/ : ルビを振る作業を行った TeX ファイル及び PDF ファイルを入れるディレクトリ
* kana/ : ふりがな含めた「ひらがな」だけの歌詞情報を抽出するスクリプト及びテキストファイルを入れるディレクトリ
* html/ : TeX トークンを html タグに変換するスクリプト及び作成した HTML ファイルを入れるディレクトリ
* sample/ : 都ぞ弥生を使った作成サンプル
* template_A5.tex : A5 サイズ用のページサイズテンプレート
* template_B6.tex : B6 サイズ用のページサイズテンプレート
* document_B6.tex : B6 サイズ用の本文のテンプレート
* mkruby.rb : Template の tex ファイルにルビ付きの txt ファイルを埋め込むスクリプト
* ryoka2ruby.sh : GNU sed を用いて漢字の周りに TeX トークン \ruby{漢字}{} を追加するスクリプト

### 参考
ルビをある程度自動で振るために形態素解析エンジン [MeCab](http://taku910.github.io/mecab/) 及び
そのための辞書ファイル [mecab-ipadic-NEologd](https://github.com/neologd/mecab-ipadic-neologd) を利用しています. 
