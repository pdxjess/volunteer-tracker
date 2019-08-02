class Project
  attr_accessor(:title, :id)

  def initialize(attr)
    @title = attr.fetch(:title)
    @id = attr.fetch(:id)
  end

  def save
    result = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;")
    @id = result.first.fetch('id').to_i
  end

  def ==(project_to_compare)
    self.title()== project_to_compare.title()
  end

  def self.all
    project_list = DB.exec("SELECT * FROM projects;")
    projects = []
    project_list.each do |project|
      title = project.fetch("title")
      id = project.fetch("id").to_i
      projects.push(Project.new({:title => title, :id => id}))
    end
    projects
  end

  def self.find(id)
    Project.all.each do |project|
      if project.id == id
        return project
      end
    end
  end

  def volunteers
    volunteer_list = DB.exec("SELECT * FROM volunteers WHERE project_id = #{@id};")
    volunteers = []
    volunteer_list.each do |vounteer|
      name = volunteer.fetch("name")
      project_id = volunteer.fetch("project_id").to_i
      id = volunteer.fetch("id").to_i
      volunteers.push(Volunteer.new({:name => name, :project_id => project_id, :id => id}))
    end
    volunteers
  end

  def update(attr)
    @title = attr.fetch(:title)
    @id = self.id
    DB.exec("UPDATE projects SET title = '#{@title}' WHERE id = #{@id};")
  end
  

end
