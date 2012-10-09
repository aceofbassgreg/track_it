class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    
    can :new, :all
    
    can [:create,:read,:edit,:update,:destroy], Activity
    can [:create,:read,:edit,:update,:destroy], ActivityGroup
  end
end
