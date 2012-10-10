class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    
    can :new, :all
    
    can [:create,:read,:edit,:update,:destroy], Activity, user_id: user.id
    can [:create,:read,:edit,:update,:destroy], ActivityGroup, user_id: user.id
  end
end
