# minrails
学習のため、https://qiita.com/taigamikami/items/0a2658776d3dffa1cc86 を参考にwebフレームワークをRubyで実装します。

## webフレームワークとは
web開発をサポートし、開発に要する労力を削減するために使われるもの。詳しくは、https://ja.wikipedia.org/wiki/Web%E3%82%A2%E3%83%97%E3%83%AA%E3%82%B1%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3%E3%83%95%E3%83%AC%E3%83%BC%E3%83%A0%E3%83%AF%E3%83%BC%E3%82%AF 。

## Rackとは
https://github.com/rack/rack#label-Rack-2C+a+modular+Ruby+webserver+interface を読みときます。

> Rack, a modular Ruby webserver interface

modularについて
> ...あるいはソフトウェアの開発手法としてモジュールの概念を取り入れたものをモジュラープログラミングと呼んだりする。
https://www.sophia-it.com/content/%E3%83%A2%E3%82%B8%E3%83%A5%E3%83%A9

webserverについて
> Webサーバ（ウェブサーバ、英:Web server）は、HTTPに則り、クライアントソフトウェアのウェブブラウザに対して、HTMLやオブジェクト（画像など）の表示を提供するサービスプログラム及び、そのサービスが動作するサーバコンピュータを指す。
https://ja.wikipedia.org/wiki/Web%E3%82%B5%E3%83%BC%E3%83%90

interfaceについて
> 情報技術において、インタフェース（英: interface）は、情報の授受を行うシステム間のプロトコル、または、その接続を行う部分をいう[1]。
https://ja.wikipedia.org/wiki/%E3%82%A4%E3%83%B3%E3%82%BF%E3%83%95%E3%82%A7%E3%83%BC%E3%82%B9_(%E6%83%85%E5%A0%B1%E6%8A%80%E8%A1%93)
今回では、RubyスクリプトとWebサーバーでやりとりを行うところ？

> Rack provides a minimal, modular, and adaptable interface for developing web applications in Ruby.
Rubyで実装されている

>  By wrapping HTTP requests and responses in the simplest way possible, it unifies and distills the API for web servers, web frameworks, and software in between (the so-called middleware) into a single method call.
HTTPリクエストとレスポンスをラッピング（Rubyで実装するという意味？）することで、メソッドとミドルウェアを単一化し、重要な部分を抽出する。

> The exact details of this are described in the Rack specification, which all Rack applications should conform to.
詳細は https://github.com/rack/rack/blob/master/SPEC.rdoc 。

## 実装作業

`$ bundle init`を実行してGemfileを生成。

Gemfileについて
参照 https://ruby.studio-kingdom.com/bundler/gemfile/
おそらくMakefileみたいなもの。どのようなライブラリ(Gem)をインストールするかなどを記述する。

``` Gemfile
# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

# gem "rails"
gem 'rack'
gem 'pry'
```

`$ bundle init`すると自動で上から8行が書かれたGemfileが作成。

pryについて
> Pry is a runtime developer console and IRB alternative with powerful introspection capabilities. 
irbに代わるもの。シンタックスハイライトがある。

runtimeについて
実行時。対義語にはコンパイル時（compile-time）。
https://e-words.jp/w/%E3%83%A9%E3%83%B3%E3%82%BF%E3%82%A4%E3%83%A0.html

consoleについて
対話的な操作システムのこと。特に遠隔で行うそれをターミナルと呼ぶ。
https://e-words.jp/w/%E3%82%B3%E3%83%B3%E3%82%BD%E3%83%BC%E3%83%AB.html

IRB
Interactive Ruby
https://docs.ruby-lang.org/ja/latest/library/irb.html

https://github.com/pry/pry

### アプリケーションの作成

``` ruby app.rb
# frozen_string_literal: true

class App
  def call(env)
	[200, {}, ['Hello World']]
  end
end

```

解読
4: env
envはCGI環境変数。`$ env`を実行すると↓がでてきた。

``` sh
USER=yamadaiori
__CFBundleIdentifier=com.microsoft.VSCode
COMMAND_MODE=unix2003
DISPLAY=/private/tmp/com.apple.launchd.9P33qHAcg7/org.xquartz:0
LOGNAME=yamadaiori
PATH=/opt/homebrew/opt/ruby/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/share/dotnet:/opt/X11/bin:~/.dotnet/tools:/Library/Frameworks/Mono.framework/Versions/Current/Commands:/opt/homebrew/opt/ruby/bin:/opt/homebrew/bin:/opt/homebrew/sbin
SSH_AUTH_SOCK=/private/tmp/com.apple.launchd.1vLV3RaRIi/Listeners
SHELL=/bin/zsh
HOME=/Users/yamadaiori
__CF_USER_TEXT_ENCODING=0x1F5:0x1:0xE
TMPDIR=/var/folders/kh/3wkxd1qj7r715965t6w6tz840000gn/T/
XPC_SERVICE_NAME=0
XPC_FLAGS=0x0
ORIGINAL_XDG_CURRENT_DESKTOP=undefined
SHLVL=1
PWD=/Users/yamadaiori/programming/ruby/minrails
OLDPWD=/Users/yamadaiori/programming/ruby
HOMEBREW_PREFIX=/opt/homebrew
HOMEBREW_CELLAR=/opt/homebrew/Cellar
HOMEBREW_REPOSITORY=/opt/homebrew
HOMEBREW_SHELLENV_PREFIX=/opt/homebrew
MANPATH=/usr/share/man:/usr/local/share/man:/opt/X11/share/man:/opt/homebrew/share/man
INFOPATH=/opt/homebrew/share/info:
TERM_PROGRAM=vscode
TERM_PROGRAM_VERSION=1.59.1
LANG=ja_JP.UTF-8
COLORTERM=truecolor
VSCODE_GIT_IPC_HANDLE=/var/folders/kh/3wkxd1qj7r715965t6w6tz840000gn/T/vscode-git-b5ba956473.sock
GIT_ASKPASS=/Applications/Visual Studio Code.app/Contents/Resources/app/extensions/git/dist/askpass.sh
VSCODE_GIT_ASKPASS_NODE=/Applications/Visual Studio Code.app/Contents/Frameworks/Code Helper (Renderer).app/Contents/MacOS/Code Helper (Renderer)
VSCODE_GIT_ASKPASS_MAIN=/Applications/Visual Studio Code.app/Contents/Resources/app/extensions/git/dist/askpass-main.js
TERM=xterm-256color
_=/usr/bin/env
```

記事中の
> ... localhost:9292/posts にアクセスした際のenvの値を設定します。 ...
を理解できなかった。https://route477.net/w/RackReferenceJa.html を参考にして`http://localhost:9292/`にアクセスした時`Hello World`が表示されるようにする。

``` ruby App.ruby
# frozen_string_literal: true

class HelloApp
  def call(env)
	[200, {'Content-Type' => 'text/plain'}, ['Hello World']]
  end
end

```

5行目について
↓どっちも同じ結果に
``` ruby
	[200, {'Content-Type' => 'text/plain'}, ['Hello World']]
	[200, {}, ['Hello World']]
```

``` ruby config.ru
require './app'
run HelloApp.new

```

config.ruについて
> これはRackのサーバ起動コマンドrackupの設定ファイルで、中身はRubyで記述します。
https://qiita.com/higuma/items/838f4f58bc4a0645950a

`$ rackup config.ru`を実行し、`http://localhost:9292/`するとHello Worldが表示される。