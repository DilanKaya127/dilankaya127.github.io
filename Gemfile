source "https://rubygems.org"

gem "jekyll", "~> 4.3"
gem "faraday-retry" # önceki uyarı için
gem "webrick", "~> 1.7" # Ruby 3+ için gerekebilir
gem 'google-protobuf'

group :jekyll_plugins do
  gem "jekyll-sitemap"
  gem "jekyll-feed"
end

platforms :mingw, :x64_mingw, :mswin, :jruby do
  gem "tzinfo", ">= 1", "< 3"
  gem "tzinfo-data"
end

gem "wdm", "~> 0.1", :platforms => [:mingw, :x64_mingw, :mswin]
gem "http_parser.rb", "~> 0.6.0", :platforms => [:jruby]