class Image < ApplicationRecord
  belongs_to :item, optional: true
  validates_presence_of :item
  mount_uploaders :image_url, ImageUploader
end
