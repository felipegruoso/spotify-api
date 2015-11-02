require 'spec_helper'

describe Spotify::API::Artist do

  let(:id)     { '0OdUWJ0sBjDrqHygGUXeCF' }
  let(:ids)    { ['0oSGxfWSnnOXhD2fKuz2Gy', '3dBVyJ7JuOMt4GE9607Qin']}
  let(:country) { 'US' }

  # context '#search_by_id' do

  #   example "Performs a simple request" do
  #     artist = described_class.search_by_id(id: id)

  #     expect(artist).to be_an_instance_of(Spotify::Models::Artist)
  #   end

  #   example "Missing mandatory parameter (:id)" do
  #     artist = described_class.search_by_id

  #     expect(artist).to be_an_instance_of(Hash)
  #     expect(artist['error']).to be_present
  #   end

  # end

  # context "#search_by_ids" do

  #   example "Performs a simple request" do
  #     artists = described_class.search_by_ids(ids: ids)

  #     expect(artists).to be_an_instance_of(Array)

  #     artists.each do |artist|
  #       expect(artist).to be_an_instance_of(Spotify::Models::Artist)
  #     end
  #   end

  #   example "Missing mandatory parameter (:ids)" do
  #     artist = described_class.search_by_ids

  #     expect(artist).to be_an_instance_of(Hash)
  #     expect(artist['error']).to be_present
  #   end

  # end

  # context "#top_tracks" do

  #   example "Performs a simple request" do
  #     top_tracks = described_class.top_tracks(id: id, country: country)

  #     expect(top_tracks).to be_an_instance_of(Array)

  #     top_tracks.each do |top_track|
  #       expect(top_track).to be_an_instance_of(Spotify::Models::Track)
  #     end
  #   end

  #   example "Missing mandatory parameter (:id)" do
  #     top_tracks = described_class.top_tracks(country: country)

  #     expect(top_tracks).to be_an_instance_of(Hash)
  #     expect(top_tracks['error']).to be_present
  #   end

  #   example "Missing mandatory parameter (:country)" do
  #     top_tracks = described_class.top_tracks(id: id)

  #     expect(top_tracks).to be_an_instance_of(Hash)
  #     expect(top_tracks['error']).to be_present
  #   end

  #   example "Missing all parameters (:id, :country)" do
  #     top_tracks = described_class.top_tracks

  #     expect(top_tracks).to be_an_instance_of(Hash)
  #     expect(top_tracks['error']).to be_present
  #   end

  # end

  # context "#related_artists" do

  #   example "Performs a simple request" do
  #     artists = described_class.related_artists(id: id)

  #     expect(artists).to be_an_instance_of(Array)

  #     artists.each do |artist|
  #       expect(artist).to be_an_instance_of(Spotify::Models::Artist)
  #     end
  #   end

  #   example "Missing mandatory parameter (:id)" do
  #     artists = described_class.related_artists

  #     expect(artists).to be_an_instance_of(Hash)
  #     expect(artists['error']).to be_present
  #   end

  # end

  context "#albums" do

    example "Performs a simple request" do
      albums = described_class.albums(id: id)

      expect(albums).to be_an_instance_of(Spotify::Models::Paging)
    end

  end

end
