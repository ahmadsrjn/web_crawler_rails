class WebCrawlerController < ApplicationController
    def index
    end

    def crawl_any_website
        domain = params[:domain]
        crawler = WebCrawlerService.new(domain)
        crawler.crawl
        @sitemap = crawler.sitemap
        session[:sitemap_] = crawler.sitemap
        redirect_to controller: 'web_crawler', action: 'show_sitemap'
    end
    
    def show_sitemap
        @show_domain_sitemap = session[:sitemap_]
    end
end
