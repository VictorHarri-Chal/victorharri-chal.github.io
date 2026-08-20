module SeoHelper
  SITE_NAME = "Victor Harri-Chal".freeze
  SITE_URL = "https://victorharri-chal.github.io".freeze
  DEFAULT_TITLE = "#{SITE_NAME} · Full-stack Ruby on Rails developer".freeze
  DEFAULT_DESCRIPTION = "Full-stack Ruby on Rails developer working remote from Nantes. " \
                        "Production monoliths, a nutrition product of my own, and currently " \
                        "looking for my next role.".freeze

  def page_title
    title = content_for(:title)
    title.present? ? "#{title} · #{SITE_NAME}" : DEFAULT_TITLE
  end

  def page_description
    content_for(:description).presence || DEFAULT_DESCRIPTION
  end

  # The site is served from the domain root and every page is also published at
  # <path>.html for the URLs it used to have, so each one names the clean URL as
  # the canonical version.
  def canonical_url
    "#{SITE_URL}#{request.path.chomp("/").presence || "/"}"
  end

  def og_image_url
    "#{SITE_URL}/og-image.png"
  end
end
