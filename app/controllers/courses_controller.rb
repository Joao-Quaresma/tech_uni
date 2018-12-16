class CoursesController < ApplicationController
  skip_before_action :require_user, only: %i[index]
  def index
    @courses = Course.all
  end

  def new
  end
end
