RSpec.describe Rajaongkir::API do
  let(:api_key) { 's0m34p1k3y' }
  let(:type) { 'starter' }
  let(:opts) {
    {
      host: 'some.host',
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
          expect(rajaongkir.send('url')).to eq("https://pro.rajaongkir.com/api")
        end
      end
    end
  end
end
