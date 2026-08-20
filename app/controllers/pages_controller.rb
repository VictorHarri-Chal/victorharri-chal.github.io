class PagesController < ApplicationController
  def home; end

  def about
    @skill_groups = Skill.groups
  end

  def experience
    @experiences = Experience.professional
    @education = Experience.education
  end

  def contact; end

  # Rendered to _site/404.html, which GitHub Pages serves for unknown URLs.
  # The status comes from Pages, so this route itself answers 200.
  def not_found; end
end
