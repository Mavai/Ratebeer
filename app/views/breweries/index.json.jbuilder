json.array!(@breweries) do |brewery|
  json.extract! brewery, :id, :name, :year, :active
  json.count brewery.beers.count
end