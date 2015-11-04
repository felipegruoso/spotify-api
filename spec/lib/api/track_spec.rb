require 'spec_helper'

describe Spotify::API::Track do

  let(:id)     { '0eGsygTp906u18L0Oimnem' }
  let(:ids)    { ["0eGsygTp906u18L0Oimnem", "1lDWb6b6ieDQ2xT7ewTC3G"] }
  let(:market) { 'US' }

  context "#search_by_id" do

    example "Performs a simple request" do
      track = described_class.search_by_id(id: id)

      expect(track).to         be_an_instance_of(Spotify::Models::Track)
      expect(track.album).to   be_an_instance_of(Spotify::Models::Album)
      expect(track.artists).to be_an_instance_of(Array)

      track.artists.each do |artist|
        expect(artist).to be_an_instance_of(Spotify::Models::Artist)
      end
    end

    example "Uses market parameter" do
      track = described_class.search_by_id(id: id, market: market)

      expect(track).to be_an_instance_of(Spotify::Models::Track)
      expect(track.linked_from).to be_present
    end

    example "Missing mandatory parameter (:id)" do
      track = described_class.search_by_id

      expect(track).to be_an_instance_of(Hash)
      expect(track['error']).to be_present
    end

  end

  context "#search_by_ids" do

    example "Performs a simple request" do
      tracks = described_class.search_by_ids(ids: ids)

      expect(tracks).to be_an_instance_of(Array)

      tracks.each do |track|
        expect(track).to be_an_instance_of(Spotify::Models::Track)
      end
    end

    example "Uses market parameter" do
      tracks = described_class.search_by_ids(ids: ids, market: market)

      expect(tracks).to be_an_instance_of(Array)

      tracks.each do |track|
        expect(track).to be_an_instance_of(Spotify::Models::Track)
      end
    end

    example "Missing mandatory parameter (:ids)" do
      tracks = described_class.search_by_ids(market: market)

      expect(tracks).to be_an_instance_of(Hash)
      expect(tracks['error']).to be_present
    end

  end

end
