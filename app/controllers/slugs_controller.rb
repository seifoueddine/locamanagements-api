class SlugsController < ApplicationController
  before_action :set_slug, only: [:show, :update, :destroy]

  # GET /slugs
  def index
    @slugs = Slug.all

    render json: @slugs
  end

  # GET /slugs/1
  def show
    render json: @slug
  end

  # POST /slugs
  def create
    @slug = Slug.new(slug_params)

    if @slug.save
      render json: @slug, status: :created, location: @slug
    else
      render json: @slug.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /slugs/1
  def update
    if @slug.update(slug_params)
      render json: @slug
    else
      render json: @slug.errors, status: :unprocessable_entity
    end
  end

  # DELETE /slugs/1
  def destroy
    @slug.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_slug
      @slug = Slug.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def slug_params
      params.require(:slug).permit(:name)
    end
end
