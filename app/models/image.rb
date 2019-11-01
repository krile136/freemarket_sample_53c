class Image < ApplicationRecord
  belongs_to :item, optional: true
  validates_presence_of :item
  mount_uploaders :image_url, ImageUploader

  def image_path
    if Rails.env.production?
      self.image_url[0].url.gsub(/%5B%22/, "").gsub(/%22%5D/, "")
    else
      self.image_url[0].file.file.sub(/.*public/,'').sub(/\["/,'').sub(/"\]/,'')
    end 
  end
end