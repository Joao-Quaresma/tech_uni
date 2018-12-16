class StudentsController < ApplicationController
  before_action :set_student, only: %i[show edit update]
  skip_before_action :require_user, only: %i[new create]
  before_action :require_same_student, only: %i[edit update]

  def index
    @students = Student.all
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      flash[:notice] = "You have succesfully signed up"
      redirect_to @student
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @student.update(student_params)
      flash[:notice] = "You have succesfully updated your profile"
      redirect_to @student
    else
      render 'edit'
    end
  end

  def show
  end

  private
  def student_params
    params.require(:student).permit(:name, :email, :password)
  end

  def set_student
    @student = Student.find(params[:id])
  end

  def require_same_student
    if current_user != @student
      flash[:notice] = "You can only edit your own profile"
      redirect_to student_path(current_user)
    end
  end
end