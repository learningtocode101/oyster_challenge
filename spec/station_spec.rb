require 'station'
describe Station do

  subject {described_class.new(:name, :zone)}
  let(:name) {double :name}
  let(:zone) {double :zone}
  
  it "expects name to equal Bank" do
    expect(subject.name).to eq(:name)
  end

  it "expects zone to equal 1" do
    expect(subject.zone).to eq(:zone)
  end

end
