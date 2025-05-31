#!/bin/bash

# Rails TR-TR Dokümantasyon Senkronizasyon Script'i
# Bu script rails-tr-TR repository'sindeki çevirileri rails-tr-tr Jekyll sitesine kopyalar

set -e

# Renkli çıktı için
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Fonksiyonlar
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Konfigürasyon
RAILS_TR_REPO="../../rails-tr-TR"  # rails-tr-TR repository yolu
CURRENT_DIR=$(pwd)
GUIDES_SOURCE="$RAILS_TR_REPO/guides/source"
SITE_GUIDES_EN="guides/en"
SITE_GUIDES_TR="guides/tr"

# Repository kontrolü
check_repositories() {
    log_info "Repository'leri kontrol ediliyor..."
    
    if [ ! -d "$RAILS_TR_REPO" ]; then
        log_error "Rails-tr-TR repository bulunamadı: $RAILS_TR_REPO"
        log_info "Önce rails-tr-TR repository'sini klonlayın:"
        echo "git clone https://github.com/dilankaya127/rails-tr-TR.git"
        exit 1
    fi
    
    if [ ! -d "$GUIDES_SOURCE" ]; then
        log_error "Rails guides source klasörü bulunamadı: $GUIDES_SOURCE"
        exit 1
    fi
    
    log_success "Repository'ler kontrol edildi"
}

# Klasörleri oluştur
setup_directories() {
    log_info "Gerekli klasörler oluşturuluyor..."
    
    mkdir -p "$SITE_GUIDES_EN"
    mkdir -p "$SITE_GUIDES_TR"
    mkdir -p "_data"
    
    log_success "Klasörler hazırlandı"
}

# Orijinal İngilizce dosyaları kopyala
sync_english_guides() {
    log_info "Orijinal İngilizce kılavuzlar kopyalanıyor..."
    
    # .md dosyalarını kopyala (alt klasörler hariç)
    find "$GUIDES_SOURCE" -maxdepth 1 -name "*.md" -exec cp {} "$SITE_GUIDES_EN/" \;
    
    # Jekyll front matter ekle
    for file in "$SITE_GUIDES_EN"/*.md; do
        if [ -f "$file" ]; then
            filename=$(basename "$file" .md)
            temp_file=$(mktemp)
            
            echo "---" > "$temp_file"
            echo "layout: guide" >> "$temp_file"
            echo "title: \"$(echo $filename | sed 's/_/ /g' | sed 's/\b\w/\U&/g')\"" >> "$temp_file"
            echo "lang: en" >> "$temp_file"
            echo "original: true" >> "$temp_file"
            echo "---" >> "$temp_file"
            echo "" >> "$temp_file"
            cat "$file" >> "$temp_file"
            
            mv "$temp_file" "$file"
        fi
    done
    
    count=$(find "$SITE_GUIDES_EN" -name "*.md" | wc -l)
    log_success "$count İngilizce kılavuz kopyalandı"
}

# Türkçe çevirileri kopyala
sync_turkish_guides() {
    log_info "Türkçe çeviriler kopyalanıyor..."
    
    TR_SOURCE="$GUIDES_SOURCE/tr-TR"
    
    if [ ! -d "$TR_SOURCE" ]; then
        log_warning "Türkçe çeviriler klasörü bulunamadı: $TR_SOURCE"
        log_info "Henüz Türkçe çeviri yapmadıysanız, önce rails-tr-TR/guides/source/tr-TR/ klasörünü oluşturun"
        return
    fi
    
    # Türkçe .md dosyalarını kopyala
    find "$TR_SOURCE" -name "*.md" -exec cp {} "$SITE_GUIDES_TR/" \;
    
    # Jekyll front matter ekle
    for file in "$SITE_GUIDES_TR"/*.md; do
        if [ -f "$file" ]; then
            filename=$(basename "$file" .md)
            temp_file=$(mktemp)
            
            # Türkçe başlık üret (basit dönüşüm)
            title=$(echo $filename | sed 's/_/ /g' | sed 's/\b\w/\U&/g')
            
            echo "---" > "$temp_file"
            echo "layout: guide" >> "$temp_file"
            echo "title: \"$title\"" >> "$temp_file"
            echo "lang: tr" >> "$temp_file"
            echo "translation: true" >> "$temp_file"
            echo "original_file: \"$filename.md\"" >> "$temp_file"
            echo "---" >> "$temp_file"
            echo "" >> "$temp_file"
            cat "$file" >> "$temp_file"
            
            mv "$temp_file" "$file"
        fi
    done
    
    count=$(find "$SITE_GUIDES_TR" -name "*.md" | wc -l)
    log_success "$count Türkçe çeviri kopyalandı"
}

# Kılavuz verilerini güncelle
update_guides_data() {
    log_info "Kılavuz verileri güncelleniyor..."
    
    cat > "_data/guides.yml" << EOF
# Rails Kılavuzları Veri Dosyası
# Bu dosya otomatik olarak sync-rails-docs.sh ile güncellenir

guides:
EOF

    # İngilizce dosyaları tara
    for file in "$SITE_GUIDES_EN"/*.md; do
        if [ -f "$file" ]; then
            filename=$(basename "$file" .md)
            tr_file="$SITE_GUIDES_TR/$filename.md"
            
            if [ -f "$tr_file" ]; then
                status="completed"
            else
                status="pending"
            fi
            
            cat >> "_data/guides.yml" << EOF
  - id: "$filename"
    title: "$(echo $filename | sed 's/_/ /g' | sed 's/\b\w/\U&/g')"
    en_file: "guides/en/$filename.html"
    tr_file: "guides/tr/$filename.html"
    status: "$status"
    
EOF
        fi
    done
    
    log_success "Kılavuz verileri güncellendi"
}

# Git commit ve push
commit_changes() {
    if [ "$1" = "--commit" ]; then
        log_info "Değişiklikler commit ediliyor..."
        
        git add .
        git commit -m "Docs updated: $(date '+%Y-%m-%d %H:%M:%S')" || log_warning "Commit edilecek değişiklik yok"
        
        if [ "$2" = "--push" ]; then
            log_info "Değişiklikler GitHub'a push ediliyor..."
            git push origin main || log_error "Push işlemi başarısız"
            log_success "Değişiklikler GitHub'a gönderildi"
        fi
    fi
}

# Ana fonksiyon
main() {
    log_info "Rails TR-TR Dokümantasyon Senkronizasyonu Başlıyor..."
    echo "=================================================="
    
    check_repositories
    setup_directories
    sync_english_guides
    sync_turkish_guides
    update_guides_data
    
    # İstatistikler
    en_count=$(find "$SITE_GUIDES_EN" -name "*.md" | wc -l)
    tr_count=$(find "$SITE_GUIDES_TR" -name "*.md" | wc -l)
    progress=$((tr_count * 100 / en_count))
    
    echo ""
    echo "=================================================="
    log_success "Senkronizasyon tamamlandı!"
    echo ""
    echo "📊 İstatistikler:"
    echo "   • Toplam Kılavuz: $en_count"
    echo "   • Çevrilen: $tr_count"
    echo "   • İlerleme: %$progress"
    echo ""
    
    if [ "$1" = "--commit" ]; then
        commit_changes "$@"
    else
        log_info "Git commit için: ./sync-rails-docs.sh --commit"
        log_info "Push ile birlikte: ./sync-rails-docs.sh --commit --push"
    fi
    
    echo ""
    log_info "Site URL: https://dilankaya127.github.io/rails-tr-tr/"
    log_success "Hazır! 🚀"
}

# Script'i çalıştır
main "$@"