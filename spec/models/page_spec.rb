require 'rails_helper'

RSpec.describe Page, type: :model do
  # Association test
  
  it { should have_many(:page_contents).dependent(:destroy) }
  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:page_url) }
end
