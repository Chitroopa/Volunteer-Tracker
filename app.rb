require('pry')
require('launchy')
require('sinatra')
require('sinatra/reloader')
require('./lib/project')
require('./lib/volunteer')
require('pg')
also_reload('./**/*.rb')

DB = PG.connect({:dbname=>'volunteer_tracker_test'})

get('/') do
  erb(:index)
end

get('/projects') do
  @projects = Project.all()
  erb(:project_list)
end

get ('/projects/:id') do
  @project = Project.find(params.fetch("id").to_i())
  erb(:project_details)
end

patch ('/projects/:id') do
  @project = Project.find(params.fetch("id").to_i())
  
  erb(:project_details)
end
