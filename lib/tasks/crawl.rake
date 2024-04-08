namespace :crawl do
  desc "Crawl a website and print its site map"
  task :website, [:domain] => :environment do |t, args|
    crawler = WebCrawlerService.new(args[:domain])
    crawler.crawl
    puts crawler.sitemap.to_json
  end
end
