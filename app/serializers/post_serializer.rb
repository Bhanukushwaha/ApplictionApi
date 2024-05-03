class PostSerializer < ActiveModel::Serializer
  attributes *[:id, :title, :description, :user_id, :image_url, :user]
  attribute :description do |object|
   @object.description
  end
  attribute :image_url do |object|
   if @object.image.attached?
    ENV["BASE_URL"] + Rails.application.routes.url_helpers.rails_blob_url(@object.image, only_path: true)
   end
  end
  attribute :user do |object|
   {name: @object&.user&.name, id: @object&.user&.id}
  end
  attribute :is_like do |object|
    Like.find_by(user_id: current_user.id, likeable_type: "Post", likeable_id:@object&.id ).present?
  end
end
