module Spree
  module Admin
    class ZonesController < ResourceController
      before_filter :load_data, :except => [:index]

      def new
        @zone.zone_members.build
        respond_with(@zone)
      end

      protected

        def collection
          params[:q] ||= {}
          params[:q][:meta_sort] ||= "ascend_by_name"
          @search = super.search(params[:q])
          @zones = @search.result.page(params[:page]).per(Spree::Config[:orders_per_page])
        end

        def load_data
          @countries = Country.order(:name)
          @states = State.order(:name)
          @zones = Zone.order(:name)
        end
    end
  end
end
