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
