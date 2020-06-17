RSpec.describe Ads::CreateService do
  subject { described_class }

  let(:user_id) { 101 }

  context 'valid parameters' do
    let(:ad_params) do
      {
        title: 'Ad title',
        description: 'Ad description',
        city: 'City'
      }
    end

    it 'creates a new ad' do
      expect { subject.call(ad: ad_params, user_id: user_id) }
        .to change { Ad.count }.from(0).to(1)
    end

    it 'assigns ad' do
      result = subject.call(ad: ad_params, user_id: user_id)

      expect(result.ad).to be_kind_of(Ad)
    end

    context 'with coordinates' do
      let(:coordinates) { [213, 345] }
      let(:client) { double('Client') }

      before do
        allow(GeocoderService::Client).to receive(:new).and_return(client)
        allow(client).to receive(:geocode).and_return(coordinates)
      end

      it 'assigns ad with all fields' do
        ad = subject.call(ad: ad_params, user_id: user_id).ad

        expect(ad.title).to eq 'Ad title'
        expect(ad.description).to eq 'Ad description'
        expect(ad.city).to eq 'City'
        expect(ad.lat).to eq coordinates[0]
        expect(ad.lon).to eq coordinates[1]
      end
    end
  end

  context 'invalid parameters' do
    let(:ad_params) do
      {
        title: 'Ad title',
        description: 'Ad description',
        city: ''
      }
    end

    it 'does not create ad' do
      expect { subject.call(ad: ad_params, user_id: user_id) }
        .not_to change { Ad.count }
    end

    it 'assigns ad' do
      result = subject.call(ad: ad_params, user_id: user_id)

      expect(result.ad).to be_kind_of(Ad)
    end
  end
end
