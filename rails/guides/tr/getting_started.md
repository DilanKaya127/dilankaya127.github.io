---
layout: guide
---

**RESMİ KILAVUZA BU ADRES ÜZERİNDEN ULAŞABİLİRSİNİZ: <https://guides.rubyonrails.org>.**

Rails ile Başlarken
=====================

Bu kılavuz Ruby on Rails'i nasıl kurup çalıştıracağınızı anlatmaktadır.

Bu kılavuzu okuduktan sonra şunları öğreneceksiniz:

* Rails'i nasıl kuracağınızı, yeni bir Rails uygulaması nasıl oluşturacağınızı ve uygulamanızı bir veritabanına nasıl bağlayacağınızı.
* Rails uygulamasının genel yapısını.
* MVC (Model, View, Controller) ve RESTful tasarımının temel ilkelerini.
* Rails uygulamasının başlangıç parçalarını hızlı bir şekilde nasıl oluşturacağınızı.
* Kamal kullanarak uygulamanızı bir ürüne nasıl dağıtacağınızı (deploy edeceğinizi).

--------------------------------------------------------------------------------

Giriş
------------
Ruby on Rails'e hoş geldiniz! Bu kılavuzda, Rails ile web uygulamaları geliştirmenin temel konularını ele alacağız. Bu kılavuzu takip etmek için Rails'te herhangi bir deneyime ihtiyacınız yok.

Rails, Ruby programlama dili için geliştirilmiş bi web çerçevesidir. Rails, Ruby'nin birçok özelliğinin avantajını barındırmaktadır, bu yüzden sizlere Ruby'nin temellerini öğrenmenizi *şiddetle* öneririz. Böylece bu kılavuzda karşılacağınız bazı temel terimleri ve kelimeleri anlıyor olacaksınız.

- [Resmi Ruby Websitesi](https://www.ruby-lang.org/en/documentation/)
- [Ücretsiz Programlama Kitaplarını İçeren Liste](https://github.com/EbookFoundation/free-programming-books/blob/main/books/free-programming-books-langs.md#ruby)

Rails'in Felsefesi
----------------


Rails, Ruby programlama dilinde yazılmış bir web uygulaması geliştirme çerçevesidir. Her geliştiricinin başlangıç için ihtiyaç duyduğu şeyleri varsayarak web uygulamalarını programlamayı kolaylaştırmak için tasarlanmıştır. Diğer birçok dil ve çerçeveye göre daha az kod yazarak daha fazlasını başarmanızı sağlar. Deneyimli Rails geliştiricileri, web uygulaması geliştirmeyi daha eğlenceli hale getirdiğini de belirtmektedir.

Rails, inatçı bir yazılımdır. İşleri yapmanın “en iyi” bir yolu olduğu varsayımından hareket eder ve bu yolu teşvik etmek için tasarlanmıştır - ve bazı durumlarda alternatiflerden caydırır. “Rails Yöntemi”ni öğrenirseniz, muhtemelen üretkenliğinizde muazzam bir artış göreceksiniz. Diğer dillerden edindiğiniz eski alışkanlıkları Rails geliştirirken ısrarla sürdürür ve başka yerlerde öğrendiğiniz kalıpları kullanmaya çalışırsanız, daha az mutlu bir deneyim yaşayabilirsiniz.

Rails felsefesi iki ana kılavuz ilke içerir:

- **Kendini Tekrar Etme:** DRY, yazılım geliştirmenin bir ilkesidir ve “Her bilgi parçası, sistem içinde tek, açık ve kesin bir şekilde temsil edilmelidir” der. Aynı bilgiyi tekrar tekrar yazmayarak, kodumuz daha kolay bakımı yapılabilir, daha genişletilebilir ve daha az hata içerir hale gelir.
- **Yapılandırma Üzerine Kurallar:** Rails, bir web uygulamasında birçok şeyin en iyi şekilde nasıl yapılacağına dair fikirlere sahiptir ve bunları sonsuz yapılandırma dosyaları aracılığıyla kendiniz tanımlamanızı gerektirmek yerine, varsayılan olarak bu kurallar kümesini kullanır.

Yeni Bir Rails Uygulaması Geliştirme
------------------------

`store` adında bir proje geliştireceğiz, Rails'in yerleşik özelliklerinden birkaçını gösteren basit bir e-ticaret sitesi olacak.

İPUCU: Dolar işareti `$` ile başlayan tüm komutlar terminalde çalıştırılmalıdır.

### Önkoşullar

Bu proje için şunlar gerekli:

* Ruby 3.2 veya daha üst sürümü
* Rails 8.1.0 veya daha üst sürümü
* Bir kod editörü

Ruby ve/veya Rails'i indirmeniz gerekiyorsa, bu tutorialı takip edin:[Ruby on Rails İndirme Kılavuzu](install_ruby_on_rails.html)

Rails'in doğru sürümünün yüklü olduğunu doğrulayalım. Mevcut sürümü görüntülemek için bir terminal açın ve aşağıdakileri çalıştırın. Bir sürüm numarası görmelisiniz:

```bash
$ rails --version
Rails 8.1.0
```

Rails 8.1.0 veya daha yüksek bir sürüm olmalı.

### İlk Rails Uygulamanızı Oluşturmak


Rails, hayatınızı kolaylaştırmak için çeşitli komutlar sunar. Tüm komutları görmek için `rails --help` komutunu çalıştırın.

`rails new` komutu, yeni bir Rails uygulamasının temelini oluşturur, bu yüzden buradan başlayalım.

`store` uygulamamızı oluşturmak için terminalinizde aşağıdaki komutu çalıştırın:

```bash
$ rails new store
```

NOT: Rails'in oluşturduğu uygulamayı flag kullanarak özelleştirebilirsiniz.
Bu seçenekleri görmek için `rails new --help` komutunu çalıştırın.

Yeni uygulamanız oluşturulduktan sonra, uygulama dizinine geçin:

```bash
$ cd store
```

