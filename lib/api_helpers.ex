defmodule OpenAi.ApiHelpers do
  @moduledoc """
  Helper functions to call OpenAi API.
  """

  @base_url "https://api.openai.com"

  alias OpenAi.Dtos.Configuration

  @type header() :: {binary(), binary()}

  @doc """
  Checks whether the string is nil or whitespace.
  """
  defguard is_nil_or_whitespace(string) when is_nil(string) or string == "" or string == " "

  @doc """
  Returns the header to attach to the OpenAI request.
  """
  @spec get_request_headers(configuration :: Configuration.t() | nil) :: list(header())
  def get_request_headers(configuration \\ nil)

  def get_request_headers(nil), do: get_request_headers(%Configuration{
    key: System.get_env("OPENAI_API_KEY")
  })

  def get_request_headers(%{key: key}) do
    [
      {"Content-Type", "application/json"},
      {"Authorization", "Bearer #{key}"}
    ]
  end

  @doc """
  Returns the base url for OpenAI.
  This can be changed in the configuration.
  """
  @spec get_base_url(configuration :: Configuration.t() | nil) :: binary()
  def get_base_url(configuration \\ nil)
  def get_base_url(%{base_url: base_url}) when not(is_nil_or_whitespace(base_url)), do: base_url
  def get_base_url(nil), do: @base_url
end
