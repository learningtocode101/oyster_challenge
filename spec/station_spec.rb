require 'station'
describe Station do

  subject(:station) {described_class.new(name, zone)}
  let(:name) {double :name}
  let(:zone) {double :zone}
  context 'is initialized' do
    it "know it's name" do
      expect(station.name).to eq(name)
    end

    it "knows it's zone" do
      expect(station.zone).to eq(zone)
    end
  end


end
