class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show update change_password]


  # GET /users
  def index
    slug_id = get_slug_id
    params[:slug_id] = slug_id
    @users = if params[:slug_id].blank?
               User.order(order_and_direction).page(page).per(per_page)
             elsif params[:search].blank?
               User.order(order_and_direction).page(page).per(per_page)
                   .where(slug_id: params[:slug_id])
             else

               User.order(order_and_direction).page(page).per(per_page).where(slug_id: params[:slug_id])
                   .where(['lower(name) like ?
                            or lower(email) like ?',
                                    '%' + params[:search].downcase + '%',
                                    '%' + params[:search].downcase + '%',
                                    ])
             end
    set_pagination_headers :users
    json_string = UserSerializer.new(@users, include: [:slug]).serializable_hash.to_json
    render  json: json_string
  end

  # GET /users/1
  def show
    json_string = UserSerializer.new(@user, include: [:slug]).serializable_hash.to_json
    render  json: json_string
  end

  def change_password
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # POST /users
  def create
    slug_id = get_slug_id
    params[:slug_id] = slug_id unless slug_id.blank?
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    ids = params[:id].split(',')
    if ids.length != 1
      User.where(id: params[:id].split(',')).destroy_all
    else
      User.find(params[:id]).destroy
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

    # Only allow a trusted parameter "white list" through.
  def user_params
    params.permit(:email, :password, :name, :slug_id, :avatar, :role, :theme_color, :language)
  end
end
