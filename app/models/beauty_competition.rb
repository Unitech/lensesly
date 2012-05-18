class BeautyCompetition < ActiveRecord::Base
  attr_accessible :f_name, :l_name, :mail, :number, :photo
  
  has_attached_file :photo, :styles => { :small => "1500x1500>" },
                    :url => '/system/competition/:id/:style/:basename.:extension',
                    :path => ':rails_root/public/system/competition/:id/:style/:basename.:extension'
  
  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 12.megabytes
  
  validates_presence_of :f_name
  validates_presence_of :l_name
  validates_presence_of :mail
  validates_presence_of :number

end
