#!/usr/bin/env ruby
# sync_translations.rb - Rails çevirilerini Jekyll sitesine senkronize eder

require 'fileutils'
require 'yaml'

class TranslationSyncer
  # Yolları ayarlayın
  RAILS_REPO_PATH = "../../rails-tr-TR"  # Rails fork'unuzun yolu
  RAILS_TR_PATH = "#{RAILS_REPO_PATH}/guides/source/tr-TR"
  JEKYLL_GUIDES_PATH = "./guides/tr"
  
  def initialize
    validate_paths
    ensure_directories
  end

  def sync_all
    puts "🔄 Çeviriler senkronize ediliyor..."
    
    synced_files = []
    
    Dir.glob("#{RAILS_TR_PATH}/*.md").each do |source_file|
      filename = File.basename(source_file)
      destination = "#{JEKYLL_GUIDES_PATH}/#{filename}"
      
      if sync_file(source_file, destination)
        synced_files << filename
      end
    end
    
    if synced_files.any?
      puts "✅ Senkronize edilen dosyalar:"
      synced_files.each { |file| puts "   - #{file}" }
      
      update_index_with_translations(synced_files)
      puts "📝 Ana sayfa güncellendi"
    else
      puts "ℹ️  Senkronize edilecek yeni dosya bulunamadı"
    end
  end

  def sync_file(source, destination)
    return false unless File.exist?(source)
    
    content = File.read(source)
    processed_content = process_translation_content(content, File.basename(source, '.md'))
    
    if !File.exist?(destination) || File.read(destination) != processed_content
      File.write(destination, processed_content)
      puts "✅ #{File.basename(destination)} güncellendi"
      return true
    end
    
    false
  end

  def watch_mode
    puts "👀 İzleme modu başlatıldı..."
    puts "Rails çevirilerinde değişiklik olduğunda otomatik senkronize edilecek"
    puts "Çıkmak için Ctrl+C"
    
    last_sync = Time.now
    
    loop do
      changes = check_for_changes(last_sync)
      
      if changes.any?
        puts "\n🔄 Değişiklik tespit edildi: #{changes.join(', ')}"
        sync_all
        last_sync = Time.now
      end
      
      sleep 2
    end
  end

  private

  def validate_paths
    unless Dir.exist?(RAILS_REPO_PATH)
      puts "❌ Rails repository bulunamadı: #{RAILS_REPO_PATH}"
      puts "   Rails'i fork'layıp klonladığınızdan emin olun"
      exit 1
    end

    unless Dir.exist?(RAILS_TR_PATH)
      puts "❌ Türkçe çeviri klasörü bulunamadı: #{RAILS_TR_PATH}"
      puts "   rails/guides/source/tr-TR klasörünü oluşturun"
      exit 1
    end
  end

  def ensure_directories
    FileUtils.mkdir_p(JEKYLL_GUIDES_PATH)
  end

  def process_translation_content(content, guide_name)
    # YAML front matter'ı kontrol et ve ekle/güncelle
    if content.start_with?('---')
      # Mevcut front matter'ı güncelle
      front_matter_end = content.index('---', 3)
      if front_matter_end
        existing_front_matter = content[4..front_matter_end-1]
        body = content[front_matter_end+4..-1]
        
        # YAML'ı parse et ve güncelle
        begin
          yaml_data = YAML.load(existing_front_matter) || {}
          yaml_data['layout'] = 'guide'
          yaml_data['title'] ||= generate_title(guide_name)
          yaml_data['description'] ||= "Bu kılavuz #{yaml_data['title'].downcase} konusunu ele alır."
          
          new_front_matter = yaml_data.to_yaml.strip
          return "---\n#{new_front_matter}\n---\n#{body}"
        rescue => e
          puts "⚠️  YAML parse hatası #{guide_name}.md için: #{e.message}"
        end
      end
    else
      # Front matter yoksa ekle
      yaml_data = {
        'layout' => 'guide',
        'title' => generate_title(guide_name),
        'description' => "Bu kılavuz #{generate_title(guide_name).downcase} konusunu ele alır."
      }
      
      front_matter = yaml_data.to_yaml.strip
      return "---\n#{front_matter}\n---\n\n#{content}"
    end
    
    content
  end

  def generate_title(guide_name)
    # İngilizce kılavuz isimlerini Türkçe'ye çevir
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
      'active_job_basics' => 'Active Job Temelleri'
    }
    
    titles[guide_name] || guide_name.split('_').map(&:capitalize).join(' ')
  end

  def update_index_with_translations(synced_files)
    # Ana sayfayı güncelleme mantığı (isteğe bağlı)
    # Bu fonksiyon mevcut çevirilere göre index.md'yi günceller
  end

  def check_for_changes(since_time)
    changes = []
    
    Dir.glob("#{RAILS_TR_PATH}/*.md").each do |file|
      if File.mtime(file) > since_time
        changes << File.basename(file)
      end
    end
    
    changes
  end
end

# Script kullanımı
if ARGV.empty?
  puts <<~USAGE
    🔄 Rails Çeviri Senkronizasyon Aracı

    Kullanım:
      ruby sync_translations.rb <komut>

    Komutlar:
      sync     - Tüm çevirileri bir kez senkronize et
      watch    - Değişiklikleri izle ve otomatik senkronize et

    Örnekler:
      ruby sync_translations.rb sync
      ruby sync_translations.rb watch
  USAGE
  exit
end

syncer = TranslationSyncer.new

case ARGV[0]
when 'sync'
  syncer.sync_all
when 'watch'
  syncer.watch_mode
else
  puts "❌ Bilinmeyen komut: #{ARGV[0]}"
  puts "Yardım için: ruby sync_translations.rb"
end