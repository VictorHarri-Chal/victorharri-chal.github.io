# Reads the project catalog from config/projects.yml. There is no database:
# the site is generated as static HTML, so the YAML file is the source of truth.
class Project
  CATALOG_PATH = Rails.root.join("config", "projects.yml")

  attr_reader :slug, :name, :period, :datetime, :accent, :size,
              :teaser, :summary, :link, :technologies, :features

  def initialize(slug:, name:, period:, datetime:, accent:, size:, teaser:, summary:,
                 link:, technologies:, features:)
    @slug = slug
    @name = name
    @period = period
    @datetime = datetime
    @accent = accent
    @size = size
    @teaser = teaser
    @summary = summary
    @link = link
    @technologies = technologies
    @features = features
  end

  def to_param = slug

  def large? = size == "large"

  class << self
    def featured
      catalog.fetch(:featured).map { |attributes| new(**attributes) }
    end

    def minor
      catalog.fetch(:minor)
    end

    def find(slug)
      featured.find { |project| project.slug == slug }
    end

    def slugs
      catalog.fetch(:featured).pluck(:slug)
    end

    private

    def catalog
      return read_catalog if Rails.application.config.enable_reloading

      @catalog ||= read_catalog
    end

    def read_catalog
      YAML.load_file(CATALOG_PATH, symbolize_names: true)
    end
  end
end
