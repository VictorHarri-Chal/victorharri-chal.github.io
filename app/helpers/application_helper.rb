module ApplicationHelper
  # Tailwind only generates classes it can see written out, so these are spelled
  # in full rather than interpolated from the colour name in the catalogs.
  TECHNOLOGY_COLORS = {
    "red" => "bg-red-500/20 text-red-300",
    "blue" => "bg-blue-500/20 text-blue-300",
    "blue-dark" => "bg-blue-600/20 text-blue-300",
    "cyan" => "bg-cyan-500/20 text-cyan-300",
    "emerald" => "bg-emerald-500/20 text-emerald-300",
    "green" => "bg-green-500/20 text-green-300",
    "indigo" => "bg-indigo-500/20 text-indigo-300",
    "orange" => "bg-orange-500/20 text-orange-300",
    "purple" => "bg-purple-500/20 text-purple-300",
    "yellow" => "bg-yellow-500/20 text-yellow-300"
  }.freeze

  def technology_classes(technology)
    TECHNOLOGY_COLORS.fetch(technology[:color])
  end
end
