require('spec_helper')

describe(Volunteer) do

  describe("#name,#hours, #project_id, #phone_number") do
    it("returns name , hours, project_id, phone_number") do
      new_volunteer = Volunteer.new({:name => "Bob Authors", :id => nil, :hours => 0, :phone_number => '4567891012', :project_id => 1})
      expect(new_volunteer.name()).to eq("Bob Authors")
      expect(new_volunteer.hours()).to eq(0)
      expect(new_volunteer.phone_number()).to eq('4567891012')
    end
  end

  describe(".all") do
    it("starts off with no lists") do
      expect(Volunteer.all()).to eq([])
    end
  end

  describe("#save") do
    it("lets you save volunteers to the database") do
      new_volunteer = Volunteer.new({:name => "Bob Authors", :id => nil, :hours => 0, :phone_number => '4567891012', :project_id => 1})
      new_volunteer.save()
      expect(Volunteer.all()).to eq([new_volunteer])
    end
  end

  describe("#==") do
   it("is the same volunteer if it has the same name, id, hours") do
     new_volunteer1 = Volunteer.new({:name => "Bob Authors", :id => nil, :hours => 0, :phone_number => '4567891012', :project_id => 1})
     new_volunteer2 = Volunteer.new({:name => "Bob Authors", :id => nil, :hours => 0, :phone_number => '4567891012', :project_id => 1})
     expect(new_volunteer1).to eq(new_volunteer2)
   end
 end

  describe(".find") do
    it("returns a volunteer by its ID") do
      new_volunteer = Volunteer.new({:name => "Bob Authors", :id => nil, :hours => 0, :phone_number => '4567891012', :project_id => 1})
      new_volunteer.save()
      new_volunteer1 = Volunteer.new({:name => "Joe Smith", :id => nil, :hours => 0, :phone_number => '4567891012', :project_id => 1})
      new_volunteer1.save()
      expect(Volunteer.find(new_volunteer1.id())).to eq(new_volunteer1)
    end
  end

  describe("#update") do
    it("lets you update projects in the database") do
      new_volunteer = Volunteer.new({:name => "Bob Authors", :id => nil, :hours => 5, :phone_number => '4567891012', :project_id => 1})
      new_volunteer.save()
      new_volunteer.update({:hours => 10})
      expect(new_volunteer.hours()).to(eq(15))
    end
  end

  describe("#delete") do
    it("lets you delete a volunteer from the database") do
      new_volunteer = Volunteer.new({:name => "Bob Authors", :id => nil, :hours => 5, :phone_number => '4567891012', :project_id => 1})
      new_volunteer.save()
      new_volunteer1 = Volunteer.new({:name => "Bob smith", :id => nil, :hours => 5, :phone_number => '4567891012', :project_id => 1})
      new_volunteer1.save()
      new_volunteer1.delete()
      expect(Volunteer.all()).to(eq([new_volunteer]))
    end
  end

  describe("#project_name") do
    it("returns project_name for that volunteer") do
      new_project = Project.new({:name => "Blood collection volunteer", :id => nil, :hours => 1})
      new_project.save()
      test_volunteer = Volunteer.new({:name => "Bob Authors", :id => nil, :hours => 1, :phone_number => '4567891012', :project_id => new_project.id()})
      test_volunteer.save()
      expect(test_volunteer.project_name()).to eq("Blood collection volunteer")
    end
  end

  describe("#sort_by_name") do
    it("lets you sort volunteers alphabetically") do
      new_volunteer1 = Volunteer.new({:name => "Joe Smith", :id => nil, :hours => 0, :phone_number => '4567891012', :project_id => 1})
      new_volunteer1.save()
      new_volunteer2 = Volunteer.new({:name => "Bob Smith", :id => nil, :hours => 0, :phone_number => '4567892022', :project_id => 2})
      new_volunteer2.save()
      expect(Volunteer.sort_by_name()).to eq([new_volunteer2, new_volunteer1])
    end
  end

  describe("#sort_by_hours") do
    it("lets you sort volunteers by hours(most to least)") do
      new_volunteer1 = Volunteer.new({:name => "Joe Smith", :id => nil, :hours => 20, :phone_number => '4567891012', :project_id => 1})
      new_volunteer1.save()
      new_volunteer2 = Volunteer.new({:name => "Bob Smith", :id => nil, :hours => 100, :phone_number => '4567892022', :project_id => 2})
      new_volunteer2.save()
      expect(Volunteer.sort_by_hours('most')).to eq([new_volunteer2, new_volunteer1])
    end

    it("lets you sort volunteers by hours(least to most)") do
      new_volunteer1 = Volunteer.new({:name => "Joe Smith", :id => nil, :hours => 20, :phone_number => '4567891012', :project_id => 1})
      new_volunteer1.save()
      new_volunteer2 = Volunteer.new({:name => "Bob Smith", :id => nil, :hours => 10, :phone_number => '4567892022', :project_id => 2})
      new_volunteer2.save()
      expect(Volunteer.sort_by_hours('least')).to eq([new_volunteer2, new_volunteer1])
    end
  end
end
