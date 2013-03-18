class Ability
  include CanCan::Ability

  # This class, when defined at the root level, configures on how CanCan
  # and the can?/cannot? methods will behave.
  #

  def initialize(user)
    user.permissions.each do |permission|
      can permission.action.to_sym,
      permission.thing_type.constantize do |thing|
        thing.nil? ||
        permission.thing_id.nil? ||
        permission.thing_id == thing.id
      end
    end
  end
end
