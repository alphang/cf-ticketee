class Permission < ActiveRecord::Base
  attr_accessible :user, :action, :thing
  belongs_to :user
  belongs_to :thing, :polymorphic => true
  #thing is a polymorphic association
end
