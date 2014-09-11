require 'test_helper'

class Base64AttachmentTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, Base64Attachment
  end
end
