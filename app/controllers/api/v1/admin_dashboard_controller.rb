class Api::V1::AdminDashboardController < ApplicationController
  before_action :authenticate_user!
  def stats_count
    admin_users = User.where(role: 'admin').count
    agent_users = User.where(role: 'agent').count
    properties_rent = Property.where(transaction_type: 'rent').count
    properties_sell = Property.where(transaction_type: 'sell').count
    slugs = Slug.where.not(name: 'ADMIN').count
    slugs_free_demo = Slug.where(subscription_type: '1').count
    stats = { stats: { admin_users: admin_users,
                       agent_users: agent_users,
                       properties_rent: properties_rent,
                       properties_sell: properties_sell,
                       agencies: slugs,
                       agencies_free: slugs_free_demo } }
    render json: stats
  end
end
