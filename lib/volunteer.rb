class Volunteer
  attr_accessor (:name, :id, :project_id)

  def initialize(attr)
    @name= attr.fetch(:name)
    @id = attr.fetch(:id)
    @project_id = attr.fetch(:project_id)
  end

  def ==(volunteer_to_compare)
    self.name() = volunteer_to_compare.name()
  end
end
