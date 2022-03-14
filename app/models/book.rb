class Book < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_one_attached :book_img
  has_many :reviews
# it will define the attached file
  # has_attached_file :book_img, styles: { book_index: "250x350>", book_show: "325x475>" }, default_url: "/images/:style/missing.png"
  # validates_attachment_content_type :book_img, content_type: /\Aimage\/.*\z/

  # has_attached_file :book_img, :styles => { :book_index => "250x350>", :book_show => "325x475>" }
  # validates_attachment_content_type :book_img, :content_type => /\Aimage\/.*\z/
end
