class Newsletter < ActiveRecord::Base
  attr_accessible :mail

  validates_presence_of :mail
end
