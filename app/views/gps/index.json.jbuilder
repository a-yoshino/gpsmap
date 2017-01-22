json.array!(@gps) do |gp|
  json.extract! gp, :id, :lat, :lon
  json.url gp_url(gp, format: :json)
end
