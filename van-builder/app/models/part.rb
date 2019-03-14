class Part < ActiveRecord::Base
belongs_to :user

  def slug
  end

  def self.find_by_slug(slug)
  end

end
