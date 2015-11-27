require 'spec_helper'

describe Spotify::API::Track do

  let(:id)     { '0eGsygTp906u18L0Oimnem' }
  let(:ids)    { ["0eGsygTp906u18L0Oimnem", "1lDWb6b6ieDQ2xT7ewTC3G"] }
  let(:market) { 'US' }

  context "#search_by_id" do

    example "Success: Performs a simple request" do
      track = described_class.search_by_id(id: id)

      expect(track).to         be_an_instance_of(Spotify::Models::Full::Track)
      expect(track.album).to   be_an_instance_of(Spotify::Models::Simplified::Album)
      expect(track.artists).to be_an_instance_of(Array)

      track.artists.each do |artist|
        expect(artist).to be_an_instance_of(Spotify::Models::Simplified::Artist)
      end
    end

    example "Success: Uses market parameter" do
      track = described_class.search_by_id(id: id, market: market)

      expect(track).to be_an_instance_of(Spotify::Models::Full::Track)
      expect(track.linked_from).to be_present
    end

    example "Error: Missing mandatory parameter (:id)" do
      track = described_class.search_by_id

      expect(track).to be_an_instance_of(Hash)
      expect(track['error']).to be_present
    end

  end

  context "#search_by_ids" do

    example "Success: Performs a simple request" do
      tracks = described_class.search_by_ids(ids: ids)

      expect(tracks).to be_an_instance_of(Array)

      tracks.each do |track|
        expect(track).to be_an_instance_of(Spotify::Models::Full::Track)
      end
    end

    example "Success: Uses market parameter" do
      tracks = described_class.search_by_ids(ids: ids, market: market)

      expect(tracks).to be_an_instance_of(Array)

      tracks.each do |track|
        expect(track).to be_an_instance_of(Spotify::Models::Full::Track)
      end
    end

    example "Error: Missing mandatory parameter (:ids)" do
      tracks = described_class.search_by_ids(market: market)

      expect(tracks).to be_an_instance_of(Hash)
      expect(tracks['error']).to be_present
    end

  end

end
