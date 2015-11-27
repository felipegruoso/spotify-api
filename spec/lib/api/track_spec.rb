require 'spec_helper'

describe Spotify::API::Track do

  let(:id)     { '0eGsygTp906u18L0Oimnem' }
  let(:ids)    { ["0eGsygTp906u18L0Oimnem", "1lDWb6b6ieDQ2xT7ewTC3G"] }
  let(:market) { 'US' }
  let(:limit_params)  { { limit: 3 } }
  let(:offset_params) { limit_params.merge({ offset: 1 }) }
  let(:search_params) { { q: 'How' } }

  context "#search" do

    example "Success: Performs a simple request" do
      tracks = described_class.search(search_params)

      expect(tracks).to be_an_instance_of(Spotify::Models::Paging)

      tracks.items.each do |track|
        expect(track).to be_an_instance_of(Spotify::Models::Full::Track)
      end
    end

    example "Success: Uses market parameter" do
      tracks = described_class.search(search_params.merge({ market: market }))

      expect(tracks).to be_an_instance_of(Spotify::Models::Paging)

      tracks.items.each do |track|
        expect(track).to be_an_instance_of(Spotify::Models::Full::Track)
      end
    end

    example "Success: Limiting results" do
      tracks = described_class.search(search_params.merge(limit_params))

      expect(tracks).to be_an_instance_of(Spotify::Models::Paging)
      expect(tracks.items.size).to be_eql(3)
    end

    example "Success: Offseting results" do
      offset = search_params.merge(offset_params)

      original_tracks = described_class.search(search_params)
      offset_tracks   = described_class.search(offset)

      expect(original_tracks.items[1].id).to be_eql(offset_tracks.items[0].id)
    end

    example "Success: Using all parameters" do
      params = search_params.merge(offset_params).merge(limit_params)
      params = params.merge({ market: market})

      tracks = described_class.search(params)

      expect(tracks).to be_an_instance_of(Spotify::Models::Paging)

      tracks.items.each do |track|
        expect(track).to be_an_instance_of(Spotify::Models::Full::Track)
      end
    end

    example "Error: Missing mandatory parameter (:q)" do
      tracks = described_class.search

      expect(tracks).to be_an_instance_of(Hash)
      expect(tracks['error']).to be_present
    end

  end

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
