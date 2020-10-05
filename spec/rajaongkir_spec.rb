RSpec.describe Rajaongkir do
  it 'has a version number' do
    expect(Rajaongkir::VERSION).not_to be nil
  end

  context 'when it initialize' do
    let(:api_key) { 's0m34p1k3y' }

    it 'return Rajaongkir API instance' do
      rajaongkir = described_class.new(api_key)
      expect(rajaongkir).to be_kind_of(Rajaongkir::API)
      expect(rajaongkir.api_key).to eq(api_key)
    end
  end
end
