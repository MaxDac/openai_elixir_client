defmodule OpenAi.ApiHelpers do
  @moduledoc """
  Helper functions to call OpenAi API.
  """

  alias OpenAi.Dtos.Configuration

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
end
