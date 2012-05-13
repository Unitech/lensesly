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

end
