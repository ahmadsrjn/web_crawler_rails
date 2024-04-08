class WebCrawlerController < ApplicationController
    @@show_result 
    def index
    end
    
    def crawl_any_website
        domain = params[:domain]
        crawler = WebCrawlerService.new(domain)
        crawler.crawl
        @sitemap = crawler.sitemap
        @@show_result = @sitemap
        redirect_to controller: 'web_crawler', action: 'show_sitemap'
    end
    
    def show_sitemap
        binding.pry
        @show_domain_sitemap = @@show_result
    end
end
