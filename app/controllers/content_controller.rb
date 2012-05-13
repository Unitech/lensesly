# -*- coding: utf-8 -*-
class ContentController < Spree::BaseController
  layout 'spree/layouts/spree_application'
  
  def opticians
    @title = 'Nos opticiens'
  end

  def help
    @title = 'Aide'
  end

  def about
    @title = 'À propos'
  end

  def mention
    @title = 'Mentions légales'
  end

  def contact
    @title = 'Contact'
  end

  def conditions
    @title = 'Conditions générales'
  end
  
  def concours
    @title = 'Concours de beauté BeliView'
  end

end
