RSpec.describe Rajaongkir::API do
  let(:api_key) { 's0m34p1k3y' }
  let(:type) { 'starter' }
  let(:opts) {
    {
      host: 'https://api.rajaongkir.com',
      type: type,
      timeout: 5,
      open_timeout: 5
    }
  }

  context 'when it initialize' do
    it 'return Rajaongkir API instance' do
      rajaongkir = described_class.new(api_key, opts)
      expect(rajaongkir).to be_kind_of(Rajaongkir::API)
      expect(rajaongkir.api_key).to eq(api_key)
      expect(rajaongkir.host).to eq(opts[:host])
      expect(rajaongkir.type).to eq(opts[:type])
      expect(rajaongkir.timeout).to eq(opts[:timeout])
      expect(rajaongkir.open_timeout).to eq(opts[:open_timeout])
    end

    context 'url generation' do
      it 'returns the url' do
        rajaongkir = described_class.new(api_key, opts)
        expect(rajaongkir.send('url')).to eq("#{opts[:host]}/#{opts[:type]}")
      end

      context 'when the type is pro' do
        let(:type) { 'pro' }

        it 'returns the url' do
          rajaongkir = described_class.new(api_key, opts)
          expect(rajaongkir.send('url')).to eq('https://pro.rajaongkir.com/api')
        end
      end
    end
  end

  context 'API requests' do
    let(:request_body) { {} }
    let(:request_query) {}

    let(:test_request) {
      {
        body: request_body,
        query: request_query
      }
    }
    let(:test_response) {
      {
        headers: {},
        status: response_code,
        body: {
          rajaongkir: {
            query: [],
            status: status,
            results: results
          }
        }.to_json
      }
    }

    let(:response) { described_class.new(api_key, opts).send(resource, params) }

    before do
      stub_request(request_type, /rajaongkir/).with(test_request).to_return(test_response)
    end

    describe '.province' do
      let(:request_type) { :get }
      let(:resource) { 'province' }
      let(:params) { {} }
      let(:response_code) { 200 }
      let(:response_description) { 'OK' }
      let(:status) { { code: response_code, description: response_description } }
      let(:results) {
        [
          {
            province_id: '1',
            province: 'Bali'
          },
          {
            province_id: '2',
            province: 'Bangka Belitung'
          },
          {
            province_id: '3',
            province: 'Banten'
          },
          {
            province_id: '4',
            province: 'Bengkulu'
          },
          {
            province_id: '5',
            province: 'DI Yogyakarta'
          },
          {
            province_id: '6',
            province: 'DKI Jakarta'
          },
          {
            province_id: '7',
            province: 'Gorontalo'
          },
          {
            province_id: '8',
            province: 'Jambi'
          },
          {
            province_id: '9',
            province: 'Jawa Barat'
          },
          {
            province_id: '10',
            province: 'Jawa Tengah'
          },
          {
            province_id: '11',
            province: 'Jawa Timur'
          },
          {
            province_id: '12',
            province: 'Kalimantan Barat'
          },
          {
            province_id: '13',
            province: 'Kalimantan Selatan'
          },
          {
            province_id: '14',
            province: 'Kalimantan Tengah'
          },
          {
            province_id: '15',
            province: 'Kalimantan Timur'
          },
          {
            province_id: '16',
            province: 'Kalimantan Utara'
          },
          {
            province_id: '17',
            province: 'Kepulauan Riau'
          },
          {
            province_id: '18',
            province: 'Lampung'
          },
          {
            province_id: '19',
            province: 'Maluku'
          },
          {
            province_id: '20',
            province: 'Maluku Utara'
          },
          {
            province_id: '21',
            province: 'Nanggroe Aceh Darussalam (NAD)'
          },
          {
            province_id: '22',
            province: 'Nusa Tenggara Barat (NTB)'
          },
          {
            province_id: '23',
            province: 'Nusa Tenggara Timur (NTT)'
          },
          {
            province_id: '24',
            province: 'Papua'
          },
          {
            province_id: '25',
            province: 'Papua Barat'
          },
          {
            province_id: '26',
            province: 'Riau'
          },
          {
            province_id: '27',
            province: 'Sulawesi Barat'
          },
          {
            province_id: '28',
            province: 'Sulawesi Selatan'
          },
          {
            province_id: '29',
            province: 'Sulawesi Tengah'
          },
          {
            province_id: '30',
            province: 'Sulawesi Tenggara'
          },
          {
            province_id: '31',
            province: 'Sulawesi Utara'
          },
          {
            province_id: '32',
            province: 'Sumatera Barat'
          },
          {
            province_id: '33',
            province: 'Sumatera Selatan'
          },
          {
            province_id: '34',
            province: 'Sumatera Utara'
          }
        ]
      }

      it { expect(response).to be_kind_of(Rajaongkir::Response) }
      it { expect(response.results).to eq(JSON.parse(results.to_json)) }

      context 'specific province' do
        let(:params) { { province_id: 1 } }
        let(:request_query) { hash_including(id: '1')  }

        let(:results) {
          {
            province_id: '1',
            province: 'Bali'
           }
        }

        it { expect(response).to be_kind_of(Rajaongkir::Response) }
        it { expect(response.results).to eq(JSON.parse(results.to_json)) }
      end
    end

    describe '.cities' do
      let(:request_type) { :get }
      let(:resource) { 'city' }
      let(:params) { {} }
      let(:response_code) { 200 }
      let(:response_description) { 'OK' }
      let(:status) { { code: response_code, description: response_description } }
      let(:results) {
        [
          {
            city_id: '1',
            province_id: '21',
            province: 'Nanggroe Aceh Darussalam (NAD)',
            type: 'Kabupaten',
            city_name: 'Aceh Barat',
            postal_code: '23681'
          },
          {
            city_id: '2',
            province_id: '21',
            province: 'Nanggroe Aceh Darussalam (NAD)',
            type: 'Kabupaten',
            city_name: 'Aceh Barat Daya',
            postal_code: '23764'
          },
          {
            city_id: '3',
            province_id: '21',
            province: 'Nanggroe Aceh Darussalam (NAD)',
            type: 'Kabupaten',
            city_name: 'Aceh Besar',
            postal_code: '23951'
          },
          {
            city_id: '4',
            province_id: '21',
            province: 'Nanggroe Aceh Darussalam (NAD)',
            type: 'Kabupaten',
            city_name: 'Aceh Jaya',
            postal_code: '23654'
          },
          {
            city_id: '5',
            province_id: '21',
            province: 'Nanggroe Aceh Darussalam (NAD)',
            type: 'Kabupaten',
            city_name: 'Aceh Selatan',
            postal_code: '23719'
          }
        ]
      }

      it { expect(response).to be_kind_of(Rajaongkir::Response) }
      it { expect(response.results).to eq(JSON.parse(results.to_json)) }

      context 'specific city' do
        let(:params) { { city_id: 1 } }
        let(:request_query) { hash_including(id: '1')  }

        let(:results) {
          {
            city_id: '1',
            province_id: '21',
            province: 'Nanggroe Aceh Darussalam (NAD)',
            type: 'Kabupaten',
            city_name: 'Aceh Barat',
            postal_code: '23681'
          }
        }

        it { expect(response).to be_kind_of(Rajaongkir::Response) }
        it { expect(response.results).to eq(JSON.parse(results.to_json)) }
      end
    end


    describe '.cost' do
      let(:request_type) { :post }
      let(:resource) { 'cost' }
      let(:params) {
        {
          origin: '1',
          destination: '2',
          weight: 1,
          courier: 'jne'
        }
      }
      let(:request_body) { params }
      let(:response_code) { 200 }
      let(:response_description) { 'OK' }
      let(:status) { { code: response_code, description: response_description } }
      let(:results) {
        [
          {
            code: 'jne',
            name: 'Jalur Nugraha Ekakurir (JNE)',
            costs: [
              {
                service: 'OKE',
                description: 'Ongkos Kirim Ekonomis',
                cost: [
                  {
                    value: 18000,
                    etd: '4-6',
                    note: ''
                  }
                ]
              },
              {
                service: 'REG',
                description: 'Layanan Reguler',
                cost: [
                  {
                    value: 20000,
                    etd: '2-3',
                    note: ''
                  }
                ]
              }
            ]
          }
        ]
      }

      it { expect(response).to be_kind_of(Rajaongkir::Response) }
      it { expect(response.results).to eq(JSON.parse(results.to_json)) }
    end
  end
end
