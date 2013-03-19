class Ability
  include CanCan::Ability

  # This class, when defined at the root level, configures on how CanCan
  # and the can?/cannot? methods will behave.
  #

  def initialize(user)
    user.permissions.each do |permission|
      can permission.action.to_sym, #establishes a permission
      permission.thing_type.constantize do |thing|
      #thing_type.constantize is like <Classname>.<Call constructor>
        thing.nil? || # allows broadly, ie. just specify an action, and not a thing
        permission.thing_id.nil? ||
        permission.thing_id == thing.id
      end
    end
  end
end
