module IconHelper
  # Sized in em so an icon follows the font size of its context, and filled with
  # currentColor so it follows the text color, the way the icon font did.
  BASE_CLASSES = "inline-block w-[1em] h-[1em] align-[-0.125em]".freeze

  # Icons are decorative by default. Pass a title only when the icon carries
  # meaning that no nearby text already conveys.
  def icon(name, css: nil, title: nil)
    definition = Icon.find(name)
    paths = definition.fetch(:paths).map { |d| tag.path(d: d) }
    paths.unshift(tag.title(title)) if title

    tag.svg(safe_join(paths),
            class: [ BASE_CLASSES, css ].compact.join(" "),
            "viewBox" => definition.fetch(:view_box),
            xmlns: "http://www.w3.org/2000/svg",
            fill: "currentColor",
            "aria-hidden" => (title ? nil : "true"),
            role: (title ? "img" : nil),
            focusable: "false")
  end
end
