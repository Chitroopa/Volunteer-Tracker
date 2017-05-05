require('spec_helper')

describe(Project) do

  describe("#name,#hours") do
    it("returns name , hours") do
      new_project = Project.new({:name => "Blood collection volunteer", :id => nil, :hours => 0})
      expect(new_project.name()).to eq("Blood collection volunteer")
      expect(new_project.hours()).to eq(0)
    end
  end

  describe(".all") do
    it("starts off with no lists") do
      expect(Project.all()).to eq([])
    end
  end

  describe("#save") do
    it("lets you save projects to the database") do
      new_project = Project.new({:name => "Blood collection volunteer", :id => nil, :hours => 0})
      new_project.save()
      expect(Project.all()).to eq([new_project])
    end
  end

  describe("#==") do
   it("is the same project if it has the same name, id, hours") do
     new_project1 = Project.new({:name => "Blood collection volunteer", :id => nil, :hours => 0})
     new_project2 = Project.new({:name => "Blood collection volunteer", :id => nil, :hours => 0})
     expect(new_project1).to eq(new_project2)
   end
 end

  describe(".find") do
    it("returns a project by its ID") do
      new_project = Project.new({:name => "Blood collection volunteer", :id => nil, :hours => 0})
      new_project.save()
      new_project1 = Project.new({:name => "Food donation fund collector", :id => nil, :hours => 0})
      new_project1.save()
      expect(Project.find(new_project1.id())).to eq(new_project1)
    end
  end

  describe("#volunteers") do
    it("returns an array of volunteers for that project") do
      test_project = Project.new({:name => "Blood collection volunteer", :id => nil, :hours => 0})
      test_project.save()
      test_volunteer = Volunteer.new({:name => "Bob Authors", :id => nil, :hours => 0, :phone_number => '4567891012', :project_id => test_project.id()})
      test_volunteer.save()
      test_volunteer2 = Volunteer.new({:name => "Joe Smith", :id => nil, :hours => 0, :phone_number => '4567891012', :project_id => test_project.id()})
      test_volunteer2.save()
      expect(test_project.volunteers()).to(eq [test_volunteer, test_volunteer2])
    end
  end

  describe("#update_hours") do
    it("lets you update projects in the database") do
      test_project = Project.new({:name => "Blood collection volunteer", :id => nil, :hours => 0})
      test_project.save()
      test_volunteer = Volunteer.new({:name => "Bob Authors", :id => nil, :hours => 4, :phone_number => '4567891012', :project_id => test_project.id()})
      test_volunteer.save()
      test_volunteer2 = Volunteer.new({:name => "Joe Smith", :id => nil, :hours => 5, :phone_number => '4567891012', :project_id => test_project.id()})
      test_volunteer2.save()
      test_project.update_hours()
      expect(test_project.hours()).to eq(9)
    end
  end

  describe("#update") do
    it("lets you to calculate total hours of all volunteers in a single project") do
      test_project = Project.new({:name => "Blood collection volunteer", :id => nil, :hours => 0})
      test_project.save()
      test_project.update({:name => "food planner"})
      expect(test_project.name()).to eq("food planner")
    end
  end

  describe("#delete") do
    it("lets you delete a project from the database") do
      new_project = Project.new({:name => "Blood collection volunteer", :id => nil, :hours => 0})
      new_project.save()
      new_project1 = Project.new({:name => "Food donation fund collector", :id => nil, :hours => 0})
      new_project1.save()
      new_project1.delete()
      expect(Project.all()).to eq([new_project])
    end

    it("deletes a projects's volunteers from the database") do
      new_project = Project.new({:name => "Blood collection volunteer", :id => nil, :hours => 0})
      new_project.save()
      test_volunteer = Volunteer.new({:name => "Bob Authors", :id => nil, :hours => 0, :phone_number => '4567891012', :project_id => new_project.id()})
      test_volunteer.save()
      test_volunteer2 = Volunteer.new({:name => "Joe Smith", :id => nil, :hours => 0, :phone_number => '4567891012', :project_id => new_project.id()})
      test_volunteer2.save()
      new_project.delete()
      expect(Project.all()).to eq([])
    end
  end

  describe("#sort_by_name") do
    it("lets you sort projects alphabetically") do
      new_project1 = Project.new({:name => "Food donation fund collector", :id => nil, :hours => 0})
      new_project1.save()
      new_project2 = Project.new({:name => "Blood collection volunteer", :id => nil, :hours => 0})
      new_project2.save()
      expect(Project.sort_by_name()).to eq([new_project2, new_project1])
    end
  end

  describe("#sort_by_hours") do
    it("lets you sort projects by hours(most to least)") do
      new_project1 = Project.new({:name => "Food donation fund collector", :id => nil, :hours => 400})
      new_project1.save()
      new_project2 = Project.new({:name => "Blood collection volunteer", :id => nil, :hours => 800})
      new_project2.save()
      expect(Project.sort_by_hours('most')).to eq([new_project2, new_project1])
    end

    it("lets you sort projects by hours(least to most)") do
      new_project1 = Project.new({:name => "Food donation fund collector", :id => nil, :hours => 400})
      new_project1.save()
      new_project2 = Project.new({:name => "Blood collection volunteer", :id => nil, :hours => 800})
      new_project2.save()
      new_project3 = Project.new({:name => "Collection volunteer", :id => nil, :hours => 20})
      new_project3.save()
      expect(Project.sort_by_hours('least')).to eq([new_project3, new_project1, new_project2 ])
    end
  end

end
