# Inline SVG icons read from config/icons.yml, replacing the Font Awesome
# webfonts the site used to pull from a CDN.
class Icon
  include Catalog

  def self.find(name)
    catalog.fetch(name.to_sym) { raise KeyError, "unknown icon: #{name.inspect}" }
  end

  def self.names
    catalog.keys.map(&:to_s)
  end

  def self.catalog_name = "icons"
  private_class_method :catalog_name
end
