class Volunteer
  attr_reader(:name, :id, :hours, :phone_number, :project_id)

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
    @hours = attributes[:hours]
    @phone_number = attributes[:phone_number]
    @project_id = attributes[:project_id]
  end

  def self.all
    returned_volunteers = DB.exec("SELECT * FROM volunteers")
    volunteers = []
    returned_volunteers.each() do |volunteer|
      name = volunteer.fetch("name")
      id = volunteer.fetch("id").to_i()
      hours = volunteer.fetch("hours").to_i()
      phone_number = volunteer.fetch("phone_number")
      project_id = volunteer.fetch("project_id").to_i()
      volunteers.push(Project.new(:name=>name, :id=>id, :hours=>hours, :phone_number => phone_number, :project_id => project_id))
    end
    return volunteers
  end

  def ==(another_volunteer)
    (self.id() == another_volunteer.id()) && (self.name() == another_volunteer.name()) && (self.hours() == another_volunteer.hours()) && (self.phone_number() == another_volunteer.phone_number()) && (self.project_id() == another_volunteer.project_id())
  end

  def save
    result = DB.exec("INSERT INTO volunteers (name, hours, project_id, phone_number) VALUES ('#{@name}', #{@hours}, '#{@project_id}','#{@phone_number}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def self.find(id)
    found_volunteer = nil
    Volunteer.all().each() do |volunteer|
      if volunteer.id() == id
        found_volunteer = volunteer
      end
    end
    return found_volunteer
  end

end
