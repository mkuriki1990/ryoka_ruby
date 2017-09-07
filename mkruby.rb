#!/usr/bin/ruby
# 寮歌の歌詞 txt ファイルの漢字に TeX トークン 
# \ruby{漢字}{} をつけるスクリプト
require 'csv'

templateName = 'document_B6.tex'

# 収録曲一覧の読み込み
csvList = CSV.read('./src/ryoka_list.csv', headers:true)
csvList.each{|data|
    srcName = "#{data["ファイル名"]}".gsub!(/.*\//, '')
    title = "#{data["曲名"]}"
    # year = "#{data["年"]}"
    year = "#{data[0]}" # 0 番目要素の "年" だけヘッダ名で取得できない
    name1 = "#{data["作歌"]}"
    name2 = "#{data["作曲"]}"

    # src ディレクトリにある txt ファイルの読み込み
    source = File.open("./src/#{srcName}", 'r')
    src = source.read()

    # 歌詞のヘッダとフッタを除外する
    lilycs = "" # 歌詞を入れる文字列変数
    buffer = "" # 一行を一時保存する文字列変数
    footer = "" # フッタを一時保存する文字列変数
    isHeaderEnd = false # ヘッダ判断用のフラグ
    isFooterBegin = false # ヘッダ判断用のフラグ

    src.lines{|line|
        # 最初の空行まではヘッダとして除外
        if !isHeaderEnd
            if line == "\n"
                isHeaderEnd = true
            end
            next
        end

        # ヘッダ以外で半角 '(' から始まる行からはフッタ
        # フッタにルビはいらないので, 後から付け足すため保存
        if line =~ /^\(/ && !isFooterBegin
            # 括弧が見つかった直後は buffer を処理して footer に記録開始
            isFooterBegin = true
            lilycs << buffer.chomp
            footer << line
            next
        end
        if isFooterBegin
            # フッタが始まってからは footer のみに追記
            footer << line
            next
        end

        # 空行の直前に TeX の改行文字 "\\" を入れないための処理
        if line == "\n"
            lilycs << buffer.chomp << "\n"
        else
            lilycs << buffer.chomp << "\\\\\\\n"
        end
        buffer = line
    }
    if !isFooterBegin
        lilycs << buffer.chomp # 最後の行を追記
    end

    lilycs.gsub!(/([一-龠々])/, '\\ruby{\1}{}') # 漢字全てを '\ruby{漢字}{}' で markup

    # 連続する漢字をまとめる処理 ここから
    lilycs.gsub!(/{}\\ruby{/, '') # '{}' と '\ruby' が連続するものを削除
    lilycs.gsub!(/{}/, '#') # 残った '{}' を一旦 '#' に置き換え
    lilycs.gsub!(/(.)}/, '\1') # 残された '}' を全部消す
    lilycs.gsub!(/#/, '}{}') # '#' にした '{}' を '}{}' として元に戻す
    # 連続する漢字をまとめる処理 ここまで

    # 曲番を除いて TeX トークン \item と \vspace に変換
    # lilycs.gsub!(/.+\.\\\\\\\n/, '') # 任意の文字にドットがつくものは曲番なので覗く
    lilycs.gsub!(/(.+\.)\\\\\\/, '% \1') # 任意の文字にドットがつくものは曲番なのでコメントアウトしておく
    lilycs.gsub!(/^\\\\\\$/, "\n\\vspace{\\linespace}\n\\item") # \\ だけの行を '\vspace{\linespace}\n\item' に置き換え

    # フッタがあれば処理する
    if footer.length != 0
        # フッタの半角括弧を全角括弧に変換
        footer.gsub!('(', '（').gsub!(')', '）')
        # フッタを追記
        lilycs = lilycs << footer
    end

    # 最初の空行だけ除く
    lilycs.sub!("\n", '')

    # # srcName.ruby ファイルに書き出し
    # result = File.open("ruby/#{srcName}.ruby", 'w')
    # result.write(lilycs)
    # result.close

    ###################
    # ここから TeX ファイルの作成
    ###################
    # TeX のテンプレートファイル読み込み
    template = File.open("#{templateName}", 'r')
    tex = template.read()

    # lilycs 部分は行頭にスペースを入れて TeX テンプレートのインデントに揃える
    lilycs.gsub!(/^/, "        ")
    
    # テンプレートの中身をそれぞれ置換
    tex.gsub!('TITLE', title)
    tex.gsub!('YEAR', year)
    # 作歌作曲者が同一かどうかで場合分け
    if name2.length != 0
        name1.gsub!(/^(.+)$/, '\1君 作歌')
        name2.gsub!(/^(.+)$/, '\1君 作曲')
        name = name1 + "\\\\\\" + name2
        tex.gsub!('NAME', name)
    else
        name = name1.gsub(/^(.+)$/, '\1君 作歌・作曲')
        tex.gsub!('NAME', name)
    end
    tex.gsub!('        LILYCS', lilycs) # 歌詞部分

    # 元のファイル名から .txt を抜く
    srcName.slice!('.txt')
    # srcName.ruby.tex ファイルに書き出し
    result = File.open("tex/#{srcName}.ruby.tex", 'w')
    result.write(tex)
    result.close
}

