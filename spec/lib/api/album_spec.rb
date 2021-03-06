require 'spec_helper'

describe Spotify::API::Album do

  let(:id)            { '0sNOF9WDwhWunNAHPD3Baj' }
  let(:ids)           { ["6JWc4iAiJ9FjyK0B59ABb4", "6UXCm6bOO4gFlDQZV5yL37"] }
  let(:market)        { 'US' }
  let(:limit_params)  { { id: id, limit: 3 } }
  let(:offset_params) { { id: id, offset: 1 } }
  let(:search_params) { { q: "She's So Unusual" } }

  context "#search" do

    example "Success: Performs a simple request" do
      albums = described_class.search(search_params)

      expect(albums).to be_an_instance_of(Spotify::Models::Paging)

      albums.items.each do |album|
        expect(album).to be_an_instance_of(Spotify::Models::Simplified::Album)
      end
    end

    example "Success: Uses market parameter" do
      albums = described_class.search(search_params.merge({ market: market }))

      expect(albums).to be_an_instance_of(Spotify::Models::Paging)

      albums.items.each do |album|
        expect(album).to be_an_instance_of(Spotify::Models::Simplified::Album)
      end
    end

    example "Success: Limiting results" do
      albums = described_class.search(search_params.merge(limit_params))

      expect(albums).to be_an_instance_of(Spotify::Models::Paging)
      expect(albums.items.size).to be_eql(3)
    end

    example "Success: Offseting results" do
      offset = search_params.merge(offset_params)

      original_albums = described_class.search(search_params)
      offset_albums   = described_class.search(offset)

      expect(original_albums.items[1].id).to be_eql(offset_albums.items[0].id)
    end

    example "Success: Using all parameters" do
      params = search_params.merge(offset_params).merge(limit_params)
      params = params.merge({ market: market})

      albums = described_class.search(params)

      expect(albums).to be_an_instance_of(Spotify::Models::Paging)

      albums.items.each do |album|
        expect(album).to be_an_instance_of(Spotify::Models::Simplified::Album)
      end
    end

    example "Error: Missing mandatory parameter (:q)" do
      albums = described_class.search

      expect(albums).to be_an_instance_of(Spotify::Models::Error)
    end

  end

  context "#search_by_id" do

    example "Success: Performs a simple request" do
      album = described_class.search_by_id(id: id)

      expect(album).to be_an_instance_of(Spotify::Models::Full::Album)
      expect(album.tracks).to be_an_instance_of(Spotify::Models::Paging)

      album.tracks.items.each do |track|
        expect(track).to be_an_instance_of(Spotify::Models::Simplified::Track)
      end
    end

    example "Success: Uses market parameter" do
      album = described_class.search_by_id(id: id, market: market)

      expect(album).to be_an_instance_of(Spotify::Models::Full::Album)
      expect(album.tracks).to be_an_instance_of(Spotify::Models::Paging)

      album.tracks.items.each do |track|
        expect(track).to be_an_instance_of(Spotify::Models::Simplified::Track)
      end
    end

    example "Error: Missing mandatory parameter (:id)" do
      album = described_class.search_by_id

      expect(album).to be_an_instance_of(Spotify::Models::Error)
    end

  end

  context "#search_by_ids" do

    example "Success: Performs a simple request" do
      albums = described_class.search_by_ids(ids: ids)

      expect(albums).to be_an_instance_of(Array)

      albums.each do |album|
        expect(album).to be_an_instance_of(Spotify::Models::Full::Album)
      end
    end

    example "Success: Uses market parameter" do
      albums = described_class.search_by_ids(ids: ids, market: market)

      expect(albums).to be_an_instance_of(Array)

      albums.each do |album|
        expect(album).to be_an_instance_of(Spotify::Models::Full::Album)
      end
    end

    example "Error: Missing mandatory parameter (:ids)" do
      albums = described_class.search_by_ids(market: market)

      expect(albums).to be_an_instance_of(Spotify::Models::Error)
    end

  end

  context '#tracks' do

    example "Success: Performs a simple request" do
      tracks = described_class.tracks(id: id)

      expect(tracks).to be_an_instance_of(Spotify::Models::Paging)

      tracks.items.each do |track|
        expect(track).to be_an_instance_of(Spotify::Models::Simplified::Track)
      end
    end

    example "Success: Uses market parameter" do
      tracks = described_class.tracks(id: id, market: market)

      expect(tracks).to be_an_instance_of(Spotify::Models::Paging)

      tracks.items.each do |track|
        expect(track).to be_an_instance_of(Spotify::Models::Simplified::Track)
      end
    end

    example "Success: Limiting results" do
      tracks = described_class.tracks(limit_params)

      expect(tracks.items.size).to be_eql(3)
    end

    example "Success: Offseting results" do
      original_tracks = described_class.tracks(limit_params)
      offset_tracks   = described_class.tracks(offset_params)

      expect(original_tracks.items[1].id).to be_eql(offset_tracks.items[0].id)
    end

  end

end
