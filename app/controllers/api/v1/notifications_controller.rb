class Api::V1::NotificationsController < ApplicationController
  before_action :set_notification, only: %i[show update destroy]

  # GET /notifications
  def index
    slug_id = get_slug_id
    @notifications = Notification.where(slug_id: slug_id, target_id: params[:user_id])
                                 .order('created_at DESC')
    json_string = NotificationSerializer.new(@notifications)
                                       .serializable_hash.to_json
    render json: json_string
  end

  # GET /notifications/1
  def show
    render json: @notification
  end

  # POST /notifications
  def create
    @notification = Notification.new(notification_params)

    if @notification.save
      render json: @notification, status: :created, location: @notification
    else
      render json: @notification.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /notifications/1
  def update
    if @notification.update(notification_params)
      render json: @notification
    else
      render json: @notification.errors, status: :unprocessable_entity
    end
  end

  # DELETE /notifications/1
  def destroy
    @notification.destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_notification
    @notification = Notification.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def notification_params
    params.require(:notification).permit(:target_type, :target_id,:notifier_avatar,
                                         :data, :notifier_id, :opened_at, :read,
                                         :notifier_name)
  end
end
