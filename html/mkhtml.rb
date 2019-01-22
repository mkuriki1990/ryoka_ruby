#!/usr/bin/ruby
# ルビの TeX トークン を HTML タグのルビに変換するスクリプト

# TeX ソースが存在するファイルについて処理する
# Dir.glob("../worked/*.tex"){|texFilename|
ARGV.each{|texFilename|
    if texFilename.match(/template/)
        next
    end
    filename = File.basename(texFilename, ".ruby.tex")
    srcFilename = filename + ".txt"

    srcSource = File.open("../src/#{srcFilename}", 'r:BOM|UTF-8')
    src = srcSource.read()
    texSource = File.open("#{texFilename}", 'r:BOM|UTF-8')
    tex = texSource.read()

    isHeaderEnd = false
    isNewline = false

    isPrevBlank = false

    # 歌詞を入れる文字列
    lilycs = ""

    lilycs << '<!doctype html>' << "\n\n"
    lilycs << '<html lang="ja">' << "\n"
    lilycs << '<head>' << "\n" << '    <meta charset="utf-8">' << "\n"
    lilycs << '    <title>北海道大学恵迪寮寮歌</title>' << "\n"
    lilycs << '    <style type="text/css">' << "\n"
    lilycs << '        body {' << "\n"
    lilycs << '        background-color: #ffffff;' << "\n"
    lilycs << '        color: #000000;' << "\n"
    lilycs << '        }' << "\n"
    lilycs << '    </style>' << "\n"
    lilycs << '</head>' << "\n"
    lilycs << '<body>' << "\n"


    src.lines{|line|
        # 最初の空行まではヘッダとして抽出
        if line == "\n"
            # lilycs << "<br>" << "\n"
            break
        end
        lilycs << "    " << line.chomp << "<br>" << "\n"
    }

    tex.lines{|line|
        # 「歌詞ここから」コメントまではヘッダとして除外
        if !isHeaderEnd
            if line =~ /.*%%%%% 歌詞 ここから %%%%%/
                isHeaderEnd = true
            end
            next
        end

        # 行頭のスペースを除外
        line.gsub!(/^    /, "")
        line.gsub!(/^    /, "")

        # TeX の諸々要素をスキップ
        if line =~ /\\begin.*/ 
            next
        end
        if line =~ /end.*/ 
            next
        end
        if line =~ /\\vspace{\\linespace}/
            next
        end

        if line =~ /\\footnotesize/
            line.gsub!(/{\\footnotesize(（.+）)}/, '\1')
        end

        # \item トークンの除去と曲番以外でつけた※印の処理
        if line =~ /\\item.*/
            if line !~ /\\item\[(（※）)\]/
                next
            end
            line = $1
        end

        # 空白を示す "~" は半角スペースに置換
        line.gsub!(/~/, " ")

        # CID 文字コードで置き換えている部分の処理
        if line.match(/CID/)
            line.gsub!(/ % CID (.+)/, "")
            utf = $1
            line.gsub!(/{\\CID{[0-9]{4,5}}/, "#{utf}")
        end

        # 曲番を抽出
        line.gsub!(/% (.*)/, '\1')

        # % で始まる文はスキップ
        if line =~ /%.+/
            next
        end

        # 連続する改行を除去
        if line == "\n"
            if isPrevBlank == false
                isPrevBlank = true
            else
                isPrevBlank = false
                next
            end
        else
            if isPrevBlank == true
                isPrevBlank = false
            end
        end

        # # 行末にある TeX の改行文字 \\ を除去
        line.gsub!("\\\\", "")

        # \ruby{漢字}{ふり|がな} を html のルビタグに変換
        line.gsub!(/\\ruby{(.*?)}{(.*?)}/, '<ruby><rb>\1</rb><rp>(</rp><rt>\2</rt><rp>)</rp></ruby>')
        line.gsub!(/\\ruby\[g\]{(.*?)}{(.*?)}/, '<ruby><rb>\1</rb><rp>(</rp><rt>\2</rt><rp>)</rp></ruby>')
        line.gsub!(/\|/, '')

        # 改行タグを追加して追記
        lilycs << "    "  << line.chomp << "<br>" << "\n"

        # 「歌詞ここまで」コメント以降は無視
        if line == "%%%%% 歌詞 ここまで %%%%%\n"
            break
        end
    }

    lilycs << '</body>' << "\n"
    lilycs << '</html>'

    # # 最初の空行だけ除く
    # lilycs.sub!("\n", '')

    # page ディレクトリに HTML 文書を作成
    htmlFilename = filename + ".html"
    result = File.open("./page/#{htmlFilename}", 'w')
    result.write(lilycs)
    result.close

}
