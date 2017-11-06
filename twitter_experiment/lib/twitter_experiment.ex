defmodule TwitterExperiment do
  @moduledoc """
  Documentation for TwitterExperiment.
  """

  def sign_in do
	# Request twitter for a new token
	token = ExTwitter.request_token("http://www.google.com") # Redirects to google.com (we have to change this to our url later)

	# Generate the url for "Sign-in with twitter".
	# For "3-legged authorization" use ExTwitter.authorize_url instead
	case ExTwitter.authenticate_url(token.oauth_token) do
		{:ok, authenticate_url} -> authenticate_url
		{:error, error_code} -> error_code
	end
  end

  def get_access_token(oauth_token, oauth_verifier) do # This is going to handle the redirection
	case ExTwitter.access_token(oauth_verifier, oauth_token) do
		{:ok, access_token} -> handling_token(access_token)
		{:error, error_code} -> error_code
	end
  end

  def handling_token(access_token) do 
	# Configure ExTwitter to use your newly obtained access token
	ExTwitter.configure(
		consumer_key: Application.get_env(:twitter_experiment, :consumer_key),
   		consumer_secret: Application.get_env(:twitter_experiment, :consumer_secret),
		access_token: access_token.oauth_token,
 		access_token_secret: access_token.oauth_token_secret
	)
  end

  # Gets information of logged user (missing picture)
  def get_information_of_logged_user do
	user = ExTwitter.verify_credentials
	%{:username => user.screen_name, :email => user.email, :name => user.name}
  end

end
