RSpec.describe GeocoderService::Client, type: :client do
  subject { described_class.new(connection: connection) }

  let(:status) { 200 }
  let(:headers) { { 'Content-Type' => 'application/json' } }
  let(:body) { [] }

  before do
    stubs.get('geocoder') { [status, headers, body.to_json] }
  end

  describe '#geocoder' do
    let(:city) { 'Славгород' }
    let(:body) { [52.999463, 78.6459232] }

    it 'returns coordinates' do
      expect(subject.geocode(city)).to eq body
    end
  end
end
