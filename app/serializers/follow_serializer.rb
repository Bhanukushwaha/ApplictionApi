class FollowSerializer < ActiveModel::Serializer
  attributes *[
    :id,
    :name,
    :is_follow
  ]
  attribute :is_follow do |object|
    Follow.where(user_id: @object.id, current_user_id: scope.id).present?
  end
end
