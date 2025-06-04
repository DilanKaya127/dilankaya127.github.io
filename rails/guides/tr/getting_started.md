---
layout: guide
---

**RESMİ KILAVUZA BU ADRES ÜZERİNDEN ULAŞABİLİRSİNİZ: <https://guides.rubyonrails.org>**

--------------------------------------------------------------------------------

Rails ile Başlarken
=====================

Bu kılavuz Ruby on Rails'i nasıl kurup çalıştıracağınızı anlatmaktadır.

Bu kılavuzu okuduktan sonra şunları öğreneceksiniz:

* Rails'i nasıl kuracağınızı, yeni bir Rails uygulaması nasıl oluşturacağınızı ve uygulamanızı bir veritabanına nasıl bağlayacağınızı.
* Rails uygulamasının genel yapısını.
* MVC (Model, View, Controller) ve RESTful tasarımının temel ilkelerini.
* Rails uygulamasının başlangıç parçalarını hızlı bir şekilde nasıl oluşturacağınızı.
* Kamal kullanarak uygulamanızı bir ürüne nasıl dağıtacağınızı (deploy edeceğinizi).


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

- **Kendini Tekrar Etme:** DRY (Don't Repeat Yourself), yazılım geliştirmenin bir ilkesidir ve “Her bilgi parçası; sistem içinde tek, açık ve kesin bir şekilde temsil edilmelidir” der. Aynı bilgiyi tekrar tekrar yazmayarak kodumuz daha kolay bakımı yapılabilir, daha genişletilebilir ve daha az hata içerir hale gelir.
- **Yapılandırma Üzerine Kurallar:** Rails, bir web uygulamasında birçok şeyin en iyi şekilde nasıl yapılacağına dair fikirlere sahiptir ve bunları sonsuz yapılandırma dosyaları aracılığıyla kendiniz tanımlamanızı gerektirmek yerine, varsayılan olarak bu kurallar kümesini kullanır.

Yeni Bir Rails Uygulaması Geliştirme
------------------------

`store` adında bir proje geliştireceğiz, Rails'in yerleşik özelliklerinden birkaçını gösteren basit bir e-ticaret sitesi olacak.

<div class="guide-alert guide-alert-info">
  <div class="guide-alert-icon">💡</div>
  <div class="guide-alert-content">
    Dolar işareti <code>$</code> ile başlayan tüm komutlar terminalde çalıştırılmalıdır.
  </div>
</div>

### Ön Koşullar

Bu proje için şunlar gerekli:

* Ruby 3.2 veya daha üst sürümü
* Rails 8.1.0 veya daha üst sürümü
* Bir kod editörü

Ruby ve/veya Rails'i indirmeniz gerekiyorsa, bu tutorialı takip edin: [Ruby on Rails İndirme Kılavuzu](install_ruby_on_rails.html)

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

<div class="guide-alert guide-alert-warning">
  <div class="guide-alert-icon">📝</div>
  <div class="guide-alert-content">
    Rails'in oluşturduğu uygulamayı flag kullanarak özelleştirebilirsiniz.
Bu seçenekleri görmek için <code>rails new --help</code> komutunu çalıştırın.
  </div>
</div>

Yeni uygulamanız oluşturulduktan sonra, uygulama dizinine geçin:

```bash
$ cd store
```

### Dizin Yapısı

Yeni bir Rails uygulamasında yer alan dosya ve dizinlere hızlıca bir göz atalım. Dosyaları ve dizinleri görmek için bu klasörü kod editörünüzde açabilir veya terminalinizde `ls -la` komutunu çalıştırabilirsiniz.

| Dosya/Klasör | Amacı |
| ------------ | ----- |
|app/|Uygulamanız için controllers, models, views, helpers, mailer, jobs ve assets içerir. **Bu kılavuzun geri kalanında çoğunlukla bu klasöre odaklanacaksınız.**|
|bin/|Uygulamanızı başlatan `rails` betiğini (scriptini) içerir ve uygulamanızı kurmak, güncellemek, dağıtmak veya çalıştırmak için kullandığınız diğer betikleri de içerebilir.|
|config/|Uygulamanızın yönlendirmeleri (route), veritabanı ve daha fazlası için yapılandırma içerir. Bu konu [Rails Uygulamalarının Yapılandırılması](configuring.html) bölümünde daha ayrıntılı olarak ele alınmıştır.|
|db/|Mevcut veritabanı şemanızın yanı sıra veritabanı değişikliklerini (migrations) de içerir.|
|Dockerfile|Docker için yapılandırma dosyasıdır.|
|Gemfile<br>Gemfile.lock|Bu dosyalar, Rails uygulamanız için hangi gem bağımlılıklarının gerekli olduğunu belirtmenizi sağlar. Bu dosyalar [Bundler](https://bundler.io) gem'i tarafından kullanılır.|
|lib/|Uygulamanız için genişletilmiş modüller.|
|log/|Uygulama log dosyaları.|
|public/|Statik dosyaları ve derlenmiş assetleri içerir. Uygulamanız çalışırken, bu dizin olduğu gibi gösterilecektir.|
|Rakefile|Bu dosya komut satırından çalıştırılabilecek görevleri bulur ve yükler. Görev tanımları Rails'in bileşenleri boyunca tanımlanmıştır. `Rakefile`ı değiştirmek yerine, uygulamanızın `lib/tasks` dizinine dosyalar ekleyerek kendi görevlerinizi eklemelisiniz.|
|README.md|Bu, uygulamanız için kısa bir kullanım kılavuzudur. Uygulamanızın ne yaptığını, nasıl kurulacağını vb. başkalarına anlatmak için bu dosyayı düzenlemelisiniz.|
|script/|Tek seferlik veya genel amaçlı [script](https://github.com/rails/rails/blob/main/railties/lib/rails/generators/rails/script/USAGE) ve [benchmark](https://github.com/rails/rails/blob/main/railties/lib/rails/generators/rails/benchmark/USAGE)  içerir.|
|storage/|Disk Hizmeti (Disk Service) için SQLite veritabanlarını ve Active Storage dosyalarını içerir. Bu konu [Active Storage](active_storage_overview.html) bölümünde ele alınmıştır.|
|test/|Birim testleri (unit test), fikstürler ve diğer test aparatları. Bunlar [Rails Uygulamalarını Test Etme](testing.html) bölümünde ele alınmıştır.|
|tmp/|Geçici dosyalar (önbellek ve pid dosyaları gibi).|
|vendor/|Tüm üçüncü taraf kodları için bir alan. Tipik bir Rails uygulamasında bu, üçüncü taraf kodlar arasında özel olarak eklenen (vendored) gem'ler içerir.|
|.dockerignore|Bu dosya Docker'a hangi dosyaları konteynere kopyalamaması gerektiğini söyler.|
|.gitattributes|Bu dosya, bir Git deposundaki belirli yollar için meta verileri tanımlar. Bu meta veriler Git ve diğer araçlar tarafından davranışlarını geliştirmek için kullanılabilir. Daha fazla bilgi için [gitattributes belgelerine](https://git-scm.com/docs/gitattributes) bakın.|
|.git/|Git deposu dosyalarını içerir.|
|.github/|GitHub'a özgü dosyaları içerir.|
|.gitignore|Bu dosya Git'e hangi dosyaları veya kalıpları (pattern) yok sayması gerektiğini söyler. Dosyaları yok sayma hakkında daha fazla bilgi için [GitHub - Ignoring files](https://help.github.com/articles/ignoring-files) adresine bakın.|
|.kamal/|Kamal'ın gizli/önemli verilerini ve dağıtım betiklerini (hook) içerir. |
|.rubocop.yml|Bu dosya RuboCop için yapılandırmayı içerir.|
|.ruby-version|Bu dosya varsayılan Ruby sürümünü içerir.|

### Model-View-Controller Temelleri

Rails kodu Model-View-Controller (MVC) mimarisi kullanılarak düzenlenmiştir. MVC ile, kodlarımızın çoğunun içinde çalıştığı üç ana yapı vardır:

* Model - Uygulamanızdaki verileri yönetir. Tipik olarak, veritabanı tablolarınızdır.
* View - Yanıtları (response) HTML, JSON, XML gibi farklı biçimlerde göstermeyi (render) yönetir.
* Controller - Her istek için kullanıcı etkileşimlerini ve  mantığı (logic) işler.

<picture class="flowdiagram">
  <source srcset="/assets/images/getting_started/mvc_architecture_dark.jpg" media="(prefers-color-scheme:dark)">
  <img src="/assets/images/getting_started/mvc_architecture_light.jpg">
</picture>

Şimdi MVC hakkında temel bir anlayışa sahip olduğumuza göre, Rails'te bunun nasıl kullanıldığını görelim.

Merhaba, Rails!
-------------

Uygulamamızın veritabanını oluşturarak ve Rails sunucumuzu ilk kez başlatarak kolay bir başlangıç yapalım.

Terminalinizde, `store` dizininde aşağıdaki komutları çalıştırın:

```bash
$ bin/rails db:create
```

Bu, başlangıçta uygulamanın veritabanını oluşturacaktır.

```bash
$ bin/rails server
```

NOT: Komutları bir uygulama dizini içinde çalıştırdığımızda `bin/rails` kullanmalıyız. Bu, uygulamanın Rails sürümünün kullanıldığından emin olunmasını sağlar.

Bu, statik dosyaları ve Rails uygulamanızı sunacak olan Puma adlı bir web sunucusunu başlatacaktır:

```bash
=> Booting Puma
=> Rails 8.1.0 application starting in development
=> Run `bin/rails server --help` for more startup options
Puma starting in single mode...
* Puma version: 6.4.3 (ruby 3.3.5-p100) ("The Eagle of Durango")
*  Min threads: 3
*  Max threads: 3
*  Environment: development
*          PID: 12345
* Listening on http://127.0.0.1:3000
* Listening on http://[::1]:3000
Use Ctrl-C to stop
```

Rails uygulamanızı görmek için tarayıcınızda http://localhost:3000 adresini açın. Varsayılan Rails karşılama sayfasını göreceksiniz:

![Rails welcome page](/assets/images/getting_started/rails_welcome.png)

İşe yarıyor!

Bu sayfa, yeni bir Rails uygulaması için *smoke test* olup, bir sayfayı sunmak için perde arkasında her şeyin çalıştığından emin olunmasını sağlar.

Rails sunucusunu istediğiniz zaman durdurmak için terminalinizde `Ctrl-C` tuşuna basın.

### Geliştirme Aşamasında Otomatik Yükleme 

Geliştiricinin mutluluğu Rails'in temel felsefelerinden biridir ve bunu sağlamanın bir yolu da geliştirme sırasında kodun otomatik yeniden yüklenmesidir (reload).

Rails sunucusunu başlattığınızda, yeni dosyalar veya mevcut dosyalardaki değişiklikler algılanır ve otomatik olarak yüklenir veya gerektiğinde yeniden yüklenir. Bu, her değişiklikten sonra Rails sunucunuzu yeniden başlatmak zorunda kalmadan kodlamaya odaklanmanızı sağlar.

Rails uygulamalarının diğer programlama dillerinde gördüğünüz `require` deyimlerini (statement) nadiren kullandığını da fark edebilirsiniz. Rails, uygulama kodunuzu yazmaya odaklanabilmeniz için dosyaları otomatik olarak istemek üzere adlandırma kurallarını kullanır.

Daha fazla ayrıntı için [Otomatik Yükleme ve Yeniden Yükleme Sabitleri](autoloading_and_reloading_constants.html) bölümüne bakın.

Veritabanı Modeli Oluşturma
-------------------------

Active Record, ilişkisel veritabanlarını Ruby koduna eşleyen bir Rails özelliğidir.
Tablo ve kayıt oluşturma, güncelleme ve silme gibi veritabanı ile etkileşim için yapılandırılmış sorgu dilinin (SQL) oluşturulmasına yardımcı olur. Uygulamamız Rails için varsayılan olan SQLite kullanmaktadır.

Basit e-ticaret mağazamıza ürün eklemek için Rails uygulamamıza bir veritabanı tablosu ekleyerek başlayalım.

```bash
$ bin/rails generate model Product name:string
```

Bu komut Rails'e veritabanında `name` sütunu ve türü `string` olan `Product` adında bir model oluşturmasını söyler. Diğer sütun türlerini nasıl ekleyeceğinizi daha sonra öğreneceksiniz.

Terminalinizde aşağıdakileri göreceksiniz:

```bash
      invoke  active_record
      create    db/migrate/20240426151900_create_products.rb
      create    app/models/product.rb
      invoke    test_unit
      create      test/models/product_test.rb
      create      test/fixtures/products.yml
```

Bu komut birkaç şey yaparak şunları oluşturur:

1. `db/migrate` klasöründe bir şema değişikliği (migration).
2. `app/models/product.rb` içinde bir Active Record modeli.
3. Bu model için testler ve test fikstürleri.

NOT: Model adları *tekildir*, çünkü örneklenen bir model veritabanındaki tek bir kaydı temsil eder (yani, veritabanına eklemek için bir _product_ oluşturuyorsunuz).

### Veritabanı Değişiklikleri

Bir _migration_ veritabanımızda yapmak istediğimiz bir değişikliktir.

Migration'ları tanımlayarak, Rails'e veritabanındaki tabloları, sütunları veya diğer öznitelikleri eklemek, değiştirmek veya kaldırmak için veritabanını nasıl değiştireceğini söylüyoruz. Bu, geliştirme aşamasında (sadece bizim bilgisayarımızda) yaptığımız değişiklikleri takip etmemize yardımcı olur, böylece üretime (canlıda/çevrimiçiyken!) güvenli bir şekilde dağıtılabilirler.

Kod editörünüzde Rails'in bizim için oluşturduğu migration'ı açın, böylece migration'ın ne yaptığını görebiliriz. `db/migrate/<timestamp>_create_products.rb` şeklinde bir dosyada bulunur: 

```ruby
class CreateProducts < ActiveRecord::Migration[8.1]
  def change
    create_table :products do |t|
      t.string :name

      t.timestamps
    end
  end
end
```

Bu migration Rails'e `products` adında yeni bir veritabanı tablosu oluşturmasını söylüyor.

NOT: Yukarıdaki modelin aksine, Rails veritabanı tablo adlarını _çoğul_ yapar, çünkü veritabanı her modelin tüm örneklerini tutar (yani, _products_ veritabanı oluşturuyorsunuz).

Daha sonra `create_table` bloğu bu veritabanı tablosunda hangi sütunların ve türlerin tanımlanması gerektiğini belirler.

`t.timestamps` Rails'e `products` tablosunda `name` adında bir sütun oluşturmasını ve türünü `string` olarak ayarlamasını söyler.

`t.timestamps`, modellerinizde `created_at:datetime` ve `updated_at:datetime` adında iki sütun tanımlamak için bir kısayoldur. Bu sütunları Rails'teki çoğu Active Record modelinde görürsünüz ve kayıtlar oluşturulurken veya güncellenirken Active Record tarafından otomatik olarak ayarlanırlar.

### Değişiklikleri (Migration) Çalıştırmak
 
Artık veritabanında hangi değişikliklerin yapılacağını belirlediğinize göre, migration'ları çalıştırmak için aşağıdaki komutu kullanın:

```bash
$ bin/rails db:migrate
```

Bu komut yeni migration'ları kontrol eder ve bunları veritabanınıza uygular. Çıktısı şu şekilde görünür:

```bash
== 20240426151900 CreateProducts: migrating ===================================
-- create_table(:products)
   -> 0.0030s
== 20240426151900 CreateProducts: migrated (0.0031s) ==========================
```

<div class="guide-alert guide-alert-info">
  <div class="guide-alert-icon">💡</div>
  <div class="guide-alert-content">
    Eğer bir hata yaparsanız, son migration'ı geri almak için <code>bin/rails db:rollback</code> komutunu çalıştırabilirsiniz.
  </div>
</div>

Rails Konsolu
-------------

Artık products tablomuzu oluşturduğumuza göre, Rails'te onunla etkileşime geçebiliriz. Hadi deneyelim.

Bunun için *console* adı verilen bir Rails özelliğini kullanacağız. Konsol, Rails uygulamamızdaki kodumuzu test etmek için yararlı, etkileşimli bir araçtır.

```bash
$ bin/rails console
```

Aşağıdaki gibi bir komut istemi ile karşılaşacaksınız:

```irb
Loading development environment (Rails 8.1.0)
store(dev)>
```

Burada `Enter` tuşuna bastığımızda çalıştırılacak kodu yazabiliriz. Rails sürümünü yazdırmayı deneyelim:

```irb
store(dev)> Rails.version
=> "8.1.0"
```

İşe yarıyor!

Active Record Model Temelleri
--------------------------

Rails model oluşturucusunu `Product` modelini oluşturmak için çalıştırdığımızda, `app/models/product.rb` adresinde bir dosya oluşturdu. Bu dosya, `products` veritabanı tablomuzla etkileşim için Active Record kullanan bir sınıf oluşturur.

```ruby
class Product < ApplicationRecord
end
```

Bu sınıfta hiç kod olmaması sizi şaşırtabilir. Rails bu modeli neyin tanımladığını nasıl biliyor?

`Product` modeli kullanıldığında, Rails sütun adları ve türleri için veritabanı tablosunu sorgulayacak ve bu nitelikler (attribute) için otomatik olarak kod oluşturacaktır. Rails bizi bu şablon kodu yazmaktan kurtarır ve bunun yerine uygulama mantığımıza odaklanabilmemiz için bu işi bizim yerimize perde arkasında halleder.

Rails'in Product modeli için hangi sütunları algıladığını görmek için Rails konsolunu kullanalım.

Çalıştırın:

```irb
store(dev)> Product.column_names
```

Bunu görmelisiniz:

```irb
=> ["id", "name", "created_at", "updated_at"]
```

Rails, veritabanından yukarıdaki sütun bilgilerini istedi ve bu bilgileri `Product' sınıfındaki öznitelikleri dinamik olarak tanımlamak için kullandı, böylece her birini manuel olarak sizin tanımlamanız gerekmez. Bu, Rails'in geliştirmeyi nasıl kolaylaştırdığının bir örneğidir.

### Kayıtları Oluşturma

Aşağıdaki kod ile yeni bir Product kaydı oluşturabiliriz:

```irb
store(dev)> product = Product.new(name: "T-Shirt")
=> #<Product:0x000000012e616c30 id: nil, name: "T-Shirt", created_at: nil, updated_at: nil>
```

`product` değişkeni `Product`'ın bir örneklenmesidir. Veritabanına kaydedilmemiştir ve bu nedenle bir ID, created_at veya updated_at gibi zaman damgaları yoktur.

Kaydı veritabanına yazmak için `save` çağrısı yapabiliriz.

```irb
store(dev)> product.save
  TRANSACTION (0.1ms)  BEGIN immediate TRANSACTION /*application='Store'*/
  Product Create (0.9ms)  INSERT INTO "products" ("name", "created_at", "updated_at") VALUES ('T-Shirt', '2024-11-09 16:35:01.117836', '2024-11-09 16:35:01.117836') RETURNING "id" /*application='Store'*/
  TRANSACTION (0.9ms)  COMMIT TRANSACTION /*application='Store'*/
=> true
```

`save` çağrıldığında, Rails bellekteki öznitelikleri alır ve bu kaydı veritabanına eklemek için bir `INSERT` SQL sorgusu oluşturur.

Rails ayrıca bellekteki nesneyi `created_at` ve `updated_at` zaman damgalarıyla birlikte veritabanı kaydı `id` ile günceller. Bunu `product` değişkenini yazdırarak görebiliriz.

```irb
store(dev)> product
=> #<Product:0x00000001221f6260 id: 1, name: "T-Shirt", created_at: "2024-11-09 16:35:01.117836000 +0000", updated_at: "2024-11-09 16:35:01.117836000 +0000">
```

`save`e benzer şekilde, bir Active Record nesnesini tek bir çağrıda oluşturmak ve kaydetmek için `create` kullanabiliriz.

```irb
store(dev)> Product.create(name: "Pants")
  TRANSACTION (0.1ms)  BEGIN immediate TRANSACTION /*application='Store'*/
  Product Create (0.4ms)  INSERT INTO "products" ("name", "created_at", "updated_at") VALUES ('Pants', '2024-11-09 16:36:01.856751', '2024-11-09 16:36:01.856751') RETURNING "id" /*application='Store'*/
  TRANSACTION (0.1ms)  COMMIT TRANSACTION /*application='Store'*/
=> #<Product:0x0000000120485c80 id: 2, name: "Pants", created_at: "2024-11-09 16:36:01.856751000 +0000", updated_at: "2024-11-09 16:36:01.856751000 +0000">
```

### Kayıtları Sorgulama

Active Record modelimizi kullanarak veritabanındaki kayıtlara da bakabiliriz.

Veritabanındaki tüm Product kayıtlarını bulmak için `all` metodunu kullanabiliriz.
Bu bir _sınıf_ metodudur, bu yüzden Product üzerinde kullanabiliriz (yukarıdaki `save` gibi product örneklemesi/örneği üzerinde çağıracağımız bir örnekleme metoduna karşılık gelir).

```irb
store(dev)> Product.all
  Product Load (0.1ms)  SELECT "products".* FROM "products" /* loading for pp */ LIMIT 11 /*application='Store'*/
=> [#<Product:0x0000000121845158 id: 1, name: "T-Shirt", created_at: "2024-11-09 16:35:01.117836000 +0000", updated_at: "2024-11-09 16:35:01.117836000 +0000">,
 #<Product:0x0000000121845018 id: 2, name: "Pants", created_at: "2024-11-09 16:36:01.856751000 +0000", updated_at: "2024-11-09 16:36:01.856751000 +0000">]
```

Bu, `products` tablosundaki tüm kayıtları yüklemek için bir `SELECT` SQL sorgusu oluşturur. Her kayıt otomatik olarak Product Active Record modelimizin bir örneğine dönüştürülür, böylece Ruby'den onlarla kolayca çalışabiliriz.

<div class="guide-alert guide-alert-info">
  <div class="guide-alert-icon">💡</div>
  <div class="guide-alert-content">
    <code>all</code> metodu; filtreleme, sıralama ve diğer veritabanı işlemlerini yürütme özelliklerine sahip veritabanı kayıtlarının Array benzeri bir koleksiyonu olan bir <code>ActiveRecord::Relation</code> nesnesini döndürür.
  </div>
</div>

### Kayıtları Filtreleme ve Sıralama

Veritabanımızdaki sonuçları filtrelemek istersek ne olur? Kayıtları bir sütuna göre filtrelemek için `where` kullanabiliriz.

```irb
store(dev)> Product.where(name: "Pants")
  Product Load (1.5ms)  SELECT "products".* FROM "products" WHERE "products"."name" = 'Pants' /* loading for pp */ LIMIT 11 /*application='Store'*/
=> [#<Product:0x000000012184d858 id: 2, name: "Pants", created_at: "2024-11-09 16:36:01.856751000 +0000", updated_at: "2024-11-09 16:36:01.856751000 +0000">]
```

Bu bir `SELECT` SQL sorgusu oluşturur, ancak `"Pants"` ile eşleşen bir `name`e sahip kayıtları filtrelemek için bir `WHERE` cümleciği de ekler. Bu aynı zamanda bir `ActiveRecord::Relation` döndürür çünkü birden fazla kayıt aynı isme sahip olabilir.

Kayıtları isme göre artan alfabetik sırada sıralamak için `order(name: :asc)` kullanabiliriz.

```irb
store(dev)> Product.order(name: :asc)
  Product Load (0.3ms)  SELECT "products".* FROM "products" /* loading for pp */ ORDER BY "products"."name" ASC LIMIT 11 /*application='Store'*/
=> [#<Product:0x0000000120e02a88 id: 2, name: "Pants", created_at: "2024-11-09 16:36:01.856751000 +0000", updated_at: "2024-11-09 16:36:01.856751000 +0000">,
 #<Product:0x0000000120e02948 id: 1, name: "T-Shirt", created_at: "2024-11-09 16:35:01.117836000 +0000", updated_at: "2024-11-09 16:35:01.117836000 +0000">]
```

### Kayıtları Bulma

Peki ya belirli bir kaydı bulmak istiyorsak?

Bunu, tek bir kaydı ID'ye göre aramak için `find` sınıf metodunu kullanarak yapabiliriz. Aşağıdaki kodu kullanarak metodu çağırın ve belirli bir ID girin:

```irb
store(dev)> Product.find(1)
  Product Load (0.2ms)  SELECT "products".* FROM "products" WHERE "products"."id" = 1 LIMIT 1 /*application='Store'*/
=> #<Product:0x000000012054af08 id: 1, name: "T-Shirt", created_at: "2024-11-09 16:35:01.117836000 +0000", updated_at: "2024-11-09 16:35:01.117836000 +0000">
```

Bu bir `SELECT` sorgusu oluşturur, ancak `id` sütunu için aktarılan `1` ile eşleşen bir `WHERE` belirtir. Ayrıca, yalnızca tek bir kayıt döndürmek için bir `LIMIT` ekler.

Bu kez, veritabanından yalnızca tek bir kayıt aldığımız için `ActiveRecord::Relation` yerine bir `Product` örneği alıyoruz.

### Kayıtları Güncelleme

Kayıtlar 2 şekilde güncellenebilir: `update` kullanılarak veya öznitelikler atanarak ve `save` çağrısı yapılarak.

Bir Product örneği üzerinde `update` çağrısı yapabilir ve veritabanına kaydedilecek yeni özelliklerin bir Hash'ini iletebiliriz. Bu; öznitelikleri atayacak, doğrulamaları çalıştıracak ve değişiklikleri tek bir metod çağrısında veritabanına kaydedecektir.

```irb
store(dev)> product = Product.find(1)
store(dev)> product.update(name: "Shoes")
  TRANSACTION (0.1ms)  BEGIN immediate TRANSACTION /*application='Store'*/
  Product Update (0.3ms)  UPDATE "products" SET "name" = 'Shoes', "updated_at" = '2024-11-09 22:38:19.638912' WHERE "products"."id" = 1 /*application='Store'*/
  TRANSACTION (0.4ms)  COMMIT TRANSACTION /*application='Store'*/
=> true
```

This updated the name of the "T-Shirt" product to "Shoes" in the database.
Confirm this by running `Product.all` again.

```irb
store(dev)> Product.all
```

You will see two products: Shoes and Pants.

```irb
  Product Load (0.3ms)  SELECT "products".* FROM "products" /* loading for pp */ LIMIT 11 /*application='Store'*/
=>
[#<Product:0x000000012c0f7300
  id: 1,
  name: "Shoes",
  created_at: "2024-12-02 20:29:56.303546000 +0000",
  updated_at: "2024-12-02 20:30:14.127456000 +0000">,
 #<Product:0x000000012c0f71c0
  id: 2,
  name: "Pants",
  created_at: "2024-12-02 20:30:02.997261000 +0000",
  updated_at: "2024-12-02 20:30:02.997261000 +0000">]
```

Alternatively, we can assign attributes and call `save` when we're ready to
validate and save changes to the database.

"Ayakkabı" adını "T-Shirt" olarak değiştirelim.

```irb
store(dev)> product = Product.find(1)
store(dev)> product.name = "T-Shirt"
=> "T-Shirt"
store(dev)> product.save
  TRANSACTION (0.1ms)  BEGIN immediate TRANSACTION /*application='Store'*/
  Product Update (0.2ms)  UPDATE "products" SET "name" = 'T-Shirt', "updated_at" = '2024-11-09 22:39:09.693548' WHERE "products"."id" = 1 /*application='Store'*/
  TRANSACTION (0.0ms)  COMMIT TRANSACTION /*application='Store'*/
=> true
```

### Kayıtları Silme