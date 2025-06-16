# _plugins/missing_pages.rb
require 'set'

module Jekyll
  # Eksik linkleri yönlendiren generator
  class MissingPagesLinker < Generator
    safe true
    priority :low

    def generate(site)
      guides_dir = File.join(site.source, 'rails', 'guides')
      return unless Dir.exist?(guides_dir)

      # Mevcut .md dosyalarının listesini oluştur
      existing_files = Set.new
      Dir.glob(File.join(guides_dir, '**', '*.md')).each do |file|
        relative_path = file.sub("#{guides_dir}/", '').sub('.md', '')
        existing_files.add(relative_path)
      end

      # Tüm sayfalardaki relative link'leri güncelle
      site.pages.each do |page|
        next unless page.path.include?('rails') && page.path.end_with?('.md')
        process_relative_links(page, existing_files)
      end

      # Collections kontrolü - site.collections varsa kontrol et
      if site.respond_to?(:collections) && site.collections['posts']
        site.collections['posts'].docs.each do |post|
          next unless post.path.include?('rails') && post.path.end_with?('.md')
          process_relative_links(post, existing_files)
        end
      end
    end

    private

    def process_relative_links(page, existing_files)
      content = page.content.dup
      modified = false

      # ../dosya_adi/ formatındaki linkleri kontrol et
      content.gsub!(/\[([^\]]+)\]\(\.\.\/([^)\/]+)\/?\)/) do |match|
        link_text = Regexp.last_match(1)
        file_path = Regexp.last_match(2)
  
        unless existing_files.include?(file_path)
          modified = true
          "[#{link_text}]({% link rails/guides/missing_pages/currently_being_worked.md %})"
        else
          match
        end
      end

      # ../dosya_adi/#anchor formatındaki linkleri kontrol et
      content.gsub!(/\[([^\]]+)\]\(\.\.\/([^\/]+)\/#[^)]+\)/) do |match|
        link_text = Regexp.last_match(1)
        file_path = Regexp.last_match(2)
  
        unless existing_files.include?(file_path)
          modified = true
          "[#{link_text}]({% link rails/guides/missing_pages/currently_being_worked.md %})"
        else
          match
        end
      end

      # HTML linklerindeki ../dosya_adi/#anchor formatını kontrol et
      content.gsub!(/<a\s+href="\.\.\/([^\/]+)\/#[^"]+">([^<]+)<\/a>/) do |match|
        file_path = Regexp.last_match(1)
        link_text = Regexp.last_match(2)

        unless existing_files.include?(file_path)
          modified = true
          "<a href=\"{% link rails/guides/missing_pages/currently_being_worked.md %}\">#{link_text}</a>"
        else
          match
        end
      end

      # Jekyll link tag'lerini kontrol et
      content.gsub!(/\{\%\s*link\s+(rails\/guides\/([^}]+)\.md)\s*\%\}/) do |match|
        full_link = Regexp.last_match(1)
        file_name = Regexp.last_match(2)
        
        source_dir = Jekyll.configuration({})['source'] || Dir.pwd
        full_file_path = File.join(source_dir, full_link)
        
        unless File.exist?(full_file_path)
          modified = true
          "{% link rails/guides/missing_pages/currently_being_worked.md %}"
        else
          match
        end
      end

      if modified
        page.content = content
        Jekyll.logger.info "Missing Pages:", "Updated missing links in #{page.path}"
      end
    end
  end
end