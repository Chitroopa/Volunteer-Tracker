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
      volunteers.push(Volunteer.new({:name=>name, :id=>id, :hours=>hours, :phone_number=> phone_number, :project_id=>project_id}))
      end
    return volunteers
  end

  def ==(another_volunteer)
    (self.id() == another_volunteer.id()) && (self.name() == another_volunteer.name()) && (self.hours() == another_volunteer.hours()) && (self.phone_number() == another_volunteer.phone_number()) && (self.project_id() == another_volunteer.project_id())
  end

  def save
    result = DB.exec("INSERT INTO volunteers (name, hours, project_id, phone_number) VALUES ('#{@name}', #{@hours}, #{@project_id},'#{@phone_number}') RETURNING id;")
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

  def update(attributes)
    @id = self.id()
    new_hours = attributes.fetch(:hours)
    old_hours = 0
    returned_result = DB.exec("SELECT hours FROM volunteers WHERE id = #{@id};")
    returned_result.each() do |result|
      old_hours = result.fetch("hours").to_i()
    end
    @hours = old_hours + new_hours
    DB.exec("UPDATE volunteers SET hours = #{@hours} WHERE id = #{@id};")
  end

  def update_project(attributes)
    @id = self.id()
    @project_id = attributes.fetch(:project_id)
    @hours = 0
    DB.exec("UPDATE volunteers SET hours = #{@hours} WHERE id = #{@id};")
    DB.exec("UPDATE volunteers SET project_id = #{@project_id} WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM volunteers WHERE id = #{self.id()};")
  end

  def project_name
    volunteeer_project_name = ""
    projects = DB.exec("SELECT * FROM projects WHERE id = #{self.project_id()};")
    projects.each() do |project|
      volunteeer_project_name = project.fetch("name")
    end
    return volunteeer_project_name
  end

  def self.sort_by_name
    volunteers = Volunteer.all()
    volunteers_sorted = volunteers.sort_by(&:name)
    return volunteers_sorted
  end

  def self.sort_by_hours(order)
    volunteers = Volunteer.all()
    if order == 'most'
      volunteers_sorted = volunteers.sort_by(&:hours).reverse
    elsif order == 'least'
      volunteers_sorted = volunteers.sort_by(&:hours)
    else
      volunteers_sorted = volunteers
    end
    return volunteers_sorted
  end
end
