class Volunteer
  attr_accessor :name, :id, :project_id

  def initialize(attr)
    @name= attr.fetch(:name)
    @id = attr.fetch(:id)
    @project_id = attr.fetch(:project_id)
  end

  def ==(volunteer_to_compare)
    self.name() == volunteer_to_compare.name()
  end

  def self.all
    volunteer_list = DB.exec("SELECT * FROM volunteers;")
    volunteers = []
    volunteer_list.each do |volunteer|
      name = volunteer.fetch("name")
      id = volunteer.fetch("id").to_i
      project_id = volunteer.fetch("project_id")
      volunteers.push(Volunteer.new({:name => name, :project_id => project_id, :id => id}))
    end
    volunteers
  end

  def save
    result =  DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{@name}', #{@project_id}) RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  def self.find(id)
    Volunteer.all.each do |volunteer|
      if volunteer.id == id
        return volunteer
      end
    end
  end

end
