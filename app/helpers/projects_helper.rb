module ProjectsHelper
  # Tailwind only generates classes it can see written out, so these are spelled
  # in full rather than interpolated from the colour name in the catalog.
  ACCENTS = {
    "amber" => "border-amber-500/50 shadow-[0_0_30px_rgba(245,158,11,0.3)] hover:shadow-[0_0_40px_rgba(245,158,11,0.5)]",
    "purple" => "border-purple-500/50 shadow-[0_0_30px_rgba(168,85,247,0.3)] hover:shadow-[0_0_40px_rgba(168,85,247,0.5)]",
    "cyan" => "border-cyan-500/50 shadow-[0_0_30px_rgba(6,182,212,0.3)] hover:shadow-[0_0_40px_rgba(6,182,212,0.5)]",
    "emerald" => "border-emerald-500/50 shadow-[0_0_30px_rgba(16,185,129,0.3)] hover:shadow-[0_0_40px_rgba(16,185,129,0.5)]"
  }.freeze

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

  def project_accent_classes(project)
    ACCENTS.fetch(project.accent)
  end

  def technology_classes(technology)
    TECHNOLOGY_COLORS.fetch(technology[:color])
  end
end
