defmodule OpenAi.Files do
  @moduledoc """
  Manages the upload, retrieval and deletion of files registered in the OpenAI account.
  """

  alias OpenAi.ApiHelpers

  @doc """
  List all files uploaded in the account.
  """
  def list(configuration \\ nil) do
    Finch.start_link(name: MyFinch)

    headers = ApiHelpers.get_request_headers(configuration)

    url = "#{ApiHelpers.get_base_url(configuration)}/v1/files"

    response =
      Finch.build(:get, url, headers)
      |> Finch.request(MyFinch)

    case response do
      {:ok, %{status: 200, body: body}} ->
        parsed_response = Jason.decode!(body)
        {:ok, parsed_response}

      {:ok, %{status: status, body: body}} ->
        IO.inspect(status)
        IO.inspect(body)
        {:error, "Error. Status: '#{inspect status}', Body: '#{inspect body}'"}

      {:error, reason} ->
        IO.inspect(reason)
        {:error, "Error #{inspect reason}"}
    end
  end
end
