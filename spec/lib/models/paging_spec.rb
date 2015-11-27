require 'spec_helper'

describe Spotify::Models::Paging do

  let(:artist) { [
    { name: 'artist one' },
    { name: 'artist two' }
  ]}

  example "initializing a paging object" do

    # Example model. All models has the same behavior.
    model  = Spotify::Models::Artist
    paging = Spotify::Models::Paging.new({ items: artist }, model)

    expect(paging.items).to be_an_instance_of(Array)

    paging.items.zip(artist).each do |item, artist|
      expect(item).to      be_an_instance_of(model)
      expect(item.name).to be_eql(artist[:name])
    end

  end

end
