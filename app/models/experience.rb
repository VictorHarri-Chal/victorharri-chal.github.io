class Experience
  include Catalog

  attr_reader :company, :role, :location, :period, :badge, :description, :link, :technologies

  def initialize(company:, role:, location:, period:, description:, technologies:,
                 badge: nil, link: nil)
    @company = company
    @role = role
    @location = location
    @period = period
    @badge = badge
    @description = description
    @link = link
    @technologies = technologies
  end

  class << self
    def professional
      build(:experience)
    end

    def education
      build(:education)
    end

    private

    def catalog_name = "experiences"

    def build(section)
      catalog.fetch(section).map { |attributes| new(**attributes) }
    end
  end
end
