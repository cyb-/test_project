class Ability
  include CanCan::Ability

  def initialize(user)
    if user and user.admin?
      can :manage, :all
      can :update_role, User
    elsif user and user.user?
      can :read, User
    end
  end
end
