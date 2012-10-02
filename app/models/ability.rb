class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    
    can :new, :all
    
    can [:read,:edit,:update,:destroy,:create], Activity

end
