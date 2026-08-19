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
end
