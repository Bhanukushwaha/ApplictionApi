class PostSerializer < ActiveModel::Serializer
  attributes *[:id, :title, :description, :user_id, :image_url]
  attribute :description do |object|
    @object.description
  end
  attribute :image_url do |object|
   if @object.image.attached?
     Rails.application.routes.url_helpers.rails_blob_url(@object.image, only_path: true)
   end
  end
end
