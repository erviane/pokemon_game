class SkillsController < ApplicationController
  before_action :set_skill, only: [:show, :edit, :update, :destroy]

  # GET /skills
  # GET /skills.json
  def index
    @skills = Skill.all.order("created_at DESC").paginate(page: params[:page], per_page: 20)
  end

  # GET /skills/1
  # GET /skills/1.json
  def show
  end

  # GET /skills/new
  def new
    @skill = Skill.new
  end

  # GET /skills/1/edit
  def edit
  end

  # POST /skills
  # POST /skills.json
  def create
    @skill = Skill.new(skill_params)
      if @skill.save
        redirect_to skills_url
        flash[:success] = "New skill was successfully created"
      else
        render :new
      end
  end

  # PATCH/PUT /skills/1
  # PATCH/PUT /skills/1.json
  def update
      if @skill.update(skill_params)
        redirect_to skills_url
        flash[:success] = "Skill was successfully updated"
      else
        render :edit
      end
  end

  # DELETE /skills/1
  # DELETE /skills/1.json
  def destroy
    @skill.destroy
    redirect_to skills_url
    flash[:success] = "Skill was successfully destroyed"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_skill
      @skill = Skill.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def skill_params
      params.require(:skill).permit(:name, :power, :max_pp, :element_type  )
    end
end
