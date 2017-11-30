require 'station'

describe Station do
  subject(:station) {described_class.new}

  it 'should give access to station name' do
    expect(station).to respond_to(:name)
  end

  it 'should give access to zone' do
    expect(station).to respond_to(:zone)
  end

end
