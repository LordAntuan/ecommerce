# == Schema Information
#
# Table name: languages
#
#  id                    :integer          not null, primary key
#  code                  :string
#  appears_in_backoffice :boolean          default(FALSE)
#  appears_in_web        :boolean          default(FALSE)
#  created_at            :datetime
#  updated_at            :datetime
#  flag_file_name        :string
#  flag_content_type     :string
#  flag_file_size        :integer
#  flag_updated_at       :datetime
#

require 'test_helper'

class LanguageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
