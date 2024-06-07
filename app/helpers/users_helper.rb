module UsersHelper
  def fetch_users_by_role(role)
    case role.to_sym
    when :admin
      User.includes(:shelter).where(role: :shelter)
    when :shelter
      User.includes(:adopter).where(role: [:adopter, :admin])
    when :adopter
      User.includes(:shelter).where(role: :shelter)
    end
  end
end
