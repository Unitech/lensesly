module ApplicationHelper

  def universe universes, univ_name, univ_code

    universes.each do |u|
      if u.name == univ_name
        return "<div id='univ' class='ajaxround setted' data-id='#{u.id}'>#{univ_code}</div>".html_safe
      end
    end

    u = Spree::Taxon.find_by_name(univ_name)
    return "<div id='univ' class='ajaxround notsetted' data-id='#{u.id}'>#{univ_code}</div>".html_safe
  end

  def get_glasses_on_env env
    tax = Spree::Taxon.find_by_name(env)
    return tax.products.first || false
    #return false
  end

end
