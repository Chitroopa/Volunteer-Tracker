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


end
