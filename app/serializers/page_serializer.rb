class PageSerializer < ActiveModel::Serializer
  attributes :id, :page_url

  has_many :page_contents
end
