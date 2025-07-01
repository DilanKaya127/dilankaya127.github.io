---
layout: guide
guide_id: action_controller_overview
title: Action Controller'a Genel Bakış
description: Action Controller'a Genel Bakış konusunu detaylı olarak ele alan Rails
  kılavuzu.
last_updated: '2025-07-01'
translation: true
original_file: action_controller_overview.md
---

**RESMİ KILAVUZA BU ADRES ÜZERİNDEN ULAŞABİLİRSİNİZ: <https://guides.rubyonrails.org>**

--------------------------------------------------------------------------------

Action Controller
=================

Bu kılavuzda, Controller'ın nasıl çalıştığını ve uygulamanızdaki istek döngüsüne nasıl uyum sağladığını öğreneceksiniz.

Bu kılavuzu okuduktan sonra şunları yapmayı öğreneceksiniz:

* Bir controller aracılığıyla isteğin akışını takip etmeyi
* Controller'ınıza aktarılan parametrelere erişmeyi
* Strong Parameters ve izin değerleri kullanmayı
* Verileri çerez, oturum ve flash'te depolamayı
* İstek işleme sırasında kodu yürütmek için action callback'leriyle çalışmayı
* İstek ve Yanıt Nesnelerini kullanmayı

Giriş
-----

Action Controller, Model View Controller ([MVC](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller)) desenindeki C'dir. [Router](../routing/); bir controller'ı gelen bir istekle eşleştirdikten sonra, controller isteği işlemekten ve uygun çıktıyı üretmekten sorumludur.

Çoğu geleneksel [RESTful] (https://en.wikipedia.org/wiki/Representational_state_transfer) uygulamasında, controller isteği alır, bir modelden veri getirir veya kaydeder ve HTML çıktısı oluşturmak için bir view kullanır.

Bir controller'ın model ve view arasında yer aldığını düşünebilirsiniz. Controller, model verilerini view için kullanılabilir hale getirir, böylece view bu verileri kullanıcıya gösterebilir. Controller ayrıca view'den kullanıcı girdisi alır ve model verilerini buna göre kaydeder veya günceller.

Controller Oluşturma
---------------------

Bir controller, `ApplicationController`'dan miras alan ve diğer sınıflar gibi metotlara sahip bir Ruby sınıfıdır. Gelen bir istek router tarafından bir controller ile eşleştirildiğinde, Rails o controller sınıfının bir örneğini oluşturur ve action ile aynı isme sahip metodu çağırır.

```ruby
class ClientsController < ApplicationController
  def new
  end
end
```

Yukarıdaki `ClientsController` göz önüne alındığında, bir kullanıcı yeni bir client eklemek için uygulamanızda `/clients/new` adresine giderse, Rails `ClientsController`'ın bir örneğini oluşturacak ve `new` metodunu çağıracaktır. Eğer `new` metodu boşsa, Rails varsayılan olarak otomatik olarak `new.html.erb` view'ini render edecektir.

NOT: Buradaki `new` metodu, `ClientsController`'ın bir örneği üzerinde çağrılan bir instance metodudur. Bu, `new` sınıf metodu (yani `ClientsController.new`) ile karıştırılmamalıdır.

`new` metodunda, controller tipik olarak `Client` modelinin bir örneğini oluşturur ve bunu view'da `@client` adlı bir instance variable olarak kullanılabilir hale getirir:

```ruby
def new
  @client = Client.new
end
```

<div class="guide-alert guide-alert-warning">
  <div class="guide-alert-icon">📝</div>
  <div class="guide-alert-content">
    Tüm controller'lar <code>ApplicationController</code>'dan miras alır, o da <a href="https://api.rubyonrails.org/classes/ActionController/Base.html">ActionController::Base</a>'den miras alır. <a href="https://guides.rubyonrails.org/api_app.html">Yalnızca API</a> uygulamaları için <code>ApplicationController</code> <a href="https://edgeapi.rubyonrails.org/classes/ActionController/API.html">ActionController::API</a>'dan miras alır.
  </div>
</div>

### Controller İsimlendirme Kuralı

Rails, controller adındaki kaynağın çoğul yapılmasını tercih eder. Örneğin, `ClientController` yerine `ClientsController` ve `SiteAdminController` veya `SitesAdminsController` yerine `SiteAdminsController` tercih edilir. Ancak, çoğul isimler kesinlikle gerekli değildir (örneğin `ApplicationController`).

Bu isimlendirme kuralını takip etmek, [varsayılan route generator'larını](../routing/#crud-eylemleri-ve-action-ları) (örneğin `resources`) [:controller](../routing/#kullanılacak-bir-controlller-i-belirtme) gibi seçeneklerle nitelendirmeye gerek kalmadan kullanmanıza olanak tanır. Bu kural ayrıca isimlendirilmiş route helper'larını uygulama boyunca tutarlı hale getirir.

Controller isimlendirme kuralı modellerden farklıdır. Controller isimleri için çoğul isimler tercih edilirken, [model isimleri](../active_record_basics/#isimlendirme-kurallari) için tekil form tercih edilir (örneğin `Accounts` yerine `Account`).

Controller action'ları `public` olmalıdır, çünkü yalnızca `public` metotlar action olarak çağrılabilir. Action olmaya yönelik _olmayan_ yardımcı metotların görünürlüğünü (`private` veya `protected` ile) düşürmek de iyi bir yöntemdir.

<div class="guide-alert guide-alert-danger">
  <div class="guide-alert-icon">❗</div>
  <div class="guide-alert-content">
    Bazı metod isimleri Action Controller tarafından rezerve edilmiştir. Bunları yanlışlıkla yeniden tanımlamak <code>SystemStackError</code> ile sonuçlanabilir. Controller'larınızı yalnızca RESTful <a href="../routing/#kaynak-routing-rails-varsayilan">Resource Routing</a> action'larıyla sınırlandırırsanız bu konuda endişelenmenize gerek olmaz.
  </div>
</div>

<div class="guide-alert guide-alert-warning">
  <div class="guide-alert-icon">📝</div>
  <div class="guide-alert-content">
    Rezerve edilmiş bir metodu action adı olarak kullanmanız gerekiyorsa geçici bir çözüm olarak şunu yapabilirsiniz: Rezerve edilmiş metot adını, rezerve edilmemiş action metodunuza eşlemek için özel bir route kullanabilirsiniz.
  </div>
</div>

Parametreler
------------

Gelen istek tarafından gönderilen veriler, controller'ınızda [`params`](https://api.rubyonrails.org/classes/ActionController/StrongParameters.html#method-i-params) hash'inde mevcuttur. İki tür parametre verisi vardır:

- URL'in bir parçası olarak gönderilen query string parametreleri (örneğin, `http://example.com/accounts?filter=free` adresindeki `?`'den sonra).
- Bir HTML formundan gönderilen POST parametreleri.

Rails query string parametreleri ile POST parametreleri arasında ayrım yapmaz; her ikisi de controller'ınızdaki `params` hash'inde mevcuttur. Örneğin:

```ruby
class ClientsController < ApplicationController
  # Bu action "/clients?status=activated" URL'inden HTTP GET isteği ile
  # query string parametrelerini alır
  def index
    if params[:status] == "activated"
      @clients = Client.activated
    else
      @clients = Client.inactivated
    end
  end

  # Bu action "/clients" URL'ine POST isteği ile request body'sindeki 
  # form verilerinden parametreleri alır.
  def create
    @client = Client.new(params[:client])
    if @client.save
      redirect_to @client
    else
      render "new"
    end
  end
end
```

<div class="guide-alert guide-alert-warning">
  <div class="guide-alert-icon">📝</div>
  <div class="guide-alert-content">
    <code>params</code> hash'i sıradan bir Ruby Hash değildir; bunun yerine bir <a href="https://api.rubyonrails.org/classes/ActionController/Parameters.html">ActionController::Parameters</a> nesnesidir. Hash'ten miras almaz, ancak çoğunlukla Hash gibi davranır. <code>params</code>'ı filtrelemek için metotlar sağlar ve bir Hash'ten farklı olarak <code>:foo</code> ve <code>"foo"</code> anahtarları aynı kabul edilir.
  </div>
</div>

### Hash ve Array Parametreleri

`params` hash'i tek boyutlu anahtarlar ve değerlerle sınırlı değildir. İç içe array'ler ve hash'ler içerebilir. Bir değer array'i göndermek için, anahtar adının sonuna boş bir çift köşeli parantez `[]` ekleyin:

```
GET /users?ids[]=1&ids[]=2&ids[]=3
```

<div class="guide-alert guide-alert-warning">
  <div class="guide-alert-icon">📝</div>
  <div class="guide-alert-content">
     <code>[</code> ve <code>]</code> karakterleri URL'lerde izin verilmediği için bu örnekteki gerçek URL <code>/users?ids%5b%5d=1&ids%5b%5d=2&ids%5b%5d=3</code> olarak kodlanacaktır. Çoğu zaman bu konuda endişelenmenize gerek yoktur çünkü tarayıcı bunu sizin için kodlayacak ve Rails otomatik olarak decode edecektir, ancak bu istekleri sunucuya manuel olarak göndermeniz gerekirse bunu aklınızda bulundurmalısınız.
  </div>
</div>

`params[:ids]`'in değeri `["1", "2", "3"]` array'i olacaktır. Parametre değerlerinin her zaman string olduğuna dikkat edin; Rails türü tahmin etmeye veya cast etmeye çalışmaz.

<div class="guide-alert guide-alert-warning">
  <div class="guide-alert-icon">📝</div>
  <div class="guide-alert-content">
    <code>params</code>'taki <code>[nil]</code> veya <code>[nil, nil, ...]</code> gibi değerler güvenlik nedenleriyle varsayılan olarak <code>[]</code> ile değiştirilir. Daha fazla bilgi için <a href="../security/#guvenli-olmayan-sorgu-olusturma">Güvenlik Rehberi</a>'ne bakın.
  </div>
</div>

Bir hash göndermek için, anahtar adını köşeli parantezlerin içine dahil edersiniz:

```html
<form accept-charset="UTF-8" action="/users" method="post">
  <input type="text" name="user[name]" value="Acme" />
  <input type="text" name="user[phone]" value="12345" />
  <input type="text" name="user[address][postcode]" value="12345" />
  <input type="text" name="user[address][city]" value="Carrot City" />
</form>
```

Bu form gönderildiğinde, `params[:user]`'ın değeri `{ "name" => "Acme", "phone" => "12345", "address" => { "postcode" => "12345", "city" => "Carrot City" } }` olacaktır. `params[:user][:address]`'teki iç içe hash'e dikkat edin.

`params` nesnesi bir Hash gibi davranır, ancak anahtar olarak sembolleri ve string'leri birbirinin yerine kullanmanıza izin verir.

### Bileşik Anahtar Parametreleri

[Bileşik anahtar (composite key) parametreleri](../active_record_composite_primary_keys/) bir ayırıcı (örneğin, alt çizgi) ile ayrılmış bir parametrede birden fazla değer içerir. Bu nedenle, Active Record'a geçirebilmek için her değeri çıkarmanız gerekir. Bunu yapmak için `extract_value` metodunu kullanabilirsiniz.

Örneğin, aşağıdaki controller göz önüne alındığında:

```ruby
class BooksController < ApplicationController
  def show
    # URL parametrelerinden composite ID değerini çıkar.
    id = params.extract_value(:id)
    @book = Book.find(id)
  end
end
```

Ve bu route:

```ruby
get "/books/:id", to: "books#show"
```

Bir kullanıcı `/books/4_2` URL'ine istek gönderdiğinde controller, bileşik anahtar değeri `["4", "2"]`'yi çıkaracak ve `Book.find`'a geçecektir. `extract_value` metodu herhangi bir sınırlandırılmış parametreden array'leri çıkarmak için kullanılabilir.

### JSON Parametreleri

Eğer uygulamanız bir API sunarsa, muhtemelen parametreleri JSON formatında kabul edeceksiniz. İsteğinizin `content-type` header'ı `application/json` olarak ayarlanmışsa, Rails parametrelerinizi otomatik olarak `params` hash'ine yükleyecektir ve normalde yaptığınız gibi bunlara erişebilirsiniz.

Örneğin, bu JSON içeriğini gönderiyorsanız:

```json
{ "user": { "name": "acme", "address": "123 Carrot Street" } }
```

Controller'ınız şunu alacaktır:

```ruby
{ "user" => { "name" => "acme", "address" => "123 Carrot Street" } }
```

#### Wrap Parametre Yapılandırması

JSON parametrelerine otomatik olarak controller adını ekleyen [Wrap Parameters][] kullanabilirsiniz. Örneğin, root `:user` anahtar öneki olmadan aşağıdaki JSON'u gönderebilirsiniz:

```json
{ "name": "acme", "address": "123 Carrot Street" }
```

Bu veriyi `UsersController`'a gönderdiğinizi varsayarak, JSON şu şekilde `:user` anahtarı içinde sarmalanacaktır:

```ruby
{ name: "acme", address: "123 Carrot Street", user: { name: "acme", address: "123 Carrot Street" } }
```

NOT: Wrap Parameters, controller adıyla aynı olan bir anahtar içinde hash'e parametrelerin bir klonunu ekler. Sonuç olarak, hem parametrelerin orijinal versiyonu hem de "sarmalanmış" versiyonu params hash'inde bulunacaktır.

Bu özellik, controller'ınızın adına dayalı olarak seçilen bir anahtarla parametreleri klonlar ve sarmalar. Varsayılan olarak `true` olarak yapılandırılmıştır. Parametreleri sarmalamasını istemiyorsanız bunu `false` olarak [yapılandırabilirsiniz](../configuring/config-action-controller-wrap-parameters-by-default).

```ruby
config.action_controller.wrap_parameters_by_default = false
```

Ayrıca anahtarın adını veya sarmalamak istediğiniz belirli parametreleri özelleştirebilirsiniz, daha fazla bilgi için [API dokümantasyonu](https://api.rubyonrails.org/classes/ActionController/ParamsWrapper.html)'na bakın.

[Wrap Parameters]:
    https://api.rubyonrails.org/classes/ActionController/ParamsWrapper/Options/ClassMethods.html#method-i-wrap_parameters

### Routing Parameters

`routes.rb` dosyasındaki route bildirimin bir parçası olarak belirtilen parametreler de `params` hash'inde kullanılabilir hale getirilir. Örneğin, bir client için `:status` parametresini yakalayan bir route ekleyebiliriz:

```ruby
get "/clients/:status", to: "clients#index", foo: "bar"
```

Bir kullanıcı `/clients/active` URL'ine gittiğinde, `params[:status]` "active" olarak ayarlanacaktır. Bu route kullanıldığında, `params[:foo]` da sanki query string'de geçirilmiş gibi "bar" olarak ayarlanacaktır.

Route bildirimi tarafından tanımlanan `:id` gibi diğer parametreler de kullanılabilir olacaktır.

NOT: Yukarıdaki örnekte, controller'ınız ayrıca `params[:action]`'ı "index" ve `params[:controller]`'ı "clients" olarak alacaktır. `params` hash'i her zaman `:controller` ve `:action` anahtarlarını içerecektir, ancak bu değerlere erişmek için [`controller_name`][] ve [`action_name`][] metotlarını kullanmanız önerilir.

[`controller_name`]:
    https://api.rubyonrails.org/classes/ActionController/Metal.html#method-i-controller_name
[`action_name`]:
    https://api.rubyonrails.org/classes/AbstractController/Base.html#method-i-action_name

### `default_url_options` Metodu

Controller'ınızda `default_url_options` adlı bir metod tanımlayarak [`url_for`](https://api.rubyonrails.org/classes/ActionView/RoutingUrlFor.html#method-i-url_for) için global varsayılan parametreler ayarlayabilirsiniz. Örneğin:

```ruby
class ApplicationController < ActionController::Base
  def default_url_options
    { locale: I18n.locale }
  end
end
```

Belirtilen varsayılanlar URL'ler oluşturulurken başlangıç noktası olarak kullanılacaktır. `url_for`'a veya `posts_path` gibi herhangi bir path helper'a geçirilen seçenekler tarafından geçersiz kılınabilirler. Örneğin, `locale: I18n.locale` ayarlayarak, Rails otomatik olarak her URL'e locale'i ekleyecektir:

```ruby
posts_path # => "/posts?locale=en"
```

Gerekirse bu varsayılanı yine de geçersiz kılabilirsiniz:

```ruby
posts_path(locale: :fr) # => "/posts?locale=fr"
```

NOT: Perde arkasında, `posts_path` uygun parametrelerle `url_for` çağırmanın kısaltmasıdır.

Yukarıdaki örnekte olduğu gibi `ApplicationController`'da `default_url_options` tanımlarsanız, bu varsayılanlar tüm URL oluşturma işlemleri için kullanılacaktır. Metod ayrıca belirli bir controller'da da tanımlanabilir, bu durumda yalnızca o controller için oluşturulan URL'lere uygulanır.

Belirli bir istekte, metod gerçekte oluşturulan her URL için çağrılmaz. Performans nedenleriyle döndürülen hash istek başına önbelleğe alınır.