module Spree
  module Scopes
    # This module is extended by ProductScope
    module Product

       #TODO: change this to array pairs so we preserve order?

      SCOPES = {
    # Scopes for selecting products based on taxon
        :taxon => {
      :taxons_name_eq => [:taxon_name],
      :in_taxons => [:taxon_names],
        },
    # product selection based on name, or search
        :search => {
      :in_name => [:words],
      :in_name_or_keywords => [:words],
      :in_name_or_description => [:words],
      :with_ids => [:ids]
        },
      }

    end
  end
end
