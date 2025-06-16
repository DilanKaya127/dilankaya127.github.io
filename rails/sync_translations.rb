#!/usr/bin/env ruby
# sync_translations.rb - Rails Türkçe çevirilerini Jekyll sitesine senkronize eder

require 'fileutils'
require 'yaml'

class TranslationSyncer
  # Yolları ayarlayın
  if ENV["GITHUB_ACTIONS"]
    RAILS_REPO_PATH = "rails-tr-TR"
  else
    RAILS_REPO_PATH = "../../rails-tr-TR"
  end
  # RAILS_REPO_PATH = "../../rails-tr-TR" # Rails fork'unuzun yolu
  RAILS_TR_PATH = "#{RAILS_REPO_PATH}/guides/source/tr-TR"
  JEKYLL_GUIDES_PATH = "./guides"
  DATA_PATH = "./_data"
  RAILS_ASSETS_PATH = "#{RAILS_REPO_PATH}/guides/assets/images"
  JEKYLL_ASSETS_PATH = "../assets/images/rails"
  
  def initialize
    validate_paths
    ensure_directories
  end

  def sync_all
    puts "🔄 Türkçe çeviriler senkronize ediliyor..."
    
    synced_files = sync_turkish_guides
    synced_assets = sync_assets
    
    if synced_files.any?
      puts "\n✅ Senkronize edilen dosyalar:"
      synced_files.each { |file| puts "   - #{file}" }
      
      update_guides_data
      puts "\n📝 Kılavuz verileri güncellendi"
    else
      puts "ℹ️  Senkronize edilecek yeni dosya bulunamadı"
    end

    if synced_files.any? || synced_assets.any?
      puts "\n✅ Senkronize edilen dosyalar:"
      synced_files.each { |file| puts "   - guides/#{file}" }
      synced_assets.each { |file| puts "   - assets/#{file}" }
  
      update_guides_data
      puts "\n📝 Kılavuz verileri güncellendi"
    else
      puts "ℹ️  Senkronize edilecek yeni dosya bulunamadı"
    end
  end

  

  def sync_turkish_guides
    puts "\n🇹🇷 Türkçe çeviriler kontrol ediliyor..."
    synced_files = []
    
    if Dir.exist?(RAILS_TR_PATH)
      Dir.glob("#{RAILS_TR_PATH}/*.md").each do |source_file|
        filename = File.basename(source_file)
        destination = "#{JEKYLL_GUIDES_PATH}/#{filename}"
        
        if sync_file(source_file, destination)
          synced_files << filename
        end
      end
    else
      puts "⚠️  Türkçe çeviri klasörü bulunamadı: #{RAILS_TR_PATH}"
    end
    
    synced_files
  end

  def sync_assets
    puts "\n🖼️  Asset dosyaları kontrol ediliyor..."
    synced_assets = []
  
    if Dir.exist?(RAILS_ASSETS_PATH)
      sync_directory_recursive(RAILS_ASSETS_PATH, JEKYLL_ASSETS_PATH, synced_assets)
    else
      puts "⚠️  Asset klasörü bulunamadı: #{RAILS_ASSETS_PATH}"
    end
  
    synced_assets
  end

  def sync_directory_recursive(source_dir, dest_dir, synced_files, relative_path = "")
    FileUtils.mkdir_p(dest_dir)
  
    Dir.entries(source_dir).each do |item|
      next if item == '.' || item == '..'
    
      source_item = File.join(source_dir, item)
      dest_item = File.join(dest_dir, item)
      current_relative = relative_path.empty? ? item : File.join(relative_path, item)
    
      if File.directory?(source_item)
        sync_directory_recursive(source_item, dest_item, synced_files, current_relative)
      elsif File.file?(source_item)
        if sync_binary_file(source_item, dest_item)
          synced_files << current_relative
        end
      end
    end
  end

  def sync_binary_file(source, destination)
    return false unless File.exist?(source)
  
    # Binary dosyalar için checksum karşılaştırması
    if !File.exist?(destination) || file_checksum(source) != file_checksum(destination)
      FileUtils.cp(source, destination)
      puts "   ✅ #{File.basename(destination)} güncellendi"
      return true
    end
  
    false
  end

  def file_checksum(file_path)
    require 'digest'
    Digest::MD5.hexdigest(File.read(file_path, mode: 'rb'))
  end

  def sync_file(source, destination)
    return false unless File.exist?(source)
    
    content = File.read(source, encoding: 'UTF-8')
    processed_content = process_content(content, File.basename(source, '.md'))
    
    if !File.exist?(destination) || File.read(destination, encoding: 'UTF-8') != processed_content
      File.write(destination, processed_content, encoding: 'UTF-8')
      puts "   ✅ #{File.basename(destination)} güncellendi"
      return true
    end
    
    false
  end

  def process_content(content, guide_name)
    # Front matter regex'i
    front_matter_regex = /\A---\s*\n.*?\n---\s*\n/m

    if content =~ front_matter_regex
      # Mevcut front matter'ı işle
      match = content.match(front_matter_regex)
      existing_front_matter = match[0].sub(/\A---\s*\n/, '').sub(/\n---\s*\n\z/, '')
      body = content[match[0].length..-1]

      begin
        yaml_data = YAML.safe_load(existing_front_matter) || {}
        yaml_data = enhance_front_matter(yaml_data, guide_name)

        new_front_matter = yaml_data.to_yaml.strip.sub(/\A---\n/, '')
        return "---\n#{new_front_matter}\n---\n\n#{body.lstrip}"
      rescue => e
        puts "   ⚠️  YAML parse hatası #{guide_name}.md için: #{e.message}"
        return content
      end
    else
      # Front matter oluştur
      yaml_data = create_front_matter(guide_name)
      front_matter = yaml_data.to_yaml.strip.sub(/\A---\n/, '')
      return "---\n#{front_matter}\n---\n\n#{content.lstrip}"
    end
  end

  def enhance_front_matter(yaml_data, guide_name)
    yaml_data['layout'] = 'guide'
    yaml_data['guide_id'] = guide_name
    yaml_data['title'] ||= get_turkish_title(guide_name)
    yaml_data['description'] ||= generate_description(guide_name)
    yaml_data['last_updated'] = Time.now.strftime('%Y-%m-%d')
    yaml_data['translation'] = true
    yaml_data['original_file'] = "#{guide_name}.md"
    
    yaml_data
  end

  def create_front_matter(guide_name)
    {
      'layout' => 'guide',
      'guide_id' => guide_name,
      'title' => get_turkish_title(guide_name),
      'description' => generate_description(guide_name),
      'last_updated' => Time.now.strftime('%Y-%m-%d'),
      'translation' => true,
      'original_file' => "#{guide_name}.md"
    }
  end

  def get_turkish_title(guide_name)
    # Türkçe başlık çevirileri
    titles = {
      'getting_started' => 'Rails ile Başlarken',
      'active_record_basics' => 'Active Record Temelleri',
      'active_record_migrations' => 'Active Record Migrasyonları',
      'active_record_validations' => 'Active Record Doğrulamaları',
      'active_record_callbacks' => 'Active Record Callback\'leri',
      'active_record_associations' => 'Active Record İlişkileri',
      'active_record_querying' => 'Active Record Sorgu Arayüzü',
      'action_controller_overview' => 'Action Controller\'a Genel Bakış',
      'routing' => 'Rails Yönlendirme',
      'action_view_overview' => 'Action View\'a Genel Bakış',
      'layouts_and_rendering' => 'Düzenler ve Rendering',
      'action_view_helpers' => 'Action View Yardımcıları',
      'action_cable_overview' => 'Action Cable\'a Genel Bakış',
      'testing' => 'Rails Uygulamalarını Test Etme',
      'security' => 'Rails Güvenlik Kılavuzu',
      'configuring' => 'Rails Uygulamalarını Yapılandırma',
      'api_app' => 'Rails API Uygulamaları',
      'active_job_basics' => 'Active Job Temelleri',
      'command_line' => 'Rails Komut Satırı',
      'asset_pipeline' => 'Asset Pipeline',
      'autoloading_and_reloading_constants' => 'Sabit Yükleme ve Yeniden Yükleme',
      'caching_with_rails' => 'Rails ile Önbellekleme',
      'debugging_rails_applications' => 'Rails Uygulamalarında Hata Ayıklama',
      'form_helpers' => 'Form Yardımcıları',
      'engines' => 'Rails Engine\'ları'
    }
    
    titles[guide_name] || guide_name.split('_').map(&:capitalize).join(' ')
  end

  def generate_description(guide_name)
    title = get_turkish_title(guide_name)
    "#{title} konusunu detaylı olarak ele alan Rails kılavuzu."
  end

  def update_guides_data
    puts "\n📊 Kılavuz verileri hazırlanıyor..."
    
    guides_data = {
      'updated_at' => Time.now.strftime('%Y-%m-%d %H:%M:%S'),
      'total_guides' => 0,
      'completed_guides' => 0,
      'guides' => []
    }
    
    # Türkçe çeviri dosyalarını tara
    tr_files = Dir.glob("#{JEKYLL_GUIDES_PATH}/*.md").map { |f| File.basename(f, '.md') }
    
    # Tüm olası kılavuzları kontrol et (başlık listesinden)
    all_possible_guides = get_all_guide_names
    
    all_possible_guides.each do |guide_name|
      has_translation = tr_files.include?(guide_name)
      
      guide_info = {
        'id' => guide_name,
        'title' => get_turkish_title(guide_name),
        'description' => generate_description(guide_name),
        'url' => "/rails/guides/#{guide_name}.html",
        'status' => has_translation ? 'completed' : 'pending',
        'has_translation' => has_translation
      }
      
      if has_translation
        # Dosya bilgilerini ekle
        file_path = "#{JEKYLL_GUIDES_PATH}/#{guide_name}.md"
        if File.exist?(file_path)
          guide_info['last_updated'] = File.mtime(file_path).strftime('%Y-%m-%d')
          
          # Front matter'dan ek bilgi al
          content = File.read(file_path, encoding: 'UTF-8')
          if content =~ /\A---\s*\n.*?\n---\s*\n/m
            begin
              yaml_data = YAML.safe_load(content.match(/\A---\s*\n(.*?)\n---\s*\n/m)[1])
              guide_info['title'] = yaml_data['title'] if yaml_data['title']
              guide_info['description'] = yaml_data['description'] if yaml_data['description']
            rescue
              # YAML parse hatası durumunda varsayılan değerleri kullan
            end
          end
        end
      end
      
      guides_data['guides'] << guide_info
    end
    
    # İstatistikleri güncelle
    guides_data['completed_guides'] = guides_data['guides'].count { |g| g['has_translation'] }
    guides_data['total_guides'] = guides_data['guides'].length
    
    # Verileri dosyaya yaz
    FileUtils.mkdir_p(DATA_PATH)
    File.write("#{DATA_PATH}/guides.yml", guides_data.to_yaml, encoding: 'UTF-8')
    
    progress = guides_data['total_guides'] > 0 ? 
      (guides_data['completed_guides'] * 100.0 / guides_data['total_guides']).round(1) : 0
    
    puts "   📈 İstatistikler:"
    puts "      • Toplam kılavuz: #{guides_data['total_guides']}"
    puts "      • Çevrilen: #{guides_data['completed_guides']}"
    puts "      • İlerleme: %#{progress}"
  end

  def get_all_guide_names
    # Rails kılavuzlarının tam listesi
    [
      'getting_started',
      'active_record_basics',
      'active_record_migrations',
      'active_record_validations',
      'active_record_callbacks',
      'active_record_associations',
      'active_record_querying',
      'action_controller_overview',
      'routing',
      'action_view_overview',
      'layouts_and_rendering',
      'action_view_helpers',
      'form_helpers',
      'action_controller_callbacks',
      'action_cable_overview',
      'testing',
      'security',
      'debugging_rails_applications',
      'configuring',
      'command_line',
      'asset_pipeline',
      'engines',
      'i18n',
      'api_app',
      'active_job_basics',
      'active_storage_overview',
      'action_mailbox_basics',
      'action_text_overview',
      'caching_with_rails',
      'autoloading_and_reloading_constants'
    ]
  end

  def watch_mode
    puts "👀 İzleme modu başlatıldı..."
    puts "Rails çevirilerinde değişiklik olduğunda otomatik senkronize edilecek"
    puts "Çıkmak için Ctrl+C"
    
    last_sync = Time.now
    
    begin
      loop do
        changes = check_for_changes(last_sync)
        
        if changes.any?
          puts "\n🔄 Değişiklik tespit edildi: #{changes.join(', ')}"
          sync_all
          last_sync = Time.now
        end
        
        sleep 2
      end
    rescue Interrupt
      puts "\n\n👋 İzleme modu sonlandırıldı"
    end
  end

  private

  def validate_paths
    unless Dir.exist?(RAILS_REPO_PATH)
      puts "❌ Rails repository bulunamadı: #{RAILS_REPO_PATH}"
      puts "   Rails-tr-TR repository'sini klonladığınızdan emin olun"
      puts "   Örnek: git clone https://github.com/DilanKaya127/rails-tr-TR.git ../rails-tr-TR"
      exit 1
    end

    unless Dir.exist?(RAILS_TR_PATH)
      puts "❌ Türkçe çeviri klasörü bulunamadı: #{RAILS_TR_PATH}"
      puts "   rails-tr-TR/guides/source/tr-TR klasörünü oluşturun ve çevirileri ekleyin"
      exit 1
    end
  end

  def ensure_directories
    FileUtils.mkdir_p(JEKYLL_GUIDES_PATH)
    FileUtils.mkdir_p(DATA_PATH)
    FileUtils.mkdir_p(JEKYLL_ASSETS_PATH)
  end

  def check_for_changes(since_time)
    changes = []
    
    # Türkçe dosyalardaki değişiklikleri kontrol et
    if Dir.exist?(RAILS_TR_PATH)
      Dir.glob("#{RAILS_TR_PATH}/*.md").each do |file|
        if File.mtime(file) > since_time
          changes << File.basename(file)
        end
      end
    end

    # Asset dosyalarındaki değişiklikleri kontrol et
    if Dir.exist?(RAILS_ASSETS_PATH)
      Dir.glob("#{RAILS_ASSETS_PATH}/**/*").each do |file|
        if File.file?(file) && File.mtime(file) > since_time
          relative_path = file.sub("#{RAILS_ASSETS_PATH}/", '')
          changes << "assets/#{relative_path}"
        end
      end
    end
    
    changes
  end
end

# Script kullanımı
if ARGV.empty?
  puts <<~USAGE
    🔄 Rails Türkçe Çeviri Senkronizasyon Aracı

    Kullanım:
      ruby sync_translations.rb <komut>

    Komutlar:
      sync     - Türkçe çevirileri senkronize et
      watch    - Değişiklikleri izle ve otomatik senkronize et
      status   - Çeviri durumunu göster

    Örnekler:
      ruby sync_translations.rb sync
      ruby sync_translations.rb watch
      ruby sync_translations.rb status
  USAGE
  exit
end

syncer = TranslationSyncer.new

case ARGV[0]
when 'sync'
  syncer.sync_all
when 'watch'
  syncer.watch_mode
when 'status'
  syncer.update_guides_data
  puts "✅ Durum raporu _data/guides.yml dosyasında güncellendi"
else
  puts "❌ Bilinmeyen komut: #{ARGV[0]}"
  puts "Yardım için: ruby sync_translations.rb"
end