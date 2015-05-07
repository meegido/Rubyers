class Post < ActiveRecord::Base
	include PublicActivity::Model
	acts_as_votable
	acts_as_taggable
	belongs_to :user
	has_many :comments
	has_attached_file :image, styles: { medium: "700x500#", small: "350x250#" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  	has_many :directions
  	accepts_nested_attributes_for :directions, :reject_if => :all_blank, :allow_destroy => true
end
