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
    projects
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

    end
  end


end
