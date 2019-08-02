class Project
  attr_accessor(:title, :id)

  def initialize(attr)
    @title = attr.fetch(:title)
    @id = attributes.fetch(:id)
  end
end
