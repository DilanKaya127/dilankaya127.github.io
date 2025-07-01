---
layout: guide
guide_id: install_ruby_on_rails
title: Install Ruby On Rails
description: Install Ruby On Rails konusunu detaylı olarak ele alan Rails kılavuzu.
last_updated: '2025-07-01'
translation: true
original_file: install_ruby_on_rails.md
---

**RESMİ KILAVUZA BU ADRES ÜZERİNDEN ULAŞABİLİRSİNİZ: <https://guides.rubyonrails.org>**

--------------------------------------------------------------------------------

Ruby on Rails İndirme Kılavuzu
===========================

Bu kılavuz, Ruby programlama dilini ve Rails çerçevesini işletim sisteminize kurmanızda size yol gösterecektir.

İşletim sisteminize Ruby önceden yüklenmiş olarak gelse de, genellikle güncel değildir ve yükseltilemez. [Mise](https://mise.jdx.dev/getting-started.html) gibi bir sürüm yöneticisi kullanmak, en son Ruby sürümünü yüklemenize, her uygulama için farklı bir Ruby sürümü kullanmanıza ve yeni sürümler yayınlandığında kolayca yükseltmenize olanak tanır.

Alternatif olarak, Ruby veya Rails'i doğrudan makinenize kurmadan Rails'i çalıştırmak için Dev Containers'ı kullanabilirsiniz. Daha fazla bilgi edinmek için [Dev Containers ile Başlarken](../getting_started_with_devcontainer/) kılavuzuna göz atın.

--------------------------------------------------------------------------------

## İşletim Sisteminizi Seçin

Kullandığınız işletim sistemi için olan bölümü takip edin:

* [macOS](#macos-a-ruby-yukleyin)
* [Ubuntu](#ubuntu-ya-ruby-yukleyin)
* [Windows](#windows-a-ruby-yukleyin)

<div class="guide-alert guide-alert-info">
  <div class="guide-alert-icon">💡</div>
  <div class="guide-alert-content">
    Dolar işareti <code>$</code> ile başlayan tüm komutlar terminalde çalıştırılmalıdır.
  </div>
</div>

### macOS'a Ruby Yükleyin

Bu talimatları takip etmek için macOS Catalina 10.15 veya daha yüksek sürümüne ihtiyacınız olacak.

macOS'ta, Ruby'yi derlemek için gereken bağımlılıkları yüklemek amacıyla Xcode Komut Satırı Araçlarına ve Homebrew'a ihtiyacınız olacak.

Terminali açın ve aşağıdaki komutları çalıştırın:

```bash
# Install Xcode Command Line Tools
$ xcode-select --install

# Install Homebrew and dependencies
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
$ echo 'export PATH="/opt/homebrew/bin:$PATH"' >> ~/.zshrc
$ source ~/.zshrc
$ brew install openssl@3 libyaml gmp rust

# Install Mise version manager
$ curl https://mise.run | sh
$ echo 'eval "$(~/.local/bin/mise activate)"' >> ~/.zshrc
$ source ~/.zshrc

# Install Ruby globally with Mise
$ mise use -g ruby@3
```

### Ubuntu'ya Ruby Yükleyin

Bu talimatları takip etmek için Ubuntu Jammy 22.04 veya daha yüksek sürümüne ihtiyacınız olacak.

Terminali açın ve aşağıdaki komutları çalıştırın:

```bash
# Install dependencies with apt
$ sudo apt update
$ sudo apt install build-essential rustc libssl-dev libyaml-dev zlib1g-dev libgmp-dev

# Install Mise version manager
$ curl https://mise.run | sh
$ echo 'eval "$(~/.local/bin/mise activate)"' >> ~/.bashrc
$ source ~/.bashrc

# Install Ruby globally with Mise
$ mise use -g ruby@3
```

### Windows'a Ruby Yükleyin

Linux Windows Alt Sistemi (WSL), Windows üzerinde Ruby on Rails geliştirme için en iyi deneyimi sağlayacaktır. Ubuntu'yu Windows içinde çalıştırır, bu da sunucularınızın ürün üzerinde çalışacağı ortama yakın bir ortamda çalışmanıza olanak tanır.

Windows 11 veya Windows 10 sürüm 2004 ve üstü (Build 19041 ve üstü) gerekir.

PowerShell veya Windows Komut İstemi'ni açın ve çalıştırın:

```bash
$ wsl --install --distribution Ubuntu-24.04
```

Yükleme işlemi sırasında yeniden başlatmanız gerekebilir.

Kurulduktan sonra, Başlat menüsünden Ubuntu'yu açabilirsiniz. İstendiğinde Ubuntu kullanıcınız için bir kullanıcı adı ve parola girin.

Ardından aşağıdaki komutları çalıştırın:

```bash
# Install dependencies with apt
$ sudo apt update
$ sudo apt install build-essential rustc libssl-dev libyaml-dev zlib1g-dev libgmp-dev

# Install Mise version manager
$ curl https://mise.run | sh
$ echo 'eval "$(~/.local/bin/mise activate bash)"' >> ~/.bashrc
$ source ~/.bashrc

# Install Ruby globally with Mise
$ mise use -g ruby@3
```

Ruby Kurulumunuzu Doğrulama
---------------------------

Ruby kurulduktan sonra, aşağıdaki şekilde çalıştığını doğrulayabilirsiniz:

```bash
$ ruby --version
ruby 3.3.6
```

Rails İndirme
----------------

Ruby'de "gem", bir kütüphane veya Ruby programının kendi kendini kapsayan bir paketidir. Ruby'nin `gem` komutunu kullanarak [RubyGems](https://rubygems.org) adresinden Rails'in en son sürümünü ve bağımlılıklarını yükleyebiliriz.

Rails'in son sürümünü yüklemek ve terminalinizde kullanılabilir hale getirmek için aşağıdaki komutu çalıştırın:

```bash
$ gem install rails
```

Rails'in doğru yüklendiğini doğrulamak için aşağıdakileri çalıştırın. Bir sürüm numarasının yazdırıldığını göreceksiniz:

```bash
$ rails --version
Rails 8.0.0
```

<div class="guide-alert guide-alert-warning">
  <div class="guide-alert-icon">📝</div>
  <div class="guide-alert-content">
    Eğer <code>rails</code> komutu bulunamazsa, terminalinizi yeniden başlatmayı deneyin.
  </div>
</div>

[Rails ile Başlamaya](../getting_started/) hazırsınız!