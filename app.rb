require('pry')
require('launchy')
require('sinatra')
require('sinatra/reloader')
require('./lib/project')
require('./lib/volunteer')
require('pg')
also_reload('./**/*.rb')

DB = PG.connect({:dbname=>'volunteer_tracker'})

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
  id = params.fetch("id").to_i()
  @project = Project.find(id)
  @project.update_hours()
  @project = Project.find(id)
  erb(:project_details)
end

delete ('/projects/:id') do
  id = params.fetch("id").to_i()
  @project = Project.find(id)
  @project.delete()
  @projects = Project.all()
  erb(:project_list)
end

post ('/project/rename/:id') do
  id = params.fetch("id").to_i()
  @project = Project.find(id)
  erb(:project_rename)
end

patch ('/project/edit/:id') do
  id = params.fetch("id").to_i()
  name = params.fetch("name")
  @project = Project.find(id)
  @project.update({:name=> name})
  @projects = Project.all()
  erb(:project_list)
end

get ('/project/new') do
  erb(:new_project_form)
end

post ('/project/new') do
  name = params.fetch("name")
  new_project = Project.new({:name => name, :id => nil, :hours => 0})
  new_project.save()
  @projects = Project.all()
  erb(:project_list)
end

get('/volunteers') do
  @volunteers = Volunteer.all()
  erb(:volunteers_list)
end

get('/volunteer/new') do
  @projects = Project.all()
  erb(:new_volunteer_form)
end

post('/volunteer/new') do
  name = params.fetch("name")
  phone_number = params.fetch("phone_number")
  hours = params.fetch("hours")
  project_id = params.fetch("project_id").to_i()
  new_volunteer = Volunteer.new({:name => name, :id => nil, :hours => hours, :phone_number => phone_number, :project_id => project_id})
  new_volunteer.save()
  @volunteers = Volunteer.all()
  erb(:volunteers_list)
end

get ('/volunteer/:id') do
  @volunteer = Volunteer.find(params.fetch("id").to_i())
  erb(:volunteer_details)
end

delete ('/volunteer/:id') do
  @volunteer = Volunteer.find(params.fetch("id").to_i())
  @volunteer.delete()
  @volunteers = Volunteer.all()
  erb(:volunteers_list)
end

post ('/volunteer/update/:id') do
  @volunteer = Volunteer.find(params.fetch("id").to_i())
  erb(:volunteer_update)
end

patch ('/volunteer/update/:id') do
  @volunteer = Volunteer.find(params.fetch("id").to_i())
  hours = params.fetch('hour').to_i()
  @volunteer.update({:hours=>hours})
  erb(:volunteer_details)
end

post ('/volunteer/reassign/:id') do
  @volunteer = Volunteer.find(params.fetch("id").to_i())
  @projects = Project.all()
  erb(:volunteer_reassign)
end

patch ('/volunteer/reassign/:id') do
  @volunteer = Volunteer.find(params.fetch("id").to_i())
  project_id = params.fetch('project_id').to_i()
  @volunteer.update_project({:project_id=>project_id})
  @projects = Project.all()
  erb(:volunteer_details)
end
