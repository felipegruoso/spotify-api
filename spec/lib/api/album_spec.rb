require 'spec_helper'

describe Spotify::API::Album do

  let(:id)     { '0sNOF9WDwhWunNAHPD3Baj' }
  let(:ids)    { ["6JWc4iAiJ9FjyK0B59ABb4", "6UXCm6bOO4gFlDQZV5yL37"] }
  let(:market) { 'US' }

  context "#search_by_id" do

    example "Performs a simple request" do
      album = described_class.search_by_id(id: id)

      expect(album).to be_an_instance_of(Spotify::Models::Album)
      expect(album.tracks).to be_an_instance_of(Spotify::Models::Paging)

      album.tracks.items.each do |track|
        expect(track).to be_an_instance_of(Spotify::Models::Track)
      end
    end

    example "Uses market parameter" do
      album = described_class.search_by_id(id: id, market: market)

      expect(album).to be_an_instance_of(Spotify::Models::Album)
      expect(album.tracks).to be_an_instance_of(Spotify::Models::Paging)

      album.tracks.items.each do |track|
        expect(track).to be_an_instance_of(Spotify::Models::Track)
      end
    end

    example "Missing mandatory parameter (:id)" do
      album = described_class.search_by_id

      expect(album).to be_an_instance_of(Hash)
      expect(album['error']).to be_present
    end

  end

  context "#search_by_ids" do

    example "Performs a simple request" do
      albums = described_class.search_by_ids(ids: ids)

      expect(albums).to be_an_instance_of(Array)

      albums.each do |album|
        expect(album).to be_an_instance_of(Spotify::Models::Album)
      end
    end

    example "Uses market parameter" do
      albums = described_class.search_by_ids(ids: ids, market: market)

      expect(albums).to be_an_instance_of(Array)

      albums.each do |album|
        expect(album).to be_an_instance_of(Spotify::Models::Album)
      end
    end

    example "Missing mandatory parameter (:ids)" do
      albums = described_class.search_by_ids(market: market)

      expect(albums).to be_an_instance_of(Hash)
      expect(albums['error']).to be_present
    end

  end

end
