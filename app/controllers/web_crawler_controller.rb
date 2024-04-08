class WebCrawlerController < ApplicationController
    require 'uri'
    def index
    end

    def crawl_any_website
        domain = params[:domain]
        if domain.include?('https://') || domain.include?('http://')
            uri = URI.parse(domain)
            domain = uri.host
            if domain.include?('www')
                domain = uri.host.sub(/^www\./, '')
            end
        end
        session[:domain_] = domain
        crawler = WebCrawlerService.new(domain)
        crawler.crawl
        @sitemap = crawler.sitemap
        session[:sitemap_] = crawler.sitemap
        redirect_to controller: 'web_crawler', action: 'show_sitemap'
    end
    
    def show_sitemap
        @show_domain_sitemap = session[:sitemap_]
        @domain_name = session[:domain_]
    end
end
