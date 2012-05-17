module Spree
  class TaxonsController < BaseController
    rescue_from ActiveRecord::RecordNotFound, :with => :render_404
    helper 'spree/products'

    respond_to :html

    def show
      @taxon = Taxon.find_by_permalink!(params[:id])      
      return unless @taxon

      @searcher = Spree::Config.searcher_class.new(params.merge(:taxon => @taxon.id))
      @products = @searcher.retrieve_products

      respond_with(@taxon)
    end

    def test
      @taxon = Taxon.find_by_permalink!(params[:id])
      @searcher = Spree::Config.searcher_class.new(params.merge(:taxon => @taxon.id))
      @products = @searcher.retrieve_products
      render :partial => 'spree/shared/products_only', :locals => { :products => @products }
    end

    private
      def accurate_title
        @taxon ? @taxon.name : super
      end
  end
end
