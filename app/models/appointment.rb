class Appointment < ApplicationRecord
  validates_uniqueness_of :start_time
  belongs_to :slug
  belongs_to :user
  belongs_to :property
  belongs_to :contact


  after_create do
    ChangeAppointmentsJob.perform_later self
    NotificationsJob.perform_later 'create_appointment' if important
  end

  after_update do
    ChangeAppointmentsJob.perform_later self
    NotificationsJob.perform_later 'update_appointment' if important
  end
end
