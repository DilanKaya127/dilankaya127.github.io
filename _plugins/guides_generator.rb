# _plugins/guides_generator.rb
# Bu dosyayı _plugins klasörüne koyun

Jekyll::Hooks.register :site, :pre_render do |site|
  # Index sayfasını bul
  index_page = site.pages.find { |page| page.name == 'index.md' }
  
  if index_page
    guides_data = { 'sections' => [] }
    current_section = nil
    
    # Markdown içeriğini satır satır işle
    lines = index_page.content.split("\n")
    
    lines.each do |line|
      # H2 başlıkları (##) - Ana kategoriler
      if line.match(/^## (.+)/)
        section_title = line.gsub(/^## /, '').strip
        
        # Gereksiz bölümleri filtrele
        unless ['Geri Bildirim'].include?(section_title)
          current_section = {
            'title' => section_title,
            'guides' => []
          }
          guides_data['sections'] << current_section
        else
          current_section = nil
        end
        
      # H3 başlıkları ile link ([text](link)) - Kılavuz linkleri
      elsif line.match(/^### \[(.+)\]\({% link (.+) %}\)/) && current_section
        title = $1.strip
        link_path = $2.strip.gsub('.md', '')
        
        current_section['guides'] << {
          'title' => title,
          'url' => link_path
        }
      end
    end
    
    # Site data'ya ekle
    site.data['guides'] = guides_data
  end
end