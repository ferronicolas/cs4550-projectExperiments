defmodule SpotifyExperiment do
  @moduledoc """
  Documentation for SpotifyExperiment.
  """

  @doc """
  Hello world.

  ## Examples

      iex> SpotifyExperiment.hello
      :world

  """

  def authorize do
	endpoint = "https://accounts.spotify.com/authorize/"
	client_id = Application.get_env(:spotify_experiment, :client_id)
	response_type = "code"
	scope = "playlist-modify-public"
	redirect_uri = Application.get_env(:spotify_experiment, :callback_url)
	url = endpoint <> "?client_id=" <> client_id <> "&scope=" <> scope <> "&response_type=" <> response_type <> "&redirect_uri=" <> redirect_uri
	case HTTPoison.get(url) do
		{:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
    		IO.puts url
  		{:ok, %HTTPoison.Response{status_code: 404}} ->
    		IO.puts "Not found :("
  		{:error, %HTTPoison.Error{reason: reason}} ->
    		IO.inspect "Aca!"
	end
  end

  def request_tokens(code) do
	# Variables set according to official documentation
	endpoint = "https://accounts.spotify.com/api/token"
	grant_type = "authorization_code"
	redirect_uri = Application.get_env(:spotify_experiment, :callback_url)
	client_id = Application.get_env(:spotify_experiment, :client_id)
	client_secret = Application.get_env(:spotify_experiment, :client_secret)

	body = "grant_type=" <> grant_type <> "&code=" <> code <> "&redirect_uri=" <> redirect_uri

	case HTTPoison.post endpoint, body, [{"Authorization", "Basic " <> Base.encode64(client_id <> ":" <> client_secret)}, {"Content-Type", "application/x-www-form-urlencoded"}] do
		{:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
            parse_tokens(body)
  		{:ok, %HTTPoison.Response{body: body}} ->
            IO.puts "Error!"
  		{:error, %HTTPoison.Error{reason: reason}} ->
            IO.inspect "Aca!"
	end

  end

  def parse_tokens(body) do
	contents = Poison.decode!(body)
	%{"access_token" => contents["access_token"], "refresh_token" => contents["refresh_token"]}
  end

  # Gets the user id
  def get_my_user_id(access_token) do
	endpoint = "https://api.spotify.com/v1/me"
	case HTTPoison.get(endpoint, [{"Authorization", "Bearer " <> access_token}]) do
        {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        	Poison.decode!(body)["id"]
        {:ok, %HTTPoison.Response{status_code: 404}} ->
            IO.puts "Not found :("
        {:error, %HTTPoison.Error{reason: reason}} ->
            IO.inspect "Aca!"
    end
  end

  # Creates playlist
  def create_playlist(playlist_name, user_id, access_token) do
	endpoint = "https://api.spotify.com/v1/users/" <> user_id <> "/playlists"
	body = Poison.encode!(%{"name" => playlist_name})

	case HTTPoison.post(endpoint, body, [{"Authorization", "Bearer " <> access_token}, {"Content-Type", "application/json"}]) do
        {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
         	IO.inspect body   
        {:ok, %HTTPoison.Response{status_code: 201, body: body}} ->
         	IO.inspect body   
		{:ok, response} ->
            IO.inspect "Error " <> response
        {:error, %HTTPoison.Error{reason: reason}} ->
            IO.inspect "Aca!"
    end
  end

  # Searches for a track
  def search_for_track(keyword, access_token) do
	endpoint = "https://api.spotify.com/v1/search"
	type = "track"
	keyword = URI.encode_www_form(keyword)

	endpoint = endpoint <> "?type=" <> type <> "&q=" <> keyword
	case HTTPoison.get(endpoint, [{"Authorization", "Bearer " <> access_token}]) do
        {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
            results = Poison.decode!(body)
        {:ok, %HTTPoison.Response{status_code: 404}} ->
            IO.puts "Not found :("
        {:error, %HTTPoison.Error{reason: reason}} ->
            IO.inspect "Aca!"
    end
  end

  # Adds one song to a playlist 100 times
  def add_song_to_playlist(playlist_id, user_id, track_uri, access_token) do
	endpoint = "https://api.spotify.com/v1/users/" <> user_id <> "/playlists/" <> playlist_id <>"/tracks"
	
	# Create list with 100 items
	list = Enum.map 1..100, fn _ -> track_uri end

	body = Poison.encode!(%{"uris" => list})

	case HTTPoison.post(endpoint, body, [{"Authorization", "Bearer " <> access_token}, {"Content-Type", "application/x-www-form-urlencoded"}]) do
        {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
            IO.inspect body
        {:ok, %HTTPoison.Response{status_code: 201, body: body}} ->
        	IO.inspect body
        {:ok, response} ->
        	IO.inspect response
        {:error, %HTTPoison.Error{reason: reason}} ->
            IO.inspect "Aca!"
    end
  end

end
