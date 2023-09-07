class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the user here. For example:
    #  user ||= User.new # Guest user

    if user.admin?
      can :manage, :all # Admins can manage all resources
    else
      can :read, :all # Non-admins can read all resources
      can :destroy, Post, author_id: user.id
      can :destroy, Comment, author_id: user.id
      can :new, Post, author_id: user.id
      can :create, Post, author_id: user.id
      can :create, Comment, author_id: user.id
      can :new, Comment, author_id: user.id
      if user.id.present?
        can :manage, Post, user_id: user.id
        can :manage, Comment, user_id: user.id
      end
    end
  end
end
