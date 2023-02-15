defmodule OpenAi do
  @moduledoc """
  Some test calling OpenAI API.
  """

  alias OpenAi.ApiHelpers
  alias OpenAi.Dtos.Request
  alias OpenAi.Dtos.State

  @completion_type "text-davinci-003"
  @base_url "https://api.openai.com"

  @spec call_completion_api(
    prompt :: binary(),
    session :: list(State.t()),
    configuration :: OpenAi.Dtos.Configuration.t() | nil
  ) :: {:ok, list(Session.t())} | {:error, binary()}
  def call_completion_api(prompt, session \\ [], configuration \\ nil) do
    Finch.start_link(name: MyFinch)

    headers = ApiHelpers.get_request_headers(configuration)

    {url, request} = create_completion_request(session, prompt)

    response =
      Finch.build(:post, url, headers, Jason.encode!(request) |> IO.inspect(label: "Request"))
      |> Finch.request(MyFinch)

    case response do
      {:ok, %{status: 200, body: body}} ->
        parsed_response = Jason.decode!(body)
        {:ok, [%State{
          session_id: parsed_response["id"],
          last_request: request,
          last_response: parsed_response
        } | session]}

      {:ok, %{status: status, body: body}} ->
        IO.inspect(status)
        IO.inspect(body)
        {:error, "Error. Status: '#{inspect status}', Body: '#{inspect body}'"}

      {:error, reason} ->
        IO.inspect(reason)
        {:error, "Error #{inspect reason}"}

    end
  end

  defp create_completion_request(session, prompt) do
    new_prompt = join_session_inputs(prompt, session)

    # Create a request
    request = %Request{
      model: @completion_type,
      prompt: new_prompt,
      max_tokens: 200,
      temperature: 0,
      top_p: 1,
      frequency_penalty: 0,
      presence_penalty: 0,
      stop: ["\\n"]
    }

    url = "#{@base_url}/v1/completions"

    {url, request}
  end

  defp join_session_inputs(prompt, session) do
    old_prompt = 
      session
      |> Enum.map(fn %{last_request: %{prompt: prompt}} -> prompt end)
      |> Enum.join("\n")

    prompt <> "\n" <> old_prompt
  end
end
