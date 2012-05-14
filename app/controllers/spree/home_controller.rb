module Spree
  class HomeController < BaseController
    helper 'spree/products'
    respond_to :html

    def index
      @searcher = Spree::Config.searcher_class.new(params)
      @products = @searcher.retrieve_products.reverse_order
      @newsletter = Newsletter.new

      @trendy = Spree::Product.last
      
      respond_with(@products)
    end
  end
end
