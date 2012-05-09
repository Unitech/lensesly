module Spree
  class HomeController < BaseController
    helper 'spree/products'
    respond_to :html

    def index
      @searcher = Spree::Config.searcher_class.new(params)
      @products = @searcher.retrieve_products
      respond_with(@products)
    end
  end
end
