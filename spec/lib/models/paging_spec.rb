require 'spec_helper'

describe Spotify::Models::Paging do

  let(:artist) { [
    { name: 'artist one' },
    { name: 'artist two' }
  ]}

  context "initializing a paging object for" do

    example "Artists" do
      paging = Spotify::Models::Paging.new({ items: artist }, Spotify::Models::Artist)

      expect(paging.items).to be_an_instance_of(Array)

      paging.items.zip(artist).each do |item, artist|
        expect(item).to be_an_instance_of(Spotify::Models::Artist)
        expect(item.name).to be_eql(artist[:name])
      end

    end

  end

end
