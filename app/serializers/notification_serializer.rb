class NotificationSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel
  attributes :target_type, :target_id,
             :data, :notifier_id, :opened_at, :read, :created_at, :updated_at
end
