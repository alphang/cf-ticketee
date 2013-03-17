class Project < ActiveRecord::Base
  attr_accessible :description, :name
  has_many :tickets, :dependent => :delete_all #or destroy or nullify

  scope :admins, where(:admin => true) #returns

  validates :name, :presence => true

  has_many :permissions, :as => :thing
  #project hasmany permissions, each project is represented as a Thing

  def self.viewable_by(user)
    joins(:permissions).where(:permissions => {
      :action => "view", :user_id => user.id })
  end

  def self.for(user)
    user.admin? ? Project : Project.viewable_by(user)
  end
end
