class Api::V1::AdminDashboardController < ApplicationController
  before_action :authenticate_user!
  def stats_count
    admin_users = User.where(role: 'admin').count
    agent_users = User.where(role: 'agent').count
    properties_rent = Property.where(transaction_type: 'rent').count
    properties_sell = Property.where(transaction_type: 'sell').count
    stats = { stats: { admin_users: admin_users,
                       agent_users: agent_users,
                       properties_rent: properties_rent,
                       properties_sell: properties_sell,
                     } }
    render json: stats
  end
end
