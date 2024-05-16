class FollowSerializer < ActiveModel::Serializer
  attributes *[
    :id,
    :name,
    :is_follow
  ]
  attribute :is_follow do |object|
    Follow.where(user_id: @object.id, current_user_id: current_user.id).present?
  end
end
