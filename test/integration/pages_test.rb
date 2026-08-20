require "test_helper"

# These cover the failure modes this site actually hit: a page silently
# breaking, a catalog entry pointing at an icon that does not exist, and the
# build script drifting away from the project list.
class PagesTest < ActionDispatch::IntegrationTest
  STATIC_PATHS = %w[/ /about /experience /contact /projects].freeze

  def all_paths
    STATIC_PATHS + Project.slugs.map { |slug| "/projects/#{slug}" }
  end

  test "every page responds" do
    all_paths.each do |path|
      get path
      assert_response :success, "#{path} did not respond with 200"
    end
  end

  test "every page has exactly one h1" do
    all_paths.each do |path|
      get path
      assert_equal 1, response.body.scan("<h1").size, "#{path} should have exactly one h1"
    end
  end

  test "every page has its own title, description and canonical" do
    titles = all_paths.map do |path|
      get path

      description = response.body[/<meta name="description" content="(.*?)">/m, 1]
      assert description.to_s.length > 50, "#{path} has no usable description"

      canonical = response.body[/<link rel="canonical" href="(.*?)">/, 1]
      assert_equal "#{SeoHelper::SITE_URL}#{path.chomp("/").presence || "/"}", canonical

      response.body[%r{<title>(.*?)</title>}, 1]
    end

    assert_equal titles.size, titles.uniq.size, "two pages share a title"
  end

  test "an unknown project returns 404" do
    get "/projects/does-not-exist"

    assert_response :not_found
  end

  test "no page pulls anything from a third-party origin" do
    all_paths.each do |path|
      get path
      external = response.body
                         .scan(/<(?:link|script|img|iframe)[^>]*(?:href|src)="(https?:\/\/[^"]+)"/)
                         .flatten
                         .reject { |url| url.start_with?(SeoHelper::SITE_URL) }
      assert_empty external, "#{path} loads an external resource"
    end
  end

  test "every icon named in a catalog exists" do
    named = Project.featured.map { |project| project.link[:icon] } +
            Skill.groups.flat_map { |group| [ group[:icon] ] + group[:technologies].map { |t| t[:icon] } }

    (named.uniq - Icon.names).tap do |missing|
      assert_empty missing, "catalogs name icons that config/icons.yml does not define"
    end
  end

  test "the build script generates the same pages the app serves" do
    script = File.read(Rails.root.join("script", "build_static.rb"))
    STATIC_PATHS.each do |path|
      assert_includes script, %("#{path}"), "build_static.rb does not generate #{path}"
    end
  end
end
