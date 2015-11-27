require 'spec_helper'

describe Spotify::API::Artist do

  let(:id)  { '0OdUWJ0sBjDrqHygGUXeCF' }
  let(:ids) {
    [
      '0oSGxfWSnnOXhD2fKuz2Gy',
      '3dBVyJ7JuOMt4GE9607Qin'
    ]
  }
  let(:country)      { 'US' }
  let(:album_params) {
    {
      id:         '1vCWHaC5f2uS3yhpwWbIA6',
      market:     country,
      album_type: 'single',
      limit:      2,
      offset:     0
    }
  }
  let(:limit_params) {
    {
      id:    id,
      limit: 3
    }
  }
  let(:offset_params)   { limit_params.merge({ offset: 1 }) }
  let(:unique_album)    {
    {
      id:         id,
      album_type: 'single'
    }
  }
  let(:multiple_albums) {
    {
      id:         id,
      album_type: ['album', 'single']
    }
  }

  context '#search_by_id' do

    example "Success: Performs a simple request" do
      artist = described_class.search_by_id(id: id)

      expect(artist).to be_an_instance_of(Spotify::Models::Full::Artist)
    end

    example "Error: Missing mandatory parameter (:id)" do
      artist = described_class.search_by_id

      expect(artist).to be_an_instance_of(Hash)
      expect(artist['error']).to be_present
    end

  end

  context "#search_by_ids" do

    example "Success: Performs a simple request" do
      artists = described_class.search_by_ids(ids: ids)

      expect(artists).to be_an_instance_of(Array)

      artists.each do |artist|
        expect(artist).to be_an_instance_of(Spotify::Models::Full::Artist)
      end
    end

    example "Error: Missing mandatory parameter (:ids)" do
      artist = described_class.search_by_ids

      expect(artist).to be_an_instance_of(Hash)
      expect(artist['error']).to be_present
    end

  end

  context "#top_tracks" do

    example "Success: Performs a simple request" do
      top_tracks = described_class.top_tracks(id: id, country: country)

      expect(top_tracks).to be_an_instance_of(Array)

      top_tracks.each do |top_track|
        expect(top_track).to be_an_instance_of(Spotify::Models::Full::Track)
      end
    end

    example "Error: Missing mandatory parameter (:id)" do
      top_tracks = described_class.top_tracks(country: country)

      expect(top_tracks).to be_an_instance_of(Hash)
      expect(top_tracks['error']).to be_present
    end

    example "Error: Missing mandatory parameter (:country)" do
      top_tracks = described_class.top_tracks(id: id)

      expect(top_tracks).to be_an_instance_of(Hash)
      expect(top_tracks['error']).to be_present
    end

    example "Error: Missing all parameters (:id, :country)" do
      top_tracks = described_class.top_tracks

      expect(top_tracks).to be_an_instance_of(Hash)
      expect(top_tracks['error']).to be_present
    end

  end

  context "#related_artists" do

    example "Success: Performs a simple request" do
      artists = described_class.related_artists(id: id)

      expect(artists).to be_an_instance_of(Array)

      artists.each do |artist|
        expect(artist).to be_an_instance_of(Spotify::Models::Full::Artist)
      end
    end

    example "Error: Missing mandatory parameter (:id)" do
      artists = described_class.related_artists

      expect(artists).to be_an_instance_of(Hash)
      expect(artists['error']).to be_present
    end

  end

  context "#albums" do

    example "Success: Performs a simple request" do
      albums = described_class.albums(id: id)

      expect(albums).to be_an_instance_of(Spotify::Models::Paging)
      expect(albums.items).to be_an_instance_of(Array)
    end

    example "Error: Missing mandatory parameter (:id)" do
      albums = described_class.albums

      expect(albums).to be_an_instance_of(Hash)
      expect(albums['error']).to be_present
    end

    example "Success: Limiting results" do
      albums = described_class.albums(album_params.merge(limit_params))

      expect(albums.items.size).to be_eql(3)
    end

    example "Success: Offseting results" do
      original_albums = described_class.albums(album_params.merge(limit_params))
      offset_albums   = described_class.albums(album_params.merge(offset_params))

      expect(original_albums.items[1].id).to be_eql(offset_albums.items[0].id)
    end

    example "Success: With album type (:album_type)" do
      albums = described_class.albums(unique_album)

      expect(albums).to be_an_instance_of(Spotify::Models::Paging)
      expect(albums.items).to be_an_instance_of(Array)
    end

    example "Success: With multiple album types (:album_type)" do
      albums = described_class.albums(multiple_albums)

      expect(albums).to be_an_instance_of(Spotify::Models::Paging)
      expect(albums.items).to be_an_instance_of(Array)
    end

    example "Success: With all acceptable parameters" do
      albums = described_class.albums(album_params)

      expect(albums).to be_an_instance_of(Spotify::Models::Paging)
      expect(albums.items).to be_an_instance_of(Array)
    end

  end

end
