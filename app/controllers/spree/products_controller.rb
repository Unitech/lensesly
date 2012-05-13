module Spree
  class ProductsController < BaseController
    HTTP_REFERER_REGEXP = /^https?:\/\/[^\/]+\/t\/([a-z0-9\-\/]+)$/
    rescue_from ActiveRecord::RecordNotFound, :with => :render_404
    helper 'spree/taxons'

    before_filter :is_admin, :only => [:ajax_delete_product,
                                      :switch_taxon]
    
    respond_to :html

    def index
      @searcher = Config.searcher_class.new(params)
      @products = @searcher.retrieve_products
      respond_with(@products)
    end

    
    def show
      @product = Product.active.find_by_permalink!(params[:id])
      return unless @product

      @variants = Variant.active.includes([:option_values, :images]).where(:product_id => @product.id)
      @product_properties = ProductProperty.includes(:property).where(:product_id => @product.id)

      referer = request.env['HTTP_REFERER']

      if referer && referer.match(HTTP_REFERER_REGEXP)
        @taxon = Taxon.find_by_permalink($1)
      end

      respond_with(@product)
    end


    #
    # Override
    #
    def ajax_delete_product
      Product.find(params[:id]).delete
      render :json => {:success => :true}
    end

    def switch_taxon      
      prod = Product.find(params[:prod_id])

      prod.taxons.each do |t|        
        if t.id == params[:tax_id].to_i
          prod.taxons.delete(t)
          prod.save
          render :json => {:success => :true, :action => :delete}
          return 
        end
      end

      taxon = Taxon.find(params[:tax_id])
      prod.taxons << taxon
      prod.save
      render :json => {:success => :true, :action => :add}
    end
    
    def test
      @searcher = Config.searcher_class.new(params)
      @products = @searcher.retrieve_products
      render :partial => 'spree/shared/products_only', :locals => { :products => @products }
    end

    

    private
      def accurate_title
        @product ? @product.name : super
      end
      
      def is_admin
        if current_user and current_user.has_role? :admin
          return true
        else
          redirect_to root_path
          return false
        end
      end
  end
end
