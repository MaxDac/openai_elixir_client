defmodule OpenAi do
  @moduledoc """
  Some test calling OpenAI API.
  """

  @completion_type "text-davinci-003"

  def call_completion_api do
    # Create a request
    request = %Request{
      model: @completion_type,
      prompt: "I would like to play a game with you. You move first.",
      max_tokens: 20,
      temperature: 0,
      top_p: 1,
      frequency_penalty: 0,
      presence_penalty: 0,
      stop: ["\\n"]
    }

    headers = [
      {"Content-Type", "application/json"},
      {"Authorization", "Bearer #{System.get_env("OPENAI_API_KEY")}}"}
    ]

    Finch.start_link(name: MyFinch)

    response =        
      Finch.build(:post, "https://api.openai.com/v1/completions", headers, Jason.encode!(request))
      |> Finch.request(MyFinch)

    case response do
      {:ok, %{status: 200, body: body}} ->
        Jason.decode!(body)
        |> IO.inspect(label: "Response")

      {:ok, %{status: status, body: body}} ->
        IO.inspect(status)
        IO.inspect(body)
        "Error"

      {:error, reason} ->
        IO.inspect(reason)
        "Error"
    end
  end

  def call_test_server do
    Finch.start_link(name: MyFinch)

    headers = [
      {"Content-Type", "application/json"}
    ]

    request = %{
      name: "John Doe"
    }

    Finch.build(:post, "http://localhost:3000/api", headers, Jason.encode!(request))
    |> Finch.request(MyFinch)
  end
end
