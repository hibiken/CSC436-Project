class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :full_name, :email, :member_since

  def full_name
    "#{object.first_name} #{last_name}"
  end

  def member_since
    object.created_at
  end

end
