class Project
  attr_accessor(:title, :id)

  def initialize(attr)
    @title = attr.fetch(:title)
    @id = attributes.fetch(:id)
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
end
