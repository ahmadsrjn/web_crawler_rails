require 'rails_helper'

RSpec.describe WebCrawlerService do
  describe "#crawl" do
    let(:domain) { 'example.com' }
    let(:service) { WebCrawlerService.new(domain) }

    before do
      # Mocking HTTParty.get to prevent actual HTTP requests during tests
      allow(HTTParty).to receive(:get).and_return(instance_double(HTTParty::Response, body: '<html></html>'))
    end

    it "initializes with a domain" do
      expect(service.instance_variable_get(:@domain)).to eq(domain)
    end

    it "fetches static assets and internal links" do
      service.crawl
      sitemap = service.sitemap

      expect(sitemap).to be_a(Hash)
      expect(sitemap['/'][:assets]).to be_a(Array)
      expect(sitemap['/'][:links]).to be_a(Array)
    end

    # You can add more specific tests, for example, testing the actual content of fetched assets and links.
  end
end
