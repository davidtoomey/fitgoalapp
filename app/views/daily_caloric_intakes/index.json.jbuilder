json.array!(@daily_caloric_intakes) do |daily_caloric_intake|
  json.extract! daily_caloric_intake, :id, :user_id, :calories
  json.url daily_caloric_intake_url(daily_caloric_intake, format: :json)
end
