require 'pry'
class Project
  attr_reader(:name, :id, :hours)

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
    @hours = attributes[:hours]
  end

  def self.all
    returned_projects = DB.exec("SELECT * FROM projects")
    projects = []
    returned_projects.each() do |project|
      name = project.fetch("name")
      id = project.fetch("id").to_i()
      hours = project.fetch("hours").to_i()
      projects.push(Project.new(:name=>name, :id=>id, :hours=>hours))
    end
    return projects
  end

  def save
    result = DB.exec("INSERT INTO projects (name, hours) VALUES ('#{@name}', #{@hours}) RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def ==(another_project)
    (self.id() == another_project.id()) && (self.name() == another_project.name()) && (self.hours() == another_project.hours())
  end

  def self.find(id)
    found_project = nil
    Project.all().each() do |project|
      if project.id() == id
        found_project = project
      end
    end
    found_project
  end

  def volunteers
    project_volunteeers = []
    volunteers = DB.exec("SELECT * FROM volunteers WHERE project_id = #{self.id()};")

    volunteers.each() do |volunteer|
      name = volunteer.fetch("name")
      id = volunteer.fetch("id").to_i()
      hours = volunteer.fetch("hours").to_i()
      phone_number = volunteer.fetch("phone_number")
      project_id = volunteer.fetch("project_id").to_i()

      project_volunteeers.push(Volunteer.new(:name=>name, :id=>id, :hours=>hours, :phone_number => phone_number, :project_id => project_id))
    end
    project_volunteeers
  end

  def update(attributes)
    @name = attributes.fetch(:name, @name)
    @id = self.id()
    DB.exec("UPDATE projects SET name = '#{@name}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM projects WHERE id = #{self.id()};")
    DB.exec("DELETE FROM volunteers WHERE project_id = #{self.id()};")
  end

  def update_hours
    @id = self.id()
    returned_result = DB.exec("SELECT SUM(hours) FROM volunteers WHERE project_id = #{@id};")
    returned_result.each() do |result|
      @hours = result.fetch("sum").to_i()
    end
    DB.exec("UPDATE projects SET hours = '#{@hours}' WHERE id = #{@id};")
  end

  def self.sort_by_name
    projects = Project.all()
    projects_sorted = projects.sort_by(&:name)
    return projects_sorted
  end

  def self.sort_by_hours(order)
    projects = Project.all()
    if order == 'most'
      projects_sorted = projects.sort_by(&:hours).reverse
    elsif order == 'least'
      projects_sorted = projects.sort_by(&:hours)
    else
      projects_sorted = projects
    end
    return projects_sorted
  end

end
