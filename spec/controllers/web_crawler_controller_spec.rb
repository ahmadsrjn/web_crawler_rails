require 'rails_helper'

RSpec.describe WebCrawlerController, type: :controller do
  describe "POST #crawl_any_website" do
    context "with valid URL" do
      it "redirects to the show_sitemap path" do
        post :crawl_any_website, params: { domain: 'example.com' }
        expect(response).to redirect_to(show_sitemap_path)
      end
    end

    # You might want to add more contexts for invalid URLs, edge cases, etc.
  end

  describe "GET #show_sitemap" do
    it "renders the sitemap template" do
      get :show_sitemap
      expect(response).to render_template(:show_sitemap)
    end
  end
end
