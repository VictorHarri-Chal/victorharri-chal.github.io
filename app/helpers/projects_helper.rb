module ProjectsHelper
  # Spelled in full for the same reason as ApplicationHelper::TECHNOLOGY_COLORS.
  ACCENTS = {
    "amber" => "border-amber-500/50 shadow-[0_0_30px_rgba(245,158,11,0.3)] hover:shadow-[0_0_40px_rgba(245,158,11,0.5)]",
    "purple" => "border-purple-500/50 shadow-[0_0_30px_rgba(168,85,247,0.3)] hover:shadow-[0_0_40px_rgba(168,85,247,0.5)]",
    "cyan" => "border-cyan-500/50 shadow-[0_0_30px_rgba(6,182,212,0.3)] hover:shadow-[0_0_40px_rgba(6,182,212,0.5)]",
    "emerald" => "border-emerald-500/50 shadow-[0_0_30px_rgba(16,185,129,0.3)] hover:shadow-[0_0_40px_rgba(16,185,129,0.5)]"
  }.freeze

  def project_accent_classes(project)
    ACCENTS.fetch(project.accent)
  end
end
