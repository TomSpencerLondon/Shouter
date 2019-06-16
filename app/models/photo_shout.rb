class PhotoShout < ApplicationRecord
  has_attached_file :image, styles: {
    shout: "200x200>",
    medium: "600x600>"
  }
  validates_attachment_presence :image
  validates_attachment_file_name :image, :matches => [/png\Z/, /jpe?g\Z/, /gif\Z/]

end
