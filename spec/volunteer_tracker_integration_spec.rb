require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

# DB = PG.connect({:dbname=>'volunteer_tracker_test'})

describe('volunteer tracker',{:type => :feature}) do

  it('on click of check on projects, displays project page') do
    visit('/')
    click_on('Click here to check on projects')
    expect(page).to have_content('Here are the projects in this database')
  end

  it('on click of project name, displays project information') do
    test_project = Project.new({:name => "Blood collection volunteer", :id => nil, :hours => 0})
    test_project.save()
    visit('/projects')
    click_on('Blood collection volunteer')
    expect(page).to have_content('Blood collection volunteer')
  end

  it('on click of Add a new project, page ask for new project name') do
    visit('/projects')
    click_link('Add a new project')
    expect(page).to have_content('Enter name for new project:')
  end

  it('Add a new project') do
    visit('/project/new')
    fill_in('name', :with => 'Food planner')
    click_button('Save')
    expect(page).to have_content('Food planner')
  end

  it('Refresh volunteer count') do
    test_project = Project.new({:name => "Blood collection volunteer", :id => nil, :hours => 0})
    test_project.save()
    new_volunteer = Volunteer.new({:name => "Bob Authors", :id => nil, :hours => 10, :phone_number => '4567891012', :project_id => test_project.id()})
    new_volunteer.save()
    new_volunteer1 = Volunteer.new({:name => "Bob Authors", :id => nil, :hours => 20, :phone_number => '4567891012', :project_id => test_project.id()})
    new_volunteer1.save()
    visit("/projects/#{test_project.id()}")
    click_button('Refresh volunteer hours')
    expect(page).to have_content(30)
  end

  it('Rename project button') do
    test_project = Project.new({:name => "Blood collection volunteer", :id => nil, :hours => 0})
    test_project.save()
    visit("/projects/#{test_project.id()}")
    click_button('Rename Blood collection volunteer')
    expect(page).to have_content('Rename your project:')
  end

  it('Rename project') do
    test_project = Project.new({:name => "Blood collection volunteer", :id => nil, :hours => 0})
    test_project.save()
    visit("/projects/#{test_project.id()}")
    click_button('Rename Blood collection volunteer')
    fill_in("name", :with => "Food planner")
    click_button('Update')
    expect(page).to have_content('Food planner')
  end

  it('Delete project') do
    test_project = Project.new({:name => "Blood collection volunteer", :id => nil, :hours => 0})
    test_project.save()
    visit("/projects/#{test_project.id()}")
    click_button('Delete Blood collection volunteer')
    expect(page).to have_content('There are no projects added yet!')
  end

  it('on click of check on volunteers, displays volunteer page') do
    visit('/')
    click_on('Click here to check on volunteers')
    expect(page).to have_content('Here are the list of Volunteers:')
  end

  it('on click of volunteer name, displays volunteer information') do
    new_volunteer = Volunteer.new({:name => "Bob Authors", :id => nil, :hours => 0, :phone_number => '4567891012', :project_id => 1})
    new_volunteer.save()
    visit('/volunteers')
    click_on('Bob Authors')
    expect(page).to have_content('Bob Authors')
  end

  it('Add a new volunteer button') do
    visit('/volunteers')
    click_on('Add a new volunteer')
    expect(page).to have_content('Enter volunteer information')
  end

  it('Add a new volunteer') do
    test_project = Project.new({:name => "Blood collection volunteer", :id => nil, :hours => 0})
    test_project.save()
    visit('/volunteer/new')
    fill_in('name', :with=> "Joe")
    fill_in('phone_number', :with=> "45678910")
    fill_in('hours', :with=> 0)
    select('Blood collection volunteer', from: 'project_id')
    click_on('Save')
    expect(page).to have_content('Joe')
  end

  it('Add volunter hours') do
    new_volunteer = Volunteer.new({:name => "Bob Authors", :id => nil, :hours => 5, :phone_number => '4567891012', :project_id => 1})
    new_volunteer.save()
    visit("/volunteer/#{new_volunteer.id()}")
    click_button('Add volunteer hours')
    expect(page).to have_content('Bob Authors')
    fill_in('hour', :with=> 10)
    click_button('Update')
    expect(page).to have_content(15)
  end

  it('Reassign project') do
    test_project = Project.new({:name => "Blood collection volunteer", :id => nil, :hours => 0})
    test_project.save()
    new_volunteer = Volunteer.new({:name => "Bob Authors", :id => nil, :hours => 5, :phone_number => '4567891012', :project_id => 1})
    new_volunteer.save()
    visit("/volunteer/#{new_volunteer.id()}")
    click_button('Reassign project')
    expect(page).to have_content('Bob Authors')
    select('Blood collection volunteer', from: 'project_id')
    click_button('Update')
    expect(page).to have_content('Blood collection volunteer')
  end

  it('Delete volunteer') do
    new_volunteer = Volunteer.new({:name => "Bob Authors", :id => nil, :hours => 5, :phone_number => '4567891012', :project_id => 1})
    new_volunteer.save()
    visit("/volunteer/#{new_volunteer.id()}")
    click_button('Delete Bob Authors')
    expect(page).to have_content('There are no volunteers added yet!')
  end

end
