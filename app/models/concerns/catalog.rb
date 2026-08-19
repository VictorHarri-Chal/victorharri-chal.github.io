# Loads a YAML catalog from config/. The site has no database: these files are
# the source of truth. Contents are memoized outside development so editing a
# catalog locally takes effect without a restart.
module Catalog
  extend ActiveSupport::Concern

  class_methods do
    def catalog
      return read_catalog if Rails.application.config.enable_reloading

      @catalog ||= read_catalog
    end

    private

    def read_catalog
      YAML.load_file(Rails.root.join("config", "#{catalog_name}.yml"), symbolize_names: true)
    end
  end
end
