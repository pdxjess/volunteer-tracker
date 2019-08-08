require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/project')
require('./lib/volunteer')
require('pg')
require('pry')

DB = PG.connect({:dbname => "volunteer_tracker"})

get('/') do
  @projects = Project.all
  erb(:index)
end

post('/') do
  title = params.fetch("title")
  project = Project.new({:title => title, :id => nil})
  project.save
  @projects = Project.all
  erb(:index)
end

get('/projects/:id') do
  @project = Project.find(params.fetch(:id).to_i)
  @project.update({:title => title})
  erb(:project)
end

post('/projects/:id') do
  @project = Project.find(params.fetch(:id).to_i)
  name = params.fetch("name")
  project_id = @project.id.to_i
  volunteer = Volunteer.new({:name => name, :project_id => project_id, :id => nil})
  volunteer.save
  @volunteers = @project.volunteers
  erb(:project)
end

patch('/projects/:id') do
  title = params.fetch("title")
  @project = Project.find(params.fetch(:id).to_i)
  @project.update({:title => title})
  erb(:project)
end

delete('/projects/:id') do
  @project = Project.find(params.fetch(:id).to_i)
  @project.delete
  @projects = Project.all
  @volunteers = @project.volunteers
  erb(:index)
end

get('/volunteers/:id') do
  @volunteer = Volunteer.find(params.fetch(:id).to_i)
  erb(:volunteer)
end
