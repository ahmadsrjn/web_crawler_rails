require 'nokogiri'
require 'httparty'

class WebCrawlerService
  attr_reader :sitemap

  def initialize(domain)
    @domain = domain
    @base_url = "http://#{@domain}"
    @sitemap = {}
  end

  def crawl(url = @base_url, path = '/')
    return if @sitemap.key?(path)
    html = HTTParty.get(url).body
    document = Nokogiri::HTML(html)

    assets = fetch_static_assets(document)
    links = fetch_internal_links(document)

    @sitemap[path] = { assets: assets, links: links }

    links.each do |link_path|
      next_url = "#{@base_url}#{link_path}"
      crawl(next_url, link_path)
    end
  rescue HTTParty::Error, SocketError => e
    puts "Error fetching #{url}: #{e.message}"
  end

  private

  def fetch_static_assets(document)
    document.css('img, script[src], link[rel="stylesheet"]').map do |asset|
      asset['src'] || asset['href']
    end.uniq.compact
  end

  def fetch_internal_links(document)
    document.css('a').map do |link|
      href = link['href']
      if href.present? || !href.nil?
        next unless href.start_with?('/') || href.start_with?(@base_url)
        href.delete_prefix!(@base_url)
        href.chomp!('/')
        href.empty? ? '/' : href
      end
    end.uniq.compact.reject { |href| href == '#' || href.start_with?('?') }
  end
end
