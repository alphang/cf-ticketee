class Comment < ActiveRecord::Base
  after_create :set_ticket_state
  attr_accessible :text, :state_id

  belongs_to :ticket
  belongs_to :user
  belongs_to :state
  validates :text, :presence => true

  delegate :project, :to => :ticket #shorcut to ticket.project

  private

  def set_ticket_state
    self.ticket.state = self.state
    self.ticket.save!
  end

end
