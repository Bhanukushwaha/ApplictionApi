class UserSerializer < ActiveModel::Serializer
  attributes *[
    :id, 
    :name,
    :is_follow,
    :email
  ]
  attribute :is_follow do |object|
    Follow.where(user_id: @object.id, current_user_id: current_user.id).present?
  end
  attribute :post_count do |object|
    @object.posts.count
  end
  attribute :followers do |object|
    @object.follows.count
  end
  attribute :following do |object|
    @object.followings.count
  end
end
class Fruit < ApplicationRecord
  scope :with_juice, -> { where("juice > 0") }
end