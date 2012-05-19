module Spree
  class HomeController < BaseController
    helper 'spree/products'
    respond_to :html

    def index
      # @searcher = Spree::Config.searcher_class.new(params)
      @products = Spree::Product.joins(:variants_including_master).find(:all, :order => 'price ASC', :limit => 20)

      # @products = Product.find(:all, :limit => 20)
      @newsletter = Newsletter.new
      
      respond_with(@products)
    end
  end
end
