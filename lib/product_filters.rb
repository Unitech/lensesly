module Spree
  # THIS FILE SHOULD BE OVER-RIDDEN IN YOUR SITE EXTENSION!
  #   the exact code probably won't be useful, though you're welcome to modify and reuse
  #   the current contents are mainly for testing and documentation

  # To override this file...
  #   1) Make a copy of it in your sites local /lib folder
  #   2) Add it to the config load path, or require it in an initializer, e.g...
  #
  #      # config/initializers/spree.rb
  #      require 'product_filters'
  #

  # set up some basic filters for use with products
  #
  # Each filter has two parts
  #  * a parametrized named scope which expects a list of labels
  #  * an object which describes/defines the filter
  #
  # The filter description has three components
  #  * a name, for displaying on pages
  #  * a named scope which will 'execute' the filter
  #  * a mapping of presentation labels to the relevant condition (in the context of the named scope)
  #  * an optional list of labels and values (for use with object selection - see taxons examples below)
  #
  # The named scopes here have a suffix '_any', following SearchLogic's convention for a
  # scope which returns results which match any of the inputs. This is purely a convention,
  # but might be a useful reminder.
  #
  # When creating a form, the name of the checkbox group for a filter F should be
  # the name of F's scope with [] appended, eg "price_range_any[]", and for
  # each label you should have a checkbox with the label as its value. On submission,
  # Rails will send the action a hash containing (among other things) an array named
  # after the scope whose values are the active labels.
  #
  # SearchLogic will then convert this array to a call to the named scope with the array
  # contents, and the named scope will build a query with the disjunction of the conditions
  # relating to the labels, all relative to the scope's context.
  #
  # The details of how/when filters are used is a detail for specific models (eg products
  # or taxons), eg see the taxon model/controller.

  # See specific filters below for concrete examples.

  # This module is included by Taxon. In development mode that inclusion does not
  # happen until Taxon class is loaded. Ensure that Taxon class is loaded before
  # you try something like Product.price_range_any
  module ProductFilters
    extend ActionView::Helpers::NumberHelper
    extend Spree::BaseHelper

    # Example: filtering by price
    #   The named scope just maps incoming labels onto their conditions, and builds the conjunction
    #   'price' is in the base scope's context (ie, "select foo from products where ...") so
    #     we can access the field right away
    #   The filter identifies which scope to use, then sets the conditions for each price range
    #
    # If user checks off three different price ranges then the argument passed to
    # below scope would be something like ["$10 - $15", "$15 - $18", "$18 - $20"]
    #
    Spree::Product.scope :price_range_any,
      lambda {|*opts|
        conds = opts.map {|o| Spree::ProductFilters.price_filter[:conds][o]}.reject {|c| c.nil?}
        Spree::Product.scoped(:joins => :master).conditions_any(conds)
      }

    def ProductFilters.price_filter
      conds = [ [ "#{format_price(50)}"   , "price             <= 50" ],
                [ "#{format_price(50)} - #{format_price(100)}"        , "price between 50 and 100" ],
                [ "#{format_price(100)} - #{format_price(150)}"        , "price between 100 and 150" ],
                [ "#{format_price(150)} - #{format_price(200)}"        , "price between 150 and 200" ],
                [ "#{format_price(200)} - #{format_price(300)}"        , "price between 200 and 300" ],
                [ "#{format_price(300)}" , "price             >= 300" ] ]
      { :name   => I18n.t(:price_range),
        :scope  => :price_range_any,
        :conds  => Hash[*conds.flatten],
        :labels => conds.map {|k,v| [k,k]}
      }
    end


    # Example: filtering by possible brands
    #
    # First, we define the scope. Two interesting points here: (a) we run our conditions
    #   in the scope where the info for the 'brand' property has been loaded; and (b)
    #   because we may want to filter by other properties too, we give this part of the
    #   query a unique name (which must be used in the associated conditions too).
    #
    # Secondly, the filter. Instead of a static list of values, we pull out all existing
    #   brands from the db, and then build conditions which test for string equality on
    #   the (uniquely named) field "p_brand.value". There's also a test for brand info
    #   being blank: note that this relies on with_property doing a left outer join
    #   rather than an inner join.

    if Spree::Property.table_exists? && @@brand_property = Spree::Property.find_by_name("brand")
      Spree::Product.scope :brand_any,
        lambda {|*opts|
          conds = opts.map {|o| ProductFilters.brand_filter[:conds][o]}.reject {|c| c.nil?}
          Spree::Product.with_property("brand").conditions_any(conds)
        }

      def ProductFilters.brand_filter
        brands = Spree::ProductProperty.where(:property_id => @@brand_property).map(&:value).compact.uniq
        conds  = Hash[*brands.map {|b| [b, "#{Spree::ProductProperty.table_name}.value = '#{b}'"]}.flatten]
        { :name   => "Brands",
          :scope  => :brand_any,
          :conds  => conds,
          :labels => (brands.sort).map {|k| [k,k]}
        }
      end
    end


    if Spree::Property.table_exists? && @@color_property = Spree::Property.find_by_name("color")
      Spree::Product.scope :color_any,
        lambda {|*opts|
          conds = opts.map {|o| ProductFilters.color_filter[:conds][o]}.reject {|c| c.nil?}
          Spree::Product.with_property("color").conditions_any(conds)
        }

      def ProductFilters.color_filter
        colors = Spree::ProductProperty.where(:property_id => @@color_property).map(&:value).compact.uniq
        conds  = Hash[*colors.map {|b| [b, "#{Spree::ProductProperty.table_name}.value = '#{b}'"]}.flatten]
        { :name   => "Couleurs",
          :scope  => :color_any,
          :conds  => conds,
          :labels => (colors.sort).map {|k| [k,k]}
        }
      end
    end


    if Spree::Property.table_exists? && @@shape_property = Spree::Property.find_by_name("shape")
      Spree::Product.scope :shape_any,
        lambda {|*opts|
          conds = opts.map {|o| ProductFilters.shape_filter[:conds][o]}.reject {|c| c.nil?}
          Spree::Product.with_property("shape").conditions_any(conds)
        }

      def ProductFilters.shape_filter
        shapes = Spree::ProductProperty.where(:property_id => @@shape_property).map(&:value).compact.uniq
        conds  = Hash[*shapes.map {|b| [b, "#{Spree::ProductProperty.table_name}.value = '#{b}'"]}.flatten]
        { :name   => "Formes",
          :scope  => :shape_any,
          :conds  => conds,
          :labels => (shapes.sort).map {|k| [k,k]}
        }
      end
    end


    # Example: a parameterized filter
    #   The filter above may show brands which aren't applicable to the current taxon,
    #   so this one only shows the brands that are relevant to a particular taxon and
    #   its descendants.
    #
    #   We don't have to give a new scope since the conditions here are a subset of the
    #   more general filter, so decoding will still work - as long as the filters on a
    #   page all have unique names (ie, you can't use the two brand filters together
    #   if they use the same scope). To be safe, the code uses a copy of the scope.
    #
    #   HOWEVER: what happens if we want a more precise scope?  we can't pass
    #   parametrized scope names to SearchLogic, only atomic names, so couldn't ask
    #   for taxon T's customized filter to be used. BUT: we can arrange for the form
    #   to pass back a hash instead of an array, where the key acts as the (taxon)
    #   parameter and value is its label array, and then get a modified named scope
    #   to get its conditions from a particular filter.
    #
    #   The brand-finding code can be simplified if a few more named scopes were added to
    #   the product properties model.

    # if Spree::Property.table_exists? && @@brand_property
    #   Spree::Product.scope :selective_brand_any, lambda {|*opts| Spree::Product.brand_any(*opts) }

    #   def ProductFilters.selective_brand_filter(taxon = nil)
    #     if taxon.nil?
    #       taxon = Spree::Taxonomy.first.root
    #     end
    #     scope = Spree::ProductProperty.scoped(:conditions => ["property_id = ?", @@brand_property]).
    #                                    scoped(:joins      => {:product => :taxons},
    #                                           :conditions => ["#{Spree::Taxon.table_name}.id in (?)", [taxon] + taxon.descendants])
    #     brands = scope.map {|p| p.value}.uniq

    #     { :name   => "Applicable Brands",
    #       :scope  => :selective_brand_any,
    #       :labels => brands.sort.map {|k| [k,k]}
    #     }
    #   end
    # end

    # Provide filtering on the immediate children of a taxon
    #
    # This doesn't fit the pattern of the examples above, so there's a few changes.
    # Firstly, it uses an existing scope which was not built for filtering - and so
    # has no need of a conditions mapping, and secondly, it has a mapping of name
    # to the argument type expected by the other scope.
    #
    # This technique is useful for filtering on objects (by passing ids) or with a
    # scope that can be used directly (eg. testing only ever on a single property).
    #
    # This scope selects products in any of the active taxons or their children.
    #
    def ProductFilters.taxons_below(taxon)
      return Spree::ProductFilters.all_taxons if taxon.nil?
      { :name   => "Taxons under " + taxon.name,
        :scope  => :taxons_id_in_tree_any,
        :labels => taxon.children.sort_by(&:position).map {|t| [t.name, t.id]},
        :conds  => nil
      }
    end

    # Filtering by the list of all taxons
    #
    # Similar idea as above, but we don't want the descendants' products, hence
    # it uses one of the auto-generated scopes from SearchLogic.
    #
    # idea: expand the format to allow nesting of labels?
    def ProductFilters.all_taxons
      taxons = Spree::Taxonomy.all.map {|t| [t.root] + t.root.descendants }.flatten
      { :name   => "All taxons",
        :scope  => :taxons_id_equals_any,
        :labels => taxons.sort_by(&:name).map {|t| [t.name, t.id]},
        :conds  => nil # not needed
      }
    end
  end
end
