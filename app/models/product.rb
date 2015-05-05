# == Schema Information
#
# Table name: products
#
#  id                    :integer          not null, primary key
#  reference_code        :string
#  name                  :string
#  barcode               :string
#  enabled               :boolean          default(FALSE)
#  appears_in_categories :boolean          default(TRUE)
#  appears_in_tag        :boolean          default(TRUE)
#  appears_in_search     :boolean          default(TRUE)
#  short_description     :string
#  description           :text
#  publication_date      :datetime         not null
#  unpublication_date    :datetime
#  retail_price_pre_tax  :decimal(10, 5)
#  retail_price          :decimal(10, 2)
#  tax_percent           :decimal(5, 2)
#  meta_title            :string
#  meta_description      :string
#  slug                  :string
#  stock                 :integer          default(0)
#  control_stock         :boolean          default(FALSE)
#  created_at            :datetime
#  updated_at            :datetime
#  image_file_name       :string
#  image_content_type    :string
#  image_file_size       :integer
#  image_updated_at      :datetime
#

class Product < ActiveRecord::Base
  has_attached_file :image, :styles => {
                             :medium => '300x300>',
                             :thumb => '100x100>' }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  has_many :products_categories
  has_many :categories, :through => :products_categories

  accepts_nested_attributes_for :products_categories, :allow_destroy => true

  before_create :set_default_publication_date


  private

  def set_default_publication_date
    self.publication_date = Time.now
  end
end
