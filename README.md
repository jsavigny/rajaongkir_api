# RajaongkirApi

RajaOngkir API (https://rajaongkir.com/dokumentasi) Wrapper for Ruby

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rajaongkir_api'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install rajaongkir_api

## Usage

### Creating the client
```ruby
api_key = 's0m3k3y' # API Key from RajaOngkir
options = {
    host: 'https://api.rajaongkir.com',
    type: 'starter',
    timeout: 5,
    open_timeout: 5
}
rajaongkir = Rajaongkir.new(api_key, options)
```

### Province (https://rajaongkir.com/dokumentasi/starter#province-ringkasan)

```ruby
provinces = rajaongkir.province
# => <Rajaongkir::Response @results=[{"province_id"=>"1", "province"=>"Bali"}, {"province_id"=>"2", "province"=>"Bangka Belitung"}, {"province_id"=>"3", "province"=>"Banten"}, {"province_id"=>"4", "province"=>"Bengkulu"}, {"province_id"=>"5", "province"=>"DI Yogyakarta"}, {"province_id"=>"6", "province"=>"DKI Jakarta"}, {"province_id"=>"7", "province"=>"Gorontalo"}, {"province_id"=>"8", "province"=>"Jambi"}, {"province_id"=>"9", "province"=>"Jawa Barat"}, {"province_id"=>"10", "province"=>"Jawa Tengah"}, {"province_id"=>"11", "province"=>"Jawa Timur"}, {"province_id"=>"12", "province"=>"Kalimantan Barat"}, {"province_id"=>"13", "province"=>"Kalimantan Selatan"}, {"province_id"=>"14", "province"=>"Kalimantan Tengah"}, {"province_id"=>"15", "province"=>"Kalimantan Timur"}, {"province_id"=>"16", "province"=>"Kalimantan Utara"}, {"province_id"=>"17", "province"=>"Kepulauan Riau"}, {"province_id"=>"18", "province"=>"Lampung"}, {"province_id"=>"19", "province"=>"Maluku"}, {"province_id"=>"20", "province"=>"Maluku Utara"}, {"province_id"=>"21", "province"=>"Nanggroe Aceh Darussalam (NAD)"}, {"province_id"=>"22", "province"=>"Nusa Tenggara Barat (NTB)"}, {"province_id"=>"23", "province"=>"Nusa Tenggara Timur (NTT)"}, {"province_id"=>"24", "province"=>"Papua"}, {"province_id"=>"25", "province"=>"Papua Barat"}, {"province_id"=>"26", "province"=>"Riau"}, {"province_id"=>"27", "province"=>"Sulawesi Barat"}, {"province_id"=>"28", "province"=>"Sulawesi Selatan"}, {"province_id"=>"29", "province"=>"Sulawesi Tengah"}, {"province_id"=>"30", "province"=>"Sulawesi Tenggara"}, {"province_id"=>"31", "province"=>"Sulawesi Utara"}, {"province_id"=>"32", "province"=>"Sumatera Barat"}, {"province_id"=>"33", "province"=>"Sumatera Selatan"}, {"province_id"=>"34", "province"=>"Sumatera Utara"}]>

province = rajaongkir.province(province_id: 1)
# => #<Rajaongkir::Response @results={"province_id"=>"1", "province"=>"Bali"}>
```

### City (https://rajaongkir.com/dokumentasi/starter#city-ringkasan)

```ruby
cities = rajaongkir.city

# => #<Rajaongkir::Response @results=[{"city_id"=>"1", "province_id"=>"21", "province"=>"Nanggroe Aceh Darussalam (NAD)", "type"=>"Kabupaten", "city_name"=>"Aceh Barat", "postal_code"=>"23681"}, {"city_id"=>"2", "province_id"=>"21", "province"=>"Nanggroe Aceh Darussalam (NAD)", "type"=>"Kabupaten", "city_name"=>"Aceh Barat Daya", "postal_code"=>"23764"}, {"city_id"=>"3", "province_id"=>"21", "province"=>"Nanggroe Aceh Darussalam (NAD)", "type"=>"Kabupaten", "city_name"=>"Aceh Besar", "postal_code"=>"23951"}, {"city_id"=>"4", "province_id"=>"21", "province"=>"Nanggroe Aceh Darussalam (NAD)", "type"=>"Kabupaten", "city_name"=>"Aceh Jaya", "postal_code"=>"23654"}, {"city_id"=>"5", "province_id"=>"21", "province"=>"Nanggroe Aceh Darussalam (NAD)", "type"=>"Kabupaten", "city_name"=>"Aceh Selatan", "postal_code"=>"23719"}, {"city_id"=>"6", "province_id"=>"21", "province"=>"Nanggroe Aceh Darussalam (NAD)", "type"=>"Kabupaten", "city_name"=>"Aceh Singkil", "postal_code"=>"24785"}, {"city_id"=>"7", "province_id"=>"21", "province"=>"Nanggroe Aceh Darussalam (NAD)", "type"=>"Kabupaten", "city_name"=>"Aceh Tamiang", "postal_code"=>"24476"} ...]

city = rajaongkir.city(city_id: 1)
# => #<Rajaongkir::Response @results={"city_id"=>"1", "province_id"=>"21", "province"=>"Nanggroe Aceh Darussalam (NAD)", "type"=>"Kabupaten", "city_name"=>"Aceh Barat", "postal_code"=>"23681"}>
```

### Cost (https://rajaongkir.com/dokumentasi/starter#cost-ringkasan)

```ruby
cost = rajaongkir.cost(origin: 1, destination: 2, weight: 1, courier: 'jne')

# => #<Rajaongkir::Response @results=[{"code"=>"jne", "name"=>"Jalur Nugraha Ekakurir (JNE)", "costs"=>[{"service"=>"OKE", "description"=>"Ongkos Kirim Ekonomis", "cost"=>[{"value"=>18000, "etd"=>"4-6", "note"=>""}]}, {"service"=>"REG", "description"=>"Layanan Reguler", "cost"=>[{"value"=>20000, "etd"=>"2-3", "note"=>""}]}]}]>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jsavigny/rajaongkir_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/jsavigny/rajaongkir_api/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RajaongkirApi project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/jsavigny/rajaongkir_api/blob/master/CODE_OF_CONDUCT.md).
