---
layout: default
---

<style>
    h3 {
        margin-top: 18px;
    }
</style>

*Kılavuzlardaki tüm çeviriler Dilan Kaya tarafından yapılmıştır. Hata bulursanız veya katkıda bulunmak isterseniz [GitHub](https://github.com/dilankaya127/rails-tr-TR) üzerinden iletişime geçebilirsiniz.*

# Ruby on Rails Kılavuzları (v8.0.2)

Bunlar <a href="https://github.com/rails/rails/tree/v8.0.2">v8.0.2</a> tabanlı Rails 8.0 için yeni kılavuzlardır. Bu kılavuzlar, Ruby on Rails ile daha üretken olmanıza ve tüm parçaların nasıl bir araya geldiğini anlamanıza yardımcı olmak için tasarlanmıştır.

<div class="guide-alert guide-alert-info">
  <div class="guide-alert-icon">💡</div>
  <div class="guide-alert-content">
    <strong>Rails Kılavuzları <a href="https://guides.rubyonrails.org/epub/ruby_on_rails_guides_v8.0.2.epub">Kindle</a> için de mevcuttur.</strong>
  </div>
</div>

<div class="guide-alert guide-alert-warning">
  <div class="guide-alert-icon">🚧</div>
  <div class="guide-alert-content">
    <strong>Bu simgeyle işaretlenen kılavuzlar şu anda üzerinde çalışılmaktadır ve Kılavuzlar Dizini menüsünde bulunmayacaktır.</strong> Hâlâ yararlı olsalar da, eksik bilgiler ve hatta hatalar içerebilirler. Bunları inceleyerek ve yorumlarınızı ve düzeltmelerinizi yayınlayarak yardımcı olabilirsiniz.
  </div>
</div>

## Buradan Başlayın

### [Rails ile Başlarken]({% link rails/guides/getting_started.md %})

Rails'i nasıl kuracağınızı ve ilk uygulamanızı nasıl oluşturacağınızı öğrenin.

### [Ruby on Rails İndirme Kılavuzu]({% link rails/guides/install_ruby_on_rails.md %})

Ruby programlama dilini ve Ruby on Rails'i nasıl kuracağınızı öğrenin.

## Model

### [Active Record Temelleri]({% link rails/guides/active_record_basics.md %})

Active Record, modellerinizin uygulamanın veritabanıyla etkileşime girmesini sağlar. Bu kılavuz, Active Record modelleri ve veritabanına kalıcılık konusunda size başlangıç ​​sağlayacaktır.

### [Active Record Migration]({% link rails/guides/active_record_migrations.md %})

Migration'lar, veritabanı şemanızı zaman içinde geliştirmenize olanak tanıyan bir Active Record özelliğidir. Şema değişikliklerini saf SQL ile yazmak yerine, migration tablolarınızdaki değişiklikleri tanımlamak için bir Ruby DSL kullanmanıza olanak tanır.

### [Active Record Doğrulamaları]({% link rails/guides/active_record_validations.md %})

Doğrulamalar, veritabanınıza yalnızca geçerli verilerin kaydedilmesini sağlamak için kullanılır. Bu kılavuz, Active Record'un doğrulama özelliğini kullanarak nesnelerin veritabanına girmeden önce durumlarını nasıl doğrulayacağınızı öğretir.

### [Active Record Callback]({% link rails/guides/action_record_callbacks.md %})

Callback'ler; bir nesne oluşturulduğunda, güncellendiğinde, yok edildiğinde vb. çalışacak kod yazmayı mümkün kılar. Bu kılavuz size Active Record nesnelerinin bu nesne yaşam döngüsüne nasıl bağlanacağınızı öğretir.

### [Active Record İlişkileri]({% link rails/guides/association_basics.md %})

Active Record'da bir ilişki, iki Active Record modeli arasındaki bir bağlantıdır. Bu kılavuz, Active Record tarafından sağlanan tüm ilişkileri kapsar.

### [Active Record Sorgu Arayüzü]({% link rails/guides/active_record_querying.md %})

Veritabanı kayıtlarını bulmak için ham SQL kullanmak yerine, Active Record aynı işlemleri gerçekleştirmek için daha iyi yollar sağlar. Bu kılavuz, Active Record kullanarak veritabanından veri almanın farklı yollarını ele alır.

### [Active Model Temelleri]({% link rails/guides/active_model_basics.md %})

Active Model, Action Pack ile entegre olan, ancak veritabanı kalıcılığı için Active Record'a ihtiyaç duymayan yalın Ruby nesneleri oluşturmanıza olanak tanır. Active Model ayrıca Rails çerçevesi dışında kullanılmak üzere özel ORM'ler oluşturmaya da yardımcı olur. Bu kılavuz, Active Model sınıflarını kullanmaya başlamak için ihtiyacınız olan her şeyi sağlar.

## View

### [Action View Overview]({% link rails/guides/action_view_overview.md %})

Action View, web yanıtları için HTML oluşturmaktan sorumludur. Bu kılavuz Action View'e giriş niteliğindedir.

### [Layout ve Rendering]({% link rails/guides/layouts_and_rendering.md %})

Bu kılavuz; işleme ve yönlendirme, content_for bloklarını kullanma ve kısmi öğelerle çalışma gibi Action Controller ve Action View'in temel düzen özelliklerini kapsar.

### [Action View Helper]({% link rails/guides/action_view_helpers.md %})

Action View; tarihleri ​​biçimlendirmekten ve görsellere bağlantı vermekten, içeriği temizlemeye ve yerelleştirmeye kadar her şeyi halletmek için helper'lara sahiptir. Bu kılavuz, daha yaygın Action View helper'larından birkaçını tanıtmaktadır.

### [Action View Form Helper]({% link rails/guides/form_helpers.md %})

HTML formlarının yazılması ve bakımı; form kontrolü adlandırma ve çok sayıda özniteliğini ele alma ihtiyacı nedeniyle hızla sıkıcı hale gelebilir. Rails, form biçimlendirmesi oluşturmak için view helper'ları sağlayarak bu karmaşıklığı ortadan kaldırır.

## Controller

### [Action Controller]({% link rails/guides/action_controller_overview.md %})

Action Controller, Rails'teki bir web isteğinin temelidir. Bu kılavuz, denetleyicilerin nasıl çalıştığını ve uygulamanızın istek döngüsüne nasıl uyduğunu ele alır. Konular arasında denetleyici eylemlerinde parametrelere erişim, oturum ve çerez kullanımı, denetleyici geri aramaları yer almaktadır.

### [Action Controller İleri Konular]({% link rails/guides/action_controller_advanced_topics.md %})

Bu kılavuz, Rails uygulamasındaki controller'lar ile ilgili çeşitli gelişmiş konuları ele almaktadır. Bunlar arasında; siteler arası istek sahteciliğine karşı koruma, HTTP kimlik doğrulaması, veri akışı ve istisnalarla başa çıkma, log filtreleme ve daha fazlası yer almaktadır.

### [Dışarıdan İçeriye Routing]({% link rails/guides/routing.md %})

Rails router'ı, URL'leri tanır ve bunları bir controller'ın action'ına gönderir. Bu kılavuz, Rails routing'in kullanıcıya dönük özelliklerini ele alır. Kendi Rails uygulamalarınızda routing'i nasıl kullanacağınızı anlamak istiyorsanız, buradan başlayın.

## Diğer Bileşenler

### [Active Support Core Uzantılar]({% link rails/guides/active_support_core_extensions.md %})

Active Support, Ruby uzantıları ve yardımcı programları sağlar. Ruby dilini, Rails uygulamalarının geliştirilmesi ve Ruby on Rails'in kendisinin geliştirilmesi için zenginleştirir.

### [Action Mailer Temelleri]({% link rails/guides/action_mailer_basics.md %})

Bu kılavuz, uygulamanızdan e-posta göndermeye başlamak için ihtiyacınız olan her şeyi ve Action Mailer'ın birçok dahili özelliğini sağlar.

### [Action Mailbox Temelleri]({% link rails/guides/action_mailbox_basics.md %})

Bu kılavuzda Action Mailbox'ın e-posta almak için nasıl kullanılacağı anlatılmaktadır.

### [Action Text]({% link rails/guides/action_text_overview.md %})

Bu kılavuzda, zengin metin içeriğini işlemek için Action Text'in nasıl kullanılacağı açıklanmaktadır.

### [Active Job Temelleri]({% link rails/guides/active_job_basics.md %})

Active Job, arka plan işlerini bildirmek ve bunları çeşitli kuyruk backend'lerinde çalıştırmak için bir framework'tür. Bu kılavuz; arka plan işlerini oluşturmaya, kuyruğa almaya ve yürütmeye başlamak için ihtiyacınız olan her şeyi sağlar.

### [Active Storage]({% link rails/guides/active_storage_overview.md %})

Active Storage; dosyaları bir bulut depolama hizmetine yüklemeyi, yüklemeleri dönüştürmeyi ve meta verileri çıkarmayı kolaylaştırır. Bu kılavuz, dosyaların Active Record modellerinize nasıl ekleneceğini ele alır.

### [Action Cable]({% link rails/guides/action_cable_overview.md %})

Action Cable, Rails uygulamanıza WebSocket‘i sorunsuz bir şekilde entegre eder. Performans ve ölçeklenebilirliği sağlarken aynı zamanda gerçek zamanlı özelliklerin, Rails uygulamanızın geri kalanında olduğu gibi aynı stil ve formda Ruby’de yazılmasını sağlar. Bu kılavuz, Action Cable'ın nasıl çalıştığını ve gerçek zamanlı özellikler oluşturmak için WebSocket'in nasıl kullanılacağını açıklamaktadır.

## Daha Derin Konular

### [Rails Uluslararasılaştırma API]({% link rails/guides/i18n.md %})

Bu kılavuz, uygulamalarınızı nasıl uluslararasılaştıracağınızı ele alır. Uygulamanız; içeriği farklı dillere çevirebilir, çoğullaştırma kurallarını değiştirebilir, her ülke için doğru tarih biçimlerini kullanabilir, vb.

### [Rails Uygulamalarını Test Etme]({% link rails/guides/testing.md %})

Bu kılavuz, Rails'te testlerin nasıl yazılacağını inceler. Ayrıca test yapılandırmasını ele alır ve bir uygulamayı test etme yaklaşımlarını karşılaştırır.

### [Rails Uygulamalarında Hata Ayıklama]({% link rails/guides/debugging_rails_applications.md %})

Bu kılavuzda, Rails uygulamalarında nasıl hata ayıklanacağı anlatılmaktadır. Bunu başarmanın farklı yollarını ve kodunuzun "perde arkasında" neler olduğunu nasıl anlayacağınızı kapsar.

### [Rails Uygulamalarını Yapılandırma]({% link rails/guides/configuring.md %})

Bu kılavuz, bir Rails uygulaması için temel yapılandırma ayarlarını kapsar.

### [Rails Komut Satırı]({% link rails/guides/command_line.md %})

Günlük Rails kullanımınız için kesinlikle kritik olan birkaç komut vardır. Bu kılavuz Rails tarafından sağlanan komut satırı araçlarını kapsamaktadır.

### [Asset Pipeline]({% link rails/guides/asset_pipeline.md %})

Asset pipeline kılavuzu, temel asset yönetimi görevlerini yerine getiren bir framework olan Propshaft'ın nasıl kullanılacağını açıklamaktadır.

### [Rails'te JavaScript ile Çalışma]({% link rails/guides/working_with_javascript_in_rails.md %})

Bu kılavuz, JavaScript'i Rails uygulamalarına dahil etmek için import maps veya jsbundling-rails'in nasıl kullanılacağını açıklar ve Rails'te Turbo ile çalışmanın temellerini kapsar.

### [Rails Başlatma Süreci]({% link rails/guides/initialization.md %})

🚧 Bu kılavuz, Rails'teki başlatma sürecinin iç yapısını açıklar. Son derece derinlemesine bir kılavuzdur ve ileri düzey Rails geliştiricileri için önerilir.

### [Otomatik Yükleme ve Yeniden Yükleme]({% link rails/guides/autoloading_and_reloading_constants.md %})

Bu kılavuzda otomatik yükleme ve yeniden yükleme sabitlerinin nasıl çalıştığı anlatılmaktadır.

### [Active Support Instrumentation]({% link rails/guides/active_support_instrumentation.md %})

🚧 Bu kılavuz, Rails ve diğer Ruby kodları içindeki olayları ölçmek için Active Support içindeki  instrumentation API'sinin nasıl kullanılacağını açıklar.

### [API Özel Uygulamalar için Rails Kullanımı]({% link rails/guides/api_app.md %})

Bu kılavuz, JSON API uygulamasını geliştirmek için Rails'i etkili bir şekilde nasıl kullanacağınızı açıklar.

## Ürün Çıkarmak

### [Dağıtım için Performans Ayarlama]({% link rails/guides/tuning_performance_for_deployment.md %})

Bu kılavuz, üretim ortamındaki Ruby on Rails uygulamanızı dağıtmak için performans ve eşzamanlılık yapılandırmasını ele almaktadır.

### [Rails ile Önbelleğe Alma: Genel Bakış]({% link rails/guides/caching_with_rails.md %})

Bu kılavuz, Rails uygulamanızı önbelleğe alma ile hızlandırmaya yönelik bir giriş niteliğindedir.

### [Rails Uygulamalarının Güvenliğini Sağlama]({% link rails/guides/security.md %})

Bu kılavuzda web uygulamalarındaki yaygın güvenlik sorunları ve Rails ile bunlardan nasıl kaçınılacağı açıklanmaktadır.

### [Rails Uygulamalarında Hata Bildirim]({% link rails/guides/error_reporting.md %})

Bu kılavuz, Ruby on Rails uygulamalarında oluşan hataları yönetme yollarını tanıtmaktadır.

## İleri Seviye Active Record

### [Active Record ve PostgreSQL]({% link rails/guides/active_record_postgresql.md %})

🚧 Bu kılavuz, Active Record'un PostgreSQL'e özgü kullanımını kapsamaktadır.

### [Çoklu Veritabanı]({% link rails/guides/active_record_multiple_databases.md %})

Bu kılavuz, uygulamanızda birden fazla veritabanının nasıl kullanılacağını ele almaktadır.

### [Active Record Şifreleme]({% link rails/guides/active_record_encryption.md %})

🚧 Bu kılavuz, Active Record kullanarak veritabanı bilgilerinizin şifrelenmesini ele almaktadır.

### [Bileşik Birincil Anahtarlar]({% link rails/guides/active_record_composite_primary_keys.md %})

Bu kılavuz, veritabanı tabloları için bileşik birincil anahtarlara giriş niteliğindedir.

## Rails Uygulamalarını Büyütelim

### [Rails Eklentileri Oluşturmanın Temelleri]({% link rails/guides/plugins.md %})

🚧 Bu kılavuz, Rails'in işlevselliğini genişletecek bir eklentinin nasıl oluşturulacağını ele almaktadır.

### [Rack'te Rails]({% link rails/guides/rails_on_rack.md %})

Bu kılavuz, Rails'in Rack ile entegrasyonunu ve diğer Rack bileşenleriyle arayüz oluşturmayı kapsar.

### [Rails Generator ve Şablonları Oluşturma ve Özelleştirme]({% link rails/guides/generators.md %})

Bu kılavuz, uzantınıza yepyeni bir generator ekleme veya yerleşik bir Rails generator'ünün bir öğesine alternatif sağlama (iskele generator için alternatif test taslakları sağlamak gibi) sürecini kapsar.

### [Engine ile Çalışmaya Başlarken]({% link rails/guides/engines.md %})

🚧 Engine'ler, host uygulamalarına ek işlevsellik sağlayan minyatür uygulamalar olarak düşünülebilir. Bu kılavuzda kendi engine'inizi nasıl oluşturacağınızı ve onu bir host uygulamasına nasıl entegre edeceğinizi öğreneceksiniz.

### [Rails Uygulama Şablonları]({% link rails/guides/rails_application_templates.md %})

🚧 Uygulama şablonları, yeni oluşturduğunuz Rails projenize veya mevcut bir Rails projesine gem'ler, initializer'lar vb. eklemek için DSL içeren basit Ruby dosyalarıdır.

### [Rails'te İş Parçacığı Oluşturma ve Kod Yürütme]({% link rails/guides/rails_on_rack.md %})

🚧 Bu kılavuz, bir Rails uygulamasında eşzamanlılıkla doğrudan çalışırken dikkat edilmesi gereken hususları ve kullanılabilecek araçları açıklamaktadır.

## Katkıda Bulunun

### [Ruby on Rails'e Katkıda Bulunma]({% link rails/guides/contributing_ruby_on_rails.md %})

Rails "başka birinin framework'ü" değildir. Bu kılavuz, Rails'in devam eden gelişimine dahil olabileceğiniz çeşitli yolları kapsar.

### [API Dokümantasyon Yönergeleri]({% link rails/guides/api_documentation_guidelines.md %})

Bu kılavuz Ruby on Rails API dokümantasyon yönergelerini belgelemektedir.

### [Kılavuz Yönergeleri]({% link rails/guides/ruby_on_rails_guides_guidelines.md %})

Bu kılavuz Ruby on Rails kılavuzlarının yönergelerini belgelemektedir.

### [Rails Core Geliştirme Bağımlılıklarını Yükleme]({% link rails/guides/development_dependencies_install.md %})

Bu kılavuz, Ruby on Rails core geliştirme için bir ortamın nasıl kurulacağını ele almaktadır.

## Politikalar

<strong><a href="https://guides.rubyonrails.org/maintenance_policy.html">Bakım Politikası</a></strong>

Ruby on Rails'in şu anda hangi sürümlerin desteklendiğini ve yeni sürümlerin ne zaman çıkacağını buradan takip edebilirsiniz.

## Sürüm Notları

(Sürüm notlarının çevirisi yapılmayacaktır. Linkler, ilgili sürüm notlarının resmi sitesine yönlendirmektedir.)

<strong><a href="https://guides.rubyonrails.org/upgrading_ruby_on_rails.html">Ruby on Rails'i Yükseltme</a></strong>

<strong><a href="https://guides.rubyonrails.org/8_0_release_notes.html">Sürüm 8.0 - Kasım 2024</a></strong>

<strong><a href="https://guides.rubyonrails.org/7_2_release_notes.html">Sürüm 7.2 - Ağustos 2024</a></strong>

<strong><a href="https://guides.rubyonrails.org/7_1_release_notes.html">Sürüm 7.1 - Ekim 2023</a></strong>

<strong><a href="https://guides.rubyonrails.org/7_0_release_notes.html">Sürüm 7.0 - Aralık 2021</a></strong>

<strong><a href="https://guides.rubyonrails.org/6_1_release_notes.html">Sürüm 6.1 - Aralık 2020</a></strong>

<strong><a href="https://guides.rubyonrails.org/6_0_release_notes.html">Sürüm 6.0 - Ağustos 2019</a></strong>

<strong><a href="https://guides.rubyonrails.org/5_2_release_notes.html">Sürüm 5.2 - Nisan 2018</a></strong>

<strong><a href="https://guides.rubyonrails.org/5_1_release_notes.html">Sürüm 5.1 - Nisan 2017</a></strong>

<strong><a href="https://guides.rubyonrails.org/5_0_release_notes.html">Sürüm 5.0 - Haziran 2016</a></strong>

<strong><a href="https://guides.rubyonrails.org/4_2_release_notes.html">Sürüm 4.2 - Aralık 2014</a></strong>

<strong><a href="https://guides.rubyonrails.org/4_1_release_notes.html">Sürüm 4.1 - Nisan 2014</a></strong>

<strong><a href="https://guides.rubyonrails.org/4_0_release_notes.html">Sürüm 4.0 - Haziran 2013</a></strong>

<strong><a href="https://guides.rubyonrails.org/3_2_release_notes.html">Sürüm 3.2 - Ocak 2012</a></strong>

<strong><a href="https://guides.rubyonrails.org/3_1_release_notes.html">Sürüm 3.1 - Ağustos 2011</a></strong>

<strong><a href="https://guides.rubyonrails.org/3_0_release_notes.html">Sürüm 3.0 - Ağustos 2010</a></strong>

<strong><a href="https://guides.rubyonrails.org/2_3_release_notes.html">Sürüm 2.3 - Mart 2009</a></strong>

<strong><a href="https://guides.rubyonrails.org/2_2_release_notes.html">Sürüm 2.2 - Kasım 2008</a></strong>