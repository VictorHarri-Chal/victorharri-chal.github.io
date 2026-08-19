class Skill
  include Catalog

  def self.groups
    catalog.fetch(:groups)
  end

  def self.catalog_name = "technologies"
  private_class_method :catalog_name
end
