# Spotify::API

This gem was developed with the purpose of retrieve information from [Spotify](https://spotify.com/) service by using its API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'spotify-api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install spotify-api

## Usage

require 'spotify'

### Albums
albums_api = Spotify::API::Albums

albums_api.search_by_id(id: '')    # => Spotify::Models::Full::Album
albums_api.search_by_ids(ids: [])  # => [Spotify::Models::Full::Album]

tracks = albums_api.tracks(id: '') # => Spotify::Models::Paging
tracks.items                       # => [Spotify::Models::Simplified::Track]

### Tracks
tracks_api = Spotify::API::Track

tracks_api.search_by_id(id: '')   # => Spotify::Models::Full::Track
tracks_api.search_by_ids(ids: '') # => [Spotify::Models::Full::Track]

### Artists
artists_api = Spotify::API::Artist

artists_api.search_by_id(id: '')   # => Spotify::Models::Full::Artist
artists_api.search_by_ids(ids: '') # => [Spotify::Models::Full::Artist]

albums = artists_api.albums(id: '') # => Spotify::Models::Paging
albums.items                        # => Spotify::Models::Simplified::Album

top_tracks = artists_api.top_tracks(id: '') # => Spotify::Models::Paging
top_tracks.items                            # => Spotify::Models::Full::Track

related_artists = artists_api.related_artists(id: '') # => Spotify::Models::Paging
related_artists.items                                 # => [Spotify::Models::Full::Artist]

## Todo

The following table shows all API endpoints and if each one is already implemented or not.

| Method | EndPoints                                                      | Implemented? |
| GET    | /v1/albums/{id}                                                | YES          |
| GET    | /v1/albums?ids={ids}                                           | YES          |
| GET    | /v1/albums/{id}/tracks                                         | YES          |
| GET    | /v1/artists/{id}                                               | YES          |
| GET    | /v1/artists?ids={ids}                                          | YES          |
| GET    | /v1/artists/{id}/albums                                        | YES          |
| GET    | /v1/artists/{id}/top-tracks                                    | YES          |
| GET    | /v1/artists/{id}/related-artists                               | YES          |
| GET    | /v1/browse/featured-playlists                                  | NO           |
| GET    | /v1/browse/new-releases                                        | NO           |
| GET    | /v1/browse/categories                                          | NO           |
| GET    | /v1/browse/categories/{id}                                     | NO           |
| GET    | /v1/browse/categories/{id}/playlists                           | NO           |
| GET    | /v1/me                                                         | NO           |
| GET    | /v1/me/following                                               | NO           |
| PUT    | /v1/me/following                                               | NO           |
| DELETE | /v1/me/following                                               | NO           |
| GET    | /v1/me/following/contains                                      | NO           |
| PUT    | /v1/users/{owner_id}/playlists/{playlist_id}/followers         | NO           |
| DELETE | /v1/users/{owner_id}/playlists/{playlist_id}/followers         | NO           |
| PUT    | /v1/me/tracks?ids={ids}                                        | NO           |
| GET    | /v1/me/tracks                                                  | NO           |
| DELETE | /v1/me/tracks?ids={ids}                                        | NO           |
| GET    | /v1/me/tracks/contains?ids={ids}                               | NO           |
| PUT    | /v1/me/albums?ids={ids}                                        | NO           |
| GET    | /v1/me/albums                                                  | NO           |
| DELETE | /v1/me/albums?ids={ids}                                        | NO           |
| GET    | /v1/me/albums/contains?ids={ids}                               | NO           |
| GET    | /v1/search?type=album                                          | YES          |
| GET    | /v1/search?type=artist                                         | YES          |
| GET    | /v1/search?type=playlist                                       | YES          |
| GET    | /v1/search?type=track                                          | YES          |
| GET    | /v1/tracks/{id}                                                | YES          |
| GET    | /v1/tracks?ids={ids}                                           | YES          |
| GET    | /v1/users/{user_id}                                            | YES          |
| GET    | /v1/users/{user_id}/playlists                                  | NO           |
| GET    | /v1/me/playlists                                               | NO           |
| GET    | /v1/users/{user_id}/playlists/{playlist_id}                    | NO           |
| GET    | /v1/users/{user_id}/playlists/{playlist_id}/tracks             | NO           |
| POST   | /v1/users/{user_id}/playlists                                  | NO           |
| PUT    | /v1/users/{user_id}/playlists/{playlist_id}                    | NO           |
| POST   | /v1/users/{user_id}/playlists/{playlist_id}/tracks             | NO           |
| DELETE | /v1/users/{user_id}/playlists/{playlist_id}/tracks             | NO           |
| PUT    | /v1/users/{user_id}/playlists/{playlist_id}/tracks             | NO           |
| PUT    | /v1/users/{user_id}/playlists/{playlist_id}/tracks             | NO           |
| GET    | /v1/users/{user_id}/playlists/{playlist_id}/followers/contains | NO           |

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

1. Fork it ( https://github.com/felipegruoso/spotify-api/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
