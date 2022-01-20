## Install

### Install ruby

```sh
brew install rbenv
brew install readline openssl@1.1
# rbenv --list
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1) --with-readline-dir=$(brew --prefix readline)"
rbenv install 2.7.5
gem install --user-install bundler
```

Add to `.zshrc`:

```
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
```

### Install jekyll

```sh
bundle install
```

## Start

```sh
bundle exec jekyll serve --livereload
```
