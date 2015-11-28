require 'spec_helper'

describe Spotify::API::User do

  let(:id) { 'tuggareutangranser' }

  context "#search_by_id" do

    example "Success: Performs a simple request" do
      track = described_class.search_by_id(id: id)

      expect(track).to be_an_instance_of(Spotify::Models::Simplified::User)
    end

    example "Error: Missing mandatory parameter (:id)" do
      track = described_class.search_by_id

      expect(track).to be_an_instance_of(Hash)
      expect(track['error']).to be_present
    end

  end

end
