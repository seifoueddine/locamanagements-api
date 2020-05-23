class  Api::V1::DashboardController < ApplicationController


  def appointments
    slug_id = get_slug_id
    after_days = Date.today + params[:days].to_i
    @appointments = Appointment.where(slug_id: slug_id)
                               .where('(start_time >= ? AND start_time <= ? )',
                                       Date.today , after_days)
    important_count = @appointments.where(important: true).count
    visit_count = @appointments.where(service: 'visit').count
    call_count = @appointments.where(service: 'call').count
    stats = { stats: { important_count: important_count,
                       visit_count: visit_count,
                       call_count: call_count } }
    json_string = AppointmentSerializer.new(@appointments)

    render json: [json_string, stats]
  end

  def contacts_properties_stat
    slug_id = get_slug_id
    properties_rented = Property.where(transaction_type: 'rent', slug_id: slug_id)
                                .where.not(contract_id: nil).count
    properties_to_rent = Property.where(transaction_type: 'rent', slug_id: slug_id)
                                 .count
    all_clients = Contact.where(slug_id: slug_id, roles: 'client').count
    contracts = Contract.where(slug_id: slug_id)
    all_tenant = contracts.uniq { |contract| contract['contact_id'] }.count
    all_owners = Contact.where(slug_id: slug_id, roles: 'owner').count
    properties = Property.where(slug_id: slug_id)
    all_actif_owners = properties.uniq { |property| property['contact_id'] }.count
    stats = { stats: { properties_rented: properties_rented,
                       properties_to_rent: properties_to_rent,
                       all_clients: all_clients,
                       all_tenant: all_tenant,
                       all_owners: all_owners,
                       all_actif_owners: all_actif_owners} }
    render json: stats
  end

  def unpaid_contract
    after_7days = Date.today + params[:days].to_i

    slug_id = get_slug_id
    unpaid_contract = []
    contracts = Contract.where(slug_id: slug_id)
    contracts.map{|contract|
                   contract.payment_periods.map{|per|
                                                 if  per['is_paid'] === false && per['start'].to_datetime < after_7days
                                                   unpaid_contract << contract
                                                 end
                                               }
                 }
    unpaid_contract = unpaid_contract.uniq { |contract| contract[:id]}
    json_string = ContractSerializer.new(unpaid_contract, include: %i[contact properties]).serialized_json
    render json: json_string
  end


end
