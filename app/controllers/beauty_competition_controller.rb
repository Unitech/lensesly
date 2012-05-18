# -*- coding: utf-8 -*-
class BeautyCompetitionController < Spree::BaseController
  layout 'spree/layouts/spree_application'

  def index
    @title = 'Concours de beauté BeliView'
  end
  
  def add_form
    @title = 'Concours de beauté BeliView'
    
    @beauty_competition = BeautyCompetition.create(params[:beauty_competition])
    
    if @beauty_competition.save
      @validated = true
      render :action => '../content/concours'
    else
      render :action => '../content/concours'
    end
  end
end
