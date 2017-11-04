class PageContent < ApplicationRecord
  belongs_to :page

  validates_presence_of :tag, :content
end
